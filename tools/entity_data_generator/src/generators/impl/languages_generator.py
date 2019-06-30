from io import BytesIO
from os import path
from zipfile import ZipFile

import pandas as pd
import requests
from bs4 import BeautifulSoup

from generators import get_logger, default_headers
from generators.impl.base_generator import BaseGenerator, Entity


class LanguageGen(BaseGenerator):

    iso_639_3_url = 'https://iso639-3.sil.org/code_tables/download_tables'

    data_file_name = 'iso_639_3.csv'

    language_types = pd.DataFrame(
        data=[
            ['A', 'Ancient'],
            ['C', 'Constructed'],
            ['E', 'Extinct'],
            ['H', 'Historical'],
            ['L', 'Living'],
            ['S', 'Special']
        ],
        columns=['Type', 'Name']
    )

    language_scopes = pd.DataFrame(
        data=[
            ['I', 'Individual'],
            ['M', 'Macro Language'],
            ['S', 'Special']
        ],
        columns=['Scope', 'Name']
    )

    def __init__(self):
        self.log = get_logger("language_generator")

    def get_generator_name(self):
        return path.basename(__file__)

    def generate(self, working_dir):
        self.log.info("Step 1. Get the data.")
        df = self.get_data(working_dir)

        self.log.info("Step 2. Generate the SQL inserts for the language table")
        self.generate_languages_sql_inserts(df, working_dir)
        self.generate_language_type(working_dir)
        self.generate_language_scopes(working_dir)

    def get_data(self, working_dir) -> pd.DataFrame:
        data_file_path = path.join(working_dir, self.data_file_name)

        if not path.isfile(data_file_path):
            self.log.info("The data does't exist in the directory. Downloading from the web.")
            zip_file_url = self.get_table_url()
            return self.get_data_from_web(working_dir, zip_file_url)

        self.log.info("\t * Reading the data from cache.")
        return pd.read_csv(data_file_path,  index_col=0)

    def get_data_from_web(self, working_dir, zip_file_url) -> pd.DataFrame:
        self.log.info("\t * Downloading the file: {}".format(zip_file_url))
        response = requests.get(zip_file_url, headers=default_headers).content
        zipfile = ZipFile(BytesIO(response))

        iso_date = zip_file_url.split("_")[-1].replace(".zip", "")
        table_name = "iso-639-3_{}.tab".format(iso_date)
        self.log.info("\t * Reading the file {}.".format(table_name))
        df = pd.read_csv(
            filepath_or_buffer=zipfile.open("iso-639-3_Code_Tables_{0}/iso-639-3_{0}.tab".format(iso_date)), sep='\t'
        )
        df = df.drop(["Comment"], axis=1)                     \
               .dropna()                                      \
               .sort_values("Id")                             \
               .rename(index=str, columns={"Id": "Iso6391"})  \
               .reset_index()                                 \
               .drop(["index"], axis=1)

        df.to_csv(path.join(working_dir, self.data_file_name), index_label='Id')

        return df

    def get_table_url(self) -> str:
        """
            Get the latest link to the complete set of codes for the ISO 639
        :return:
        """
        self.log.info("\t * Get the link of the latest zip file.")
        download_tables_page = requests.get(self.iso_639_3_url, headers=default_headers)
        parser = BeautifulSoup(download_tables_page.text, 'html.parser')

        complete_set_list = parser.select("section#block-block-931 ul")[0]

        return next(complete_set_list.children).find("a").attrs["href"]

    def generate_languages_sql_inserts(self, df, working_dir):
        """
           Generates de SQL inserts for the currency entity
        :param df: Data frame with the languages information
        :param working_dir: Directory where the script will be saved
        """

        sql_inserts = [
           "( {:4d}, \'{:60s}\', \'{}\', \'{}\', \'{:3s}\', \'{:3s}\', \'{:3s}\', \'{:2s}\' )".format(
                index + 1, row['Ref_Name'], self.get_lang_type_index(row['Language_Type']),
                self.get_scope_index(row['Scope']),
                row['Iso6391'], row['Part2B'], row['Part2T'], row['Part1']
           ) for index, row in df.iterrows()
        ]

        self.write(
           working_dir, Entity.LANGUAGE, sql_inserts, [self.iso_639_3_url]
        )

    def generate_language_type(self, working_dir):
        """
           Generates de SQL inserts for the language_type entity
        :param working_dir: Directory where the script will be saved
        """

        sql_inserts = [
            "( {}, \'{}\', \'{:12s}\')".format(index + 1, row['Type'], row['Name'])
            for index, row in self.language_types.iterrows()
        ]

        self.write(
            working_dir, Entity.LANGUAGE_TYPE, sql_inserts, [self.iso_639_3_url]
        )

    def generate_language_scopes(self, working_dir):
        """
           Generates de SQL inserts for the language_scope entity
        :param working_dir: Directory where the script will be saved
        """

        sql_inserts = [
            "( {}, \'{}\', \'{:15s}\')".format(index + 1, row['Scope'], row['Name'])
            for index, row in self.language_scopes.iterrows()
        ]

        self.write(
            working_dir, Entity.LANGUAGE_SCOPE, sql_inserts, [self.iso_639_3_url]
        )

    def get_scope_index(self, value):
        return self.language_scopes.index[self.language_scopes.Scope == value][0] + 1

    def get_lang_type_index(self, value):
        return self.language_types.index[self.language_types.Type == value][0] + 1
