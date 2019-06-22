import xml.etree.ElementTree as ET
from os import path

import bs4
import pandas as pd
import requests
from bs4 import BeautifulSoup

from generators import default_headers, get_logger
from generators.impl.base_generator import BaseGenerator, Entity


class CurrencyGen(BaseGenerator):
    iso_4217_url = 'https://www.currency-iso.org/dam/downloads/lists/list_one.xml'
    currency_wiki_page = 'https://es.wikipedia.org/wiki/Anexo:Monedas_circulantes'

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

        self.log.info("Step 2. Generate the SQL inserts for the currency table")
        self.generate_currencies_sql_inserts(df, working_dir)

        self.log.info("Step 3. Generate the SQL inserts for the translation table")
        self.generate_translations_sql_inserts(df, working_dir)

    def get_data(self, working_dir) -> pd.DataFrame:

        data_file_path = path.join(working_dir, "currencies_complete_info.csv")

        if not path.isfile(data_file_path):
            self.log.info("The data does't exist in the directory. Downloading from the web.")
            return self.get_data_from_web(working_dir)

        self.log.info("\t * Reading the data from cache.")
        return pd.read_csv(data_file_path,  index_col=0)

    def get_data_from_web(self, working_dir) -> pd.DataFrame:
        self.log.info("\t * Download the XML and parse it")
        parsed_xml = self.download_iso_data()

        self.log.info("\t * Extract the needed information from the XML in a DataFrame")
        iso_df = self.create_iso_data_frame(parsed_xml)
        iso_df.to_csv(path.join(working_dir, "iso_4217.csv"), index_label="Id")

        self.log.info("\t * Get the description of each currency from the Wikipedia in a DataFrame")
        wiki_df = self.create_wiki_data_frame()
        wiki_df.to_csv(path.join(working_dir, "wiki_currency.csv"), index_label="Id")

        self.log.info("\t * Keep only the currencies that are listed in Wikipedia")
        df = pd.merge(iso_df, wiki_df, on='AlphabeticCode', how='outer').dropna()
        df.NumericCode = df.NumericCode.astype(int)
        df.to_csv(path.join(working_dir, 'currencies_complete_info.csv'), index_label="Id")

        return df

    def download_iso_data(self) -> ET.Element:
        """
          Download the ISO 4217 file from the web.

        :return parsed_data: XML parser
        """
        self.log.debug("Downloading the XML file from: {}".format(self.iso_4217_url))
        xml_data = requests.get(self.iso_4217_url, headers=default_headers).content

        self.log.debug("Request completed. Starting analysis.")

        return ET.XML(xml_data)

    def create_iso_data_frame(self, parsed_xml) -> pd.DataFrame:
        """
           Creates a data frame that contains the currency name, the alphanumeric code and the numeric code

        :param parsed_xml:
        :return currencies: Pandas data frame
        """
        columns = ['EnglishName', 'AlphabeticCode', 'NumericCode']
        df = pd.DataFrame(columns=columns)
        analyzed = []

        for node in parsed_xml.find('CcyTbl').getchildren():

            currency = self.get_node_value(node.find('CcyNm'))
            alpha_code = self.get_node_value(node.find('Ccy'))
            numeric_code = self.get_node_value(node.find('CcyNbr'))

            if alpha_code is not None and numeric_code is not None and numeric_code not in analyzed:
                df = df.append(
                    pd.Series([currency, alpha_code, int(numeric_code)], index=columns), ignore_index=True
                )

            analyzed.append(numeric_code)

        return df

    def create_wiki_data_frame(self) -> pd.DataFrame:
        """
            Using the information of the Wikipedia, this function create a DataFrame that contains the alpha code,
          the description, and the link to the page on Wikipedia for each currency.
        :return wiki_df: Pandas data frame
        """

        columns = [
            'SpanishName', 'AlphabeticCode', 'SpanishUrl', 'EnglishUrl', 'SpanishDescription', 'EnglishDescription'
        ]
        df = pd.DataFrame(columns=columns)

        soup = self.download_wiki_page(self.currency_wiki_page)
        analyzed = []
        tables = soup.find_all("table", {"class": "wikitable"})

        for table in tables:
            table_body = table.find('tbody')
            rows = table_body.find_all('tr')
            rowspan = 0

            for row in rows:
                cols = row.findAll('td')

                if len(cols):
                    first_column = cols[0]

                    #   If the column expands to more than one row, then the information of interest starts at index 1.
                    # If the country doesn't have more than one currency, then it will has only one row, and if it not
                    # under th influence of a previous expansion, then the information also starts at index 1.
                    start_index = 1

                    if first_column.has_attr('rowspan'):
                        rowspan = int(first_column.attrs['rowspan'])
                    elif rowspan > 0:
                        start_index = 0

                    currency = cols[start_index].text.strip().split('[')[0]
                    iso_code = cols[start_index + 2].text.strip()

                    if len(iso_code) == 3 and iso_code not in analyzed:
                        desc_elem = cols[start_index].find('a')
                        es_wiki_page_url = 'https://es.wikipedia.org' + desc_elem.attrs['href']

                        es_wiki_page = self.download_wiki_page(es_wiki_page_url)
                        spanish_desc = self.get_description(es_wiki_page)

                        en_wiki_page_url = self.get_wiki_link_for_languages(es_wiki_page, ["en"])
                        english_desc = "" if len(en_wiki_page_url) == 0 else \
                            self.get_description(self.download_wiki_page(en_wiki_page_url[0]))

                        df = df.append(
                            pd.Series(
                                [currency, iso_code, es_wiki_page_url, en_wiki_page_url, spanish_desc, english_desc],
                                index=columns), ignore_index=True
                        )

                    analyzed.append(iso_code)

                rowspan -= 1

        return df

    def generate_currencies_sql_inserts(self, df, working_dir):
        """
           Generates de SQL inserts for the currency entity
        :param df: Data frame with the currencies information
        :param working_dir: Directory where the script will be saved
        """
        sql_inserts = [
            "( {:4d}, {:4d}, \'{:3s}\' )".format(index + 1, row['NumericCode'], row['AlphabeticCode'])
            for index, row in df.iterrows()
        ]

        self.write(
            "currency.sql", working_dir, Entity.CURRENCY, sql_inserts,
            [self.iso_4217_url, self.currency_wiki_page]
        )

    def generate_translations_sql_inserts(self, df, working_dir):
        language_df = pd.read_csv(path.join(working_dir, "iso_639_3.csv"), index_col=0)
        spanish_index = language_df.index[language_df.Part1 == "es"][0] + 1
        english_index = language_df.index[language_df.Part1 == "en"][0] + 1

        translation_data = []
        currency_translation_data = []

        translation_id = 1

        for index, row in df.iterrows():
            # Spanish Data
            translation_data.append(
                "({:4d}, {:4d}, \'{}\')".format(
                    translation_id, spanish_index,
                    "{{\"description\": \"{}\", \"url\": \"{}\"}}".format(row["SpanishDescription"], row["SpanishUrl"])
                )
            )

            currency_translation_data.append("({:4d}, {:4d}, {:4d})".format(translation_id, index + 1, translation_id))

            # English Data
            translation_data.append(

                "({:4d}, {:4d}, \'{}\')".format(
                    translation_id + 1, english_index,
                    "{{\"description\": \"{}\", \"url\": \"{}\"}}".format(row["EnglishDescription"], row["EnglishUrl"])
                )
            )

            currency_translation_data.append("({:4d}, {:4d}, {:4d})".format(
                    translation_id + 1, index + 1, translation_id + 1
                )
            )

            translation_id += 2

        self.write(
            "translation.sql", working_dir, Entity.TRANSLATION, translation_data,
            [self.iso_4217_url, self.currency_wiki_page]
        )

        self.write(
            "currency_translation.sql", working_dir,
            Entity.CURRENCY_TRANSLATION, currency_translation_data,
            [self.iso_4217_url, self.currency_wiki_page]
        )

    @staticmethod
    def download_wiki_page(wiki_page_url) -> BeautifulSoup:
        """
          Download content from the Wikipedia and returns the object to handle the content
        :param wiki_page_url: The url to download
        :return soup: A BeautifulSoup html parser
        """
        wiki_page = requests.get(wiki_page_url, headers=default_headers)
        return BeautifulSoup(wiki_page.text, 'html.parser')

    @staticmethod
    def get_node_value(node) -> str:
        """ return node text or None """
        return node.text if node is not None else None

    @staticmethod
    def get_wiki_link_for_languages(base_wiki_page, langs) -> list:
        """
        Get the wiki page for one article in the specified languages

        :param base_wiki_page: The base Wiki page already parsed
        :param langs: List of languages

        :return: List of urls of the translations
        """
        links = []

        lang_list = base_wiki_page.select("div#p-lang ul li")

        for li in lang_list:
            link = li.find("a")

            if link.has_attr("lang") and link["lang"] in langs:
                links.append(link["href"])

        return links

    @staticmethod
    def get_description(soup) -> str:
        """
           Given the url of a currency, this function will get the paragraphs before the table of content which is
         consider the currency description
        :param soup: The content of the currency in Wikipedia already parsed
        :return description: The description of the currency
        """
        article = soup.find("div", {"class": "mw-parser-output"})
        description = ""

        for elem in article:
            if type(elem) == bs4.element.Tag:

                if elem.name == 'p':
                    description += elem.text.strip().replace("'", "''") + "\n"
                elif elem.name == 'div' and elem.has_attr('id') and elem.attrs['id'] == 'toc':
                    break

        return description
