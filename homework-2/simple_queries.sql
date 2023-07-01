-- Напишите запросы, которые выводят следующую информацию:
-- 1. "имя контакта" и "город" (contact_name, country) из таблицы customers (только эти две колонки)
SELECT contact_name, country FROM customers LIMIT 50;
SELECT contact_name, country FROM customers LIMIT 50 OFFSET 50;

-- 2. идентификатор заказа и разницу между датами формирования (order_date) заказа и его отгрузкой (shipped_date) из таблицы orders
SELECT order_id,  shipped_date - order_date as different_data FROM orders;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 50;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 100;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 150;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 200;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 250;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 300;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 350;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 400;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 450;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 500;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 550;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 600;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 650;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 700;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 750;
SELECT order_id,  shipped_date - order_date as different_data FROM orders LIMIT 50 OFFSET 800;

-- 3. все города без повторов, в которых зарегистрированы заказчики (customers)
SELECT DISTINCT city FROM customers;
SELECT DISTINCT city FROM customers LIMIT 50;
SELECT DISTINCT city FROM customers LIMIT 50 OFFSET 50;

-- 4. количество заказов (таблица orders)
SELECT COUNT(*) AS count_orders FROM orders;

-- 5. количество стран, в которые отгружался товар (таблица orders, колонка ship_country)
SELECT COUNT(DISTINCT ship_country) FROM orders;