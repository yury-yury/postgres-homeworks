-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products ADD CONSTRAINT unit_price_chk CHECK ( unit_price > 0 );

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ADD CONSTRAINT discontinued_chk CHECK ( discontinued IN ( 1, 0 ) );

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
CREATE TABLE products_discountinued AS SELECT * FROM products WHERE discontinued = 1;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
-- ALTER TABLE products_discountinued ALTER COLUMN product_id SET NOT NULL;
-- ALTER TABLE products_discountinued ALTER COLUMN product_name SET NOT NULL;
-- ALTER TABLE products_discountinued ALTER COLUMN discontinued SET NOT NULL;
-- ALTER TABLE products_discountinued ADD CONSTRAINT discontinued_chk CHECK ( discontinued IN ( 1, 0 ) );
-- ALTER TABLE products_discountinued ADD CONSTRAINT unit_price_chk CHECK ( unit_price > 0 );
-- ALTER TABLE products_discountinued INHERIT products;
ALTER TABLE products DISABLE TRIGGER ALL;
DELETE FROM ONLY products WHERE discontinued = 1;
ALTER TABLE products ENABLE TRIGGER ALL;