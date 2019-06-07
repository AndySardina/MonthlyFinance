from os import path
import requests
import pandas as pd
import xml.etree.ElementTree as ET
import bs4
from bs4 import BeautifulSoup
import string

from generators import default_headers, get_logger


class CurrencyGen:
    iso_4217_url = 'https://www.currency-iso.org/dam/downloads/lists/list_one.xml'

    sql_inserts_template = string.Template("""
    /******************************************************************
    ** THIS FILE AUTOMATICALLY GENERATED by $script
    ** by $user from $urls on $today.
    ** Instead of manually editing this file, you probably want to
    ** manually edit $script and regenerate this file.
    ******************************************************************/

    INSERT INTO currency (id, numeric_code, alphabetic_code, wiki_page)
    VALUES
       $inserts
    ;

    """[1:])

    def __init__(self):
        self.log = get_logger("currency_generator")

    def generate(self, output_dir):
        """ Generates de SQL inserts for currencies

        Args:

        """
        self.log.info("Step 1. Download the XML and parse it")
        parsed_xml = self.download_iso_data()

        self.log.info("Step 2. Extract the needed information from the XML in a DataFrame")
        iso_df = self.create_iso_data_frame(parsed_xml)
        iso_df.to_csv(path.join(output_dir, "iso_4217.csv"), index_label="Id")

        self.log.info("Step 3. Get the description of each currency from the Wikipedia in a DataFrame")
        wiki_df = self.create_wiki_data_frame()
        wiki_df.to_csv(path.join(output_dir, "wiki_currency.csv"), index_label="Id")

        self.log.info("Step 4. Keep only the currencies that are listed in Wikipedia")
        df = pd.merge(iso_df, wiki_df, on='AlphabeticCode', how='outer').dropna()
        df.NumericCode = df.NumericCode.astype(int)
        df.to_csv(path.join(output_dir, 'currencies_complete_info.csv'), index_label="Id")

        self.log.info("Step 5. Generate the SQL inserts for the currency table")

        self.log.info("Step 6. Generate the SQL inserts for the translation table")

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

        columns = ['SpanishName', 'AlphabeticCode', 'RelativeUrl', 'SpanishDescription', 'EnglishDescription']
        df = pd.DataFrame(columns=columns)

        soup = self.download_wiki_page('https://es.wikipedia.org/wiki/Anexo:Monedas_circulantes')
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
                        desc_url = desc_elem.attrs['href']

                        es_wiki_page = self.download_wiki_page('https://es.wikipedia.org' + desc_url)
                        spanish_desc = self.get_description(es_wiki_page)

                        en_wiki_page_url = self.get_wiki_link_for_languages(es_wiki_page, ["en"])
                        english_desc = "" if len(en_wiki_page_url) == 0 else \
                            self.get_description(self.download_wiki_page(en_wiki_page_url[0]))

                        df = df.append(
                            pd.Series([currency, iso_code, desc_url, spanish_desc, english_desc],
                                      index=columns), ignore_index=True
                        )

                    analyzed.append(iso_code)

                rowspan -= 1

        return df

    def generate_currencies_sql_inserts(self, df):
        """

        :param df:
        :return:
        """
        pass

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