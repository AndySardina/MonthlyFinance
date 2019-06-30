import datetime
import getpass
import os
import string
from enum import Enum
import codecs

from generators.utils import change_semi_colon_by_comma


class Entity(Enum):
    TRANSLATION = {"columns": "id, language_id, data", "file_name": "translation.sql"},
    CURRENCY = {"columns": "id, numeric_code, alphabetic_code", "file_name": "currency.sql"},
    CURRENCY_TRANSLATION = {"columns": "id, currency_id, translation_id", "file_name": "currency_translation.sql"},
    LANGUAGE = {
        "columns": "id, name, type, scope, iso_6393, iso_6392_B, iso_6392_T, iso_6391",
        "file_name": "language.sql"
    },
    LANGUAGE_TYPE = {"columns": "id, type, name", "file_name": "language_type.sql"},
    LANGUAGE_SCOPE = {"columns": "id, scope, name", "file_name": "language_scope.sql"},
    COUNTRY = {"columns": "id, ccn3, cca3, idd", "file_name": "country.sql"},
    COUNTRY_TRANSLATION = {"columns": "id, country_id, translation_id", "file_name": "country_translation.sql"},
    COUNTRY_CURRENCY = {"columns": "id, country_code, currency_code", "file_name": "country_currency.sql"},

    def get_name(entity):
        return entity.name.lower()

    def get_columns(entity):
        return entity.value[0]["columns"]

    def get_file_name(entity):
        return entity.value[0]["file_name"]


class Operation(Enum):
    CREATE = 1,
    UPDATE = 2


class BaseGenerator:
    sql_base_template = string.Template("""
/******************************************************************
** THIS FILE AUTOMATICALLY GENERATED by $script
** by $user from $urls on $today.
** Instead of manually editing this file, you probably want to
** manually edit $script and regenerate this file.
******************************************************************/

${insert_statement}
VALUES
  $inserts
;
"""[1:])

    def write(self, working_dir, entity,  sql_inserts, url_list):

        file_path = os.path.join(working_dir, Entity.get_file_name(entity))

        if not os.path.isfile(file_path):
            self.__write_template__(file_path, entity, sql_inserts, url_list)
        else:
            self.__update_file__(file_path, sql_inserts)

    def __write_template__(self, file_path, entity, sql_inserts, url_list):
        if not isinstance(entity, Entity):
            raise ValueError("The value of entity is not valid.")

        with codecs.open(file_path, 'a', encoding='utf-8') as f:
            insert_statement = "INSERT INTO {} ({})".format(Entity.get_name(entity), Entity.get_columns(entity))

            f.write(
                self.sql_base_template.substitute(
                    user=getpass.getuser(),
                    script=self.get_generator_name(),
                    insert_statement=insert_statement,
                    urls=", ".join(url_list),
                    today=datetime.datetime.now().strftime("%Y-%m-%d"),
                    inserts=",\n  ".join(sql_inserts)
                )
            )

    @staticmethod
    def __update_file__(file_path, sql_inserts):
        change_semi_colon_by_comma(file_path)
        with codecs.open(file_path, 'a', encoding='utf-8') as f:
            f.write("\n")
            f.write(",\n  ".join(sql_inserts))
            f.write("\n;")

    def get_generator_name(self):
        raise NotImplemented
