import json
from os import path

import pandas as pd
import requests

from generators import get_logger, default_headers
from generators.impl.base_generator import BaseGenerator, Entity


class CountryGen(BaseGenerator):
    data_file_name = "countries_complete_info.csv"
    countries_json_url = "https://raw.githubusercontent.com/mledoze/countries/master/dist/countries.json"

    def __init__(self):
        self.log = get_logger("currency_generator")

    def get_generator_name(self):
        return path.basename(__file__)

    def generate(self, working_dir):
        """ Generates de SQL inserts for currencies

        Args:

        """
        self.log.info("Step 1. Get the data.")
        df = self.get_data(working_dir)

        self.log.info("Step 2. Generate the SQL inserts for the country table")
        self.generate_countries_sql_inserts(df, working_dir)

        self.log.info("Step 3. Generate the SQL inserts for the translation table")
        self.generate_translations_sql_inserts(df, working_dir)

    def get_data(self, working_dir) -> pd.DataFrame:
        data_file_path = path.join(working_dir, self.data_file_name)

        if not path.isfile(data_file_path):
            self.log.info("The data does't exist in the directory. Downloading from the web.")
            return self.get_data_from_web(working_dir)

        self.log.info("\t * Reading the data from cache.")
        df = pd.read_csv(data_file_path, index_col=0, dtype={'ccn3': object})

        return df.fillna(' ')

    def get_data_from_web(self, working_dir) -> pd.DataFrame:
        """
        code ISO 3166-1 numeric (ccn3)
        code ISO 3166-1 alpha-3 (cca3)
        International Direct Dialing info (idd)
        :param working_dir:
        :return:
        """
        self.log.info("\t * Downloading the file: {}".format(self.countries_json_url))
        countries = requests.get(self.countries_json_url, headers=default_headers).json()

        columns = [
            'name', 'officialName', 'capital', 'idd',  'region', 'subregion', 'currencies', 'ccn3', 'cca3'
        ]

        df_dict = {}

        for country in countries:
            for key, jsonObject in country.items():
                if key in columns:
                    if key == 'name':
                        self.insert(df_dict, 'name', jsonObject['common'])
                        self.insert(df_dict, 'officialName', jsonObject['official'])
                    elif key == 'capital' or key == 'callingCode':
                        self.insert(df_dict, key, jsonObject[0] if len(jsonObject) > 0 else 'null')
                    elif key == 'currencies':
                        currencies = ", ".join([alpha_code for alpha_code in jsonObject])
                        self.insert(df_dict, "currencies", currencies)

                    elif key == 'idd':
                        root = jsonObject['root']
                        suffixes = [suffix for suffix in jsonObject['suffixes']]

                        idd = '' if len(root.strip()) == 0 and len(suffixes) == 0 else \
                            ("{} ({})".format(root, ", ".join(suffixes)) if len(suffixes) != 0 else root)

                        self.insert(df_dict, "idd", idd)
                    else:
                        self.insert(df_dict, key, jsonObject)
                elif key == "translations":
                    spanish_official_name = jsonObject["spa"]["official"] if "spa" in jsonObject else ''
                    spanish_common_name = jsonObject["spa"]["common"] if "spa" in jsonObject else ''

                    self.insert(df_dict, "spanishOfficialName", spanish_official_name)
                    self.insert(df_dict, "spanishCommonName", spanish_common_name)

        df = pd.DataFrame(df_dict)
        df.to_csv(path.join(working_dir, self.data_file_name), index_label="Id")
        return df

    def generate_countries_sql_inserts(self, df, working_dir):
        """
          Generates de SQL inserts for the country entity
        :param df: Data frame with the countries information
        :param working_dir: Directory where the script will be saved
        """

        sql_inserts = [
            "( {:3d}, {:5s}, {:5s}, {:28s} )".format(
                index + 1, self.get_string(row['ccn3']), self.get_string(row['cca3']), self.get_string(row['idd'])
            ) for index, row in df.iterrows()
        ]

        self.write(
            "country.sql", working_dir, Entity.COUNTRY, sql_inserts, [self.countries_json_url]
        )

    def generate_translations_sql_inserts(self, df, working_dir):
        language_df = pd.read_csv(path.join(working_dir, "iso_639_3.csv"), index_col=0)
        spanish_index = language_df.index[language_df.Part1 == "es"][0] + 1
        english_index = language_df.index[language_df.Part1 == "en"][0] + 1

        translation_data = []
        country_translation_data = []

        translation_id = self.get_initial_translation_id(working_dir)

        for index, row in df.iterrows():
            # Spanish Data
            translation_data.append(
                "({:4d}, {:4d}, \'{}\')".format(
                    translation_id, spanish_index,
                    json.dumps({"name": row["spanishOfficialName"], "officialName": row["spanishCommonName"]})
                )
            )

            country_translation_data.append("({:4d}, {:4d}, {:4d})".format(
                   index + 1, index + 1, translation_id
               )
            )

            # English Data
            translation_data.append(
                "({:4d}, {:4d}, \'{}\')".format(
                    translation_id + 1, english_index,
                    json.dumps(
                        {
                            "name": row["name"], "officialName": row["officialName"], "capital": row["capital"],
                            "region": row["region"], "subregion": row["subregion"]
                        }
                    )
                )
            )

            country_translation_data.append("({:4d}, {:4d}, {:4d})".format(
                    index + 1, index + 1, translation_id + 1
                )
            )

            translation_id += 2

        self.write(
           "translation.sql", working_dir, Entity.TRANSLATION, translation_data, [self.countries_json_url]
        )

        self.write(
            "currency_translation.sql", working_dir, Entity.CURRENCY_TRANSLATION,
            country_translation_data, [self.countries_json_url]
        )

    def generate_country_currency_sql_inserts(self, df, working_dir):
        currency_df = pd.read_csv(path.join(working_dir, "currencies_complete_info.csv"), index_col=0)

    @staticmethod
    def insert(d, k, v):
        if k not in d:
            d[k] = [v]
        else:
            d[k].append(v)

    @staticmethod
    def get_string(value):
        return '\'{}\''.format(value.replace("'", "''")) if value.strip() else 'null'

    @staticmethod
    def get_initial_translation_id(working_dir):
        translation_file_path = path.join(working_dir, "translation.sql")

        if not path.isfile(translation_file_path):
            return 1

        with open(translation_file_path, 'r') as f:
            lines = f.readlines()

            last_line_index = -1

            while not lines[last_line_index].lstrip().startswith('('):
                last_line_index -= 1

            return int(lines[last_line_index].split(',')[0].replace('(', '')) + 1


