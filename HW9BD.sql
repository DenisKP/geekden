CREATE DATABASE sample;
CREATE DATABASE shop;
USE shop;
CREATE TABLE IF NOT EXISTS users(
	id SERIAL PRIMARY KEY,
	user_name VARCHAR(255) NOT NULL
);
INSERT INTO users (user_name) VALUES ('max'), ('john');
USE sample;
CREATE TABLE IF NOT EXISTS users(
	id SERIAL PRIMARY KEY,
	user_name VARCHAR(255) NOT NULL
);
START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1; 
DELETE FROM shop.users WHERE id = 1;
COMMIT;

-- 2
CREATE TABLE IF NOT EXISTS products_catalogs (
	catalogs_id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);
CREATE TABLE products (
	products_id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(255) NOT NULL
);
USE shop;
CREATE TABLE IF NOT EXISTS catalogs (
	catalogs_id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

CREATE TABLE products (
	products_id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(255) NOT NULL,
	catalog_id INT NOT NULL 
);
INSERT INTO catalogs (name) VALUES ('comp'), ('printer');
INSERT INTO products (name, catalog_id) VALUES ('pentium', 1), ('hewlet', 2);

CREATE OR REPLACE VIEW products_catalogs AS
SELECT
  p.name AS product,
  c.name AS catalogs
FROM
  products AS p
JOIN
  catalogs AS c
ON
  p.catalog_id = c.catalogs_id;
 
-- 3
USE shop;
CREATE TABLE IF NOT EXISTS posts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  created_at DATE NOT NULL
);

INSERT INTO posts VALUES
(NULL, 'first stroke', '2020-08-01'),
(NULL, 'second stroke', '2018-08-04'),
(NULL, 'third stroke', '2018-08-16'),
(NULL, 'four stroke', '2018-08-17');

CREATE TEMPORARY TABLE needed_days (
  day INT
);

INSERT INTO needed_days VALUES
(0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30);

SELECT
  DATE(DATE('2018-08-31') - INTERVAL l.day DAY) AS day,
  NOT ISNULL(p.name) AS order_exist
FROM
  needed_days AS l
LEFT JOIN
  posts AS p
ON
  DATE(DATE('2018-08-31') - INTERVAL l.day DAY) = p.created_at
ORDER BY
  day;
 
--1
USE VK3;

DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello ()
RETURNS TINYTEXT NO SQL
BEGIN
  DECLARE hour INT;
  SET hour = HOUR(NOW());
  CASE
    WHEN hour BETWEEN 0 AND 5 THEN
      RETURN "Доброй ночи";
    WHEN hour BETWEEN 6 AND 11 THEN
      RETURN "Доброе утро";
    WHEN hour BETWEEN 12 AND 17 THEN
      RETURN "Добрый день";
    WHEN hour BETWEEN 18 AND 23 THEN
      RETURN "Добрый вечер";
  END CASE;
END//
 
-- 2
 DELIMITER //

CREATE TRIGGER validater BEFORE INSERT ON products
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Name and description empty';
  END IF;
END//

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (NULL, NULL, 72000, 1)//

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('NobrandedPC', 'any data about pc number 1', 5800, 1)//

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (NULL, 'any data about pc number 2', 3565, 2)//

CREATE TRIGGER validater_update BEFORE UPDATE ON products
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Name and description empty';
  END IF;
END//

-- 3

