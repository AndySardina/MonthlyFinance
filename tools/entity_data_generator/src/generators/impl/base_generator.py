import datetime
import getpass
import os
import string
from enum import Enum
import codecs


class Entity(Enum):
    TRANSLATION = "id, language_id, data",
    CURRENCY = "id, numeric_code, alphabetic_code",
    CURRENCY_TRANSLATION = "id, currency_id, translation_id",
    LANGUAGE = "id, name, type, scope, iso_6393, iso_6392_B, iso_6392_T, iso_6391",
    LANGUAGE_TYPE = "id, type, name",
    LANGUAGE_SCOPE = "id, scope, name",
    COUNTRY = "id, ccn3, cca3, idd",
    COUNTRY_TRANSLATION = "id, country_id, translation_id"


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

    def write(self, file_name, working_dir, entity,  sql_inserts, url_list):
        file_path = os.path.join(working_dir, file_name)

        if not os.path.isfile(file_path):
            self.__write_template__(file_path, entity, sql_inserts, url_list)
        else:
            self.__update_file__(file_path, sql_inserts)

    def __write_template__(self, file_path, entity, sql_inserts, url_list):
        if not isinstance(entity, Entity):
            raise ValueError("The value of entity is not valid.")

        with codecs.open(file_path, 'a', encoding='utf-8') as f:
            insert_statement = "INSERT INTO {} ({})".format(entity.name.lower(), entity.value[0])

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

    def __update_file__(self, file_path, sql_inserts):
        self.__change_semi_colon_by_comma__(file_path)
        with codecs.open(file_path, 'a', encoding='utf-8') as f:
            f.write("\n")
            f.write(",\n  ".join(sql_inserts))
            f.write("\n;")

    @staticmethod
    def __change_semi_colon_by_comma__(file_path):
        with open(file_path, "r+", encoding="utf-8") as file:

            # Move the pointer (similar to a cursor in a text editor) to the end of the file
            file.seek(0, os.SEEK_END)

            # This code means the following code skips the very last character in the file -
            # i.e. in the case the last line is null we delete the last line
            # and the penultimate one
            pos = file.tell() - 1

            # Read each character in the file one at a time from the penultimate
            # character going backwards, searching for a newline character
            # If we find a new line, exit the search
            while pos > 0 and file.read(1) != "\n":
                pos -= 1
                file.seek(pos, os.SEEK_SET)

            # So long as we're not at the start of the file, delete all the characters ahead
            # of this position
            if pos > 0:
                file.seek(pos, os.SEEK_SET)
                file.truncate()
            file.write(',')

    def get_generator_name(self):
        raise NotImplemented
