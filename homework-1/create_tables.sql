-- SQL-команды для создания таблиц
CREATE DATABASE north;
CREATE TABLE customers(
    customer_id char(5) PRIMARY KEY,
    company_name varchar(150),
    contact_name varchar(150));
CREATE TABLE employees( 
    employee_id int PRIMARY KEY,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    title varchar(150) NOT NULL,
    birth_date date,
    notes text);
CREATE TABLE orders(
    order_id bigint PRIMARY KEY,
    customer_id char(5) REFERENCES customers(customer_id) NOT NULL,
    employee_id int REFERENCES employees(employee_id) NOT NULL,
    order_date date,
    ship_city varchar(150));
