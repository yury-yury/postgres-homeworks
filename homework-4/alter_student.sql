-- 1. Создать таблицу student с полями student_id serial, first_name varchar, last_name varchar, birthday date, phone varchar
CREATE TABLE students(
    student_id serial,
    first_name varchar(100),
    last_name varchar(100),
    birthday date,
    phone varchar(12)
);

-- 2. Добавить в таблицу student колонку middle_name varchar
ALTER TABLE students ADD COLUMN middle_name varchar(100);

-- 3. Удалить колонку middle_name
ALTER TABLE students DROP COLUMN middle_name;

-- 4. Переименовать колонку birthday в birth_date
ALTER TABLE students RENAME COLUMN birthday TO birth_date;

-- 5. Изменить тип данных колонки phone на varchar(32)
ALTER TABLE students ALTER COLUMN phone TYPE varchar(32);

-- 6. Вставить три любых записи с автогенерацией идентификатора
INSERT INTO students(first_name, last_name, birth_date, phone) VALUES ('John', 'Smith', '1990-10-10', '+078945612312');
INSERT INTO students(first_name, last_name, birth_date, phone) VALUES ('Vanessa', 'May', '1988-04-15', '+478945612312');
INSERT INTO students(first_name, last_name, birth_date, phone) VALUES ('Sara', 'Smith', '1985-12-30', '+578945612312');

-- 7. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
TRUNCATE students RESTART IDENTITY;
