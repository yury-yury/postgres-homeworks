import json

import psycopg2

from config import config


def main():
    script_file = 'fill_db.sql'
    json_file = 'suppliers.json'
    db_name = 'my_new_db_2'

    params = config()
    conn = None

    create_database(params, db_name)
    print(f"Database {db_name} successfully created")

    params.update({'dbname': db_name})
    try:
        with psycopg2.connect(**params) as conn:
            with conn.cursor() as cur:
                execute_sql_script(cur, script_file)
                print(f"Database {db_name} successfully filled in")

                create_suppliers_table(cur, json_file)
                print("The suppliers table has been created successfully.")

                suppliers = get_suppliers_data(json_file)
                insert_suppliers_data(cur, conn, suppliers)
                print("Data has been successfully added to the suppliers table.")

                add_foreign_keys(cur, json_file)
                print(f"FOREIGN KEY has been successfully added")

    except(Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()


def create_database(params, new_db_name) -> None:
    """Создает новую базу данных."""
    connect = psycopg2.connect(dbname="postgres", user=params["user"],
                          password=params["password"], host=params["host"])
    cursor = connect.cursor()
    connect.autocommit = True
    try:
        cursor.execute(f"CREATE DATABASE {new_db_name};")
    except psycopg2.OperationalError as e:
        print(f"The error '{e}' occurred")
    cursor.close()
    connect.close()

def execute_sql_script(cur, script_file) -> None:
    """Выполняет скрипт из файла для заполнения БД данными."""
    with open(script_file, 'r', encoding='utf-8') as file:
        query_list = list()
        for line in file:
            line = line.strip()
            if line == '' or line.startswith('--'):
                continue
            query_list.append(line)
            if line.endswith(';'):
                cur.execute('\n'.join(query_list))
                query_list = []


def create_suppliers_table(cur, json_file) -> None:
    """Создает таблицу suppliers."""
    cur.execute("""CREATE TABLE suppliers ( supplier_id serial PRIMARY KEY,
                                            company_name varchar NOT NULL,
                                            contact varchar,
                                            address varchar,
                                            phone varchar,
                                            fax varchar,
                                            homepage varchar)""")
    cur.execute("ALTER TABLE products ADD COLUMN supplier_id int")


def get_suppliers_data(json_file: str) -> list[dict]:
    """Извлекает данные о поставщиках из JSON-файла и возвращает список словарей с соответствующей информацией."""
    with open(json_file, 'r', encoding='utf-8') as file:
        data = json.load(file)

    return data


def insert_suppliers_data(cur, conn, suppliers: list[dict]) -> None:
    """Добавляет данные из suppliers в таблицу suppliers."""
    for dict_ in suppliers:
        cur.execute(f"""INSERT INTO suppliers(company_name, contact, address, phone, fax, homepage)
        VALUES ('{dict_["company_name"]}', 
                '{dict_["contact"]}', 
                '{dict_["address"]}', 
                '{dict_["phone"]}', 
                {("'" + dict_["fax"] + "'") if dict_["fax"] else 'NULL'}, 
                {("'" + dict_["homepage"] + "'") if dict_["fax"] else 'NULL'});""")
        conn.commit()

        cur.execute(f"""SELECT supplier_id FROM suppliers 
                                            WHERE company_name = '{dict_["company_name"]}';""")
        company_id: int = cur.fetchone()

        for product in dict_["products"]:
            cur.execute(f"""UPDATE products SET supplier_id = {company_id[0]}
                                WHERE product_name = '{product}';""")


def add_foreign_keys(cur, json_file) -> None:
    """Добавляет foreign key со ссылкой на supplier_id в таблицу products."""
    cur.execute("""ALTER TABLE products 
                        ADD CONSTRAINT fk_supplier_product 
                            FOREIGN KEY (supplier_id) REFERENCES suppliers;""")


if __name__ == '__main__':
    main()
