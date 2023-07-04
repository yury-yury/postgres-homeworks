"""Скрипт для заполнения данными таблиц в БД Postgres."""
from csv import DictReader, reader
from typing import List, Tuple, Any
import psycopg2

def read_csv_file(path_file: str) -> Tuple[List[str], list[Any]]:
    """
        The read_csv_file function takes as an argument the name and location of a file with data in CSV format
        as a string. When called, it opens a file for reading, reads data and converts it into a list of dictionary
        in python format. Returns list of dictionary keys received from the file in the form of a python list
        and a list of values in the form of a list of python tuples.
        """
    with open(path_file, 'r', encoding='utf-8') as csvf:
        csv_reader = list(reader(csvf))
        key_list: List[str] = csv_reader.pop(0)
        value_list: List[list] = csv_reader
        for row in value_list:
            for i in range(len(row)):
                if isinstance(row[i], str):
                    row[i] = f"""'{row[i].replace("'", '"')}'"""
    return key_list, value_list


if __name__ == '__main__':
    list_paths_and_tables: List[Tuple[str, str]] = [('./north_data/customers_data.csv', 'customers'),
                                                    ('./north_data/employees_data.csv', 'employees'),
                                                    ('./north_data/orders_data.csv', 'orders')]

    with psycopg2.connect(host="localhost", database="north", user="skypro", password="1234") as conn:
        with conn.cursor() as cursor:
            for file in list_paths_and_tables:
                keys, values = read_csv_file(file[0])
                for item in values:
                    cursor.execute(f"""INSERT INTO {file[1]} ({', '.join(keys)}) VALUES ({', '.join(item) });""")
                conn.commit()

