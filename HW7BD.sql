-- 1
USE VK;
DROP TABLE IF EXISTS users_orders;
CREATE TABLE IF NOT EXISTS users_orders (
	user_id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	order_id INT  
	);
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders (
	order_id SERIAL PRIMARY KEY,
	product_id INT NOT NULL,
	product_name VARCHAR(255) NOT NULL
	);

INSERT INTO users_orders (name, order_id) VALUES ( 'Геннадий', 1), ( 'Михаил', 2), ( 'Евгений', 3), ( 'Светлана', NULL), ( 'Dmitriy', NULL);
INSERT INTO orders (product_id , product_name) VALUES ( 34, 'PC'), ( 334, 'phone'), ( 3234, 'memory'), ( 123, 'Motherboard 32');

SELECT u.user_id, u.name, o.order_id, o.product_id, o.product_name FROM users_orders AS u JOIN orders AS o ON u.order_id > 0 AND o.order_id = u.order_id ;

-- 2

DROP TABLE IF EXISTS products;
CREATE TABLE IF NOT EXISTS products (
	product_id INT NOT NULL,
	product_name VARCHAR(255) NOT NULL,
	product_price INT,
	catalogue_id INT
	);

DROP TABLE IF EXISTS catalogues;
CREATE TABLE IF NOT EXISTS catalogues (
	id SERIAL PRIMARY KEY,
	catal_name VARCHAR(255)
	);
INSERT INTO catalogues (catal_name) VALUES ('motherboards'), ('computers'), ('phones'), ('memories');

INSERT INTO products VALUES ( 123, 'Motherboard 32', 456, 1), ( 34, 'PC', 584, 2), ( 334, 'phone', 985, 3), ( 3234, 'memory', 52, 4);

SELECT p.product_id, p.product_name, p.product_price, c.catal_name FROM products AS p LEFT JOIN catalogues AS c ON p.catalogue_id = c.id ;

-- 3
DROP TABLE IF EXISTS flights;
CREATE TABLE IF NOT EXISTS flights (
	id SERIAL PRIMARY KEY,
	f_from VARCHAR(255) NOT NULL,
	f_to VARCHAR(255) NOT NULL
	);
DROP TABLE IF EXISTS cities;
CREATE TABLE IF NOT EXISTS cities (
	label VARCHAR(255) NOT NULL UNIQUE,
	name VARCHAR(255) NOT NULL UNIQUE
);
INSERT INTO flights (f_from, f_to) VALUES ('moscow', 'omsk'), ('novgorod', 'kazan'), ('irkutsk', 'moscow'), ('omsk', 'irkutsk'), ('moscow', 'kazan');
INSERT INTO cities (label, name) VALUES ('moscow', 'Москва'), ('irkutsk', 'Иркутск'), ('novgorod', 'Новгород'), ('kazan', 'Казань'), ('omsk', 'Омск');
SELECT
  f.id, cities_from.name AS f_from, cities_to.name AS f_to
FROM flights AS f
  JOIN cities AS cities_from
    ON f.f_from = cities_from.label
  JOIN cities AS cities_to
    ON f.f_to = cities_to.label;

