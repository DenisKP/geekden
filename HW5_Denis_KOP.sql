USE VK;

-- filters 1

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT "BUYER_NAME",
	birthday_at DATE COMMENT "BIRTHDAY_DATE",
	created_at DATETIME,
	updated_at DATETIME	
);
INSERT INTO users (
name, birthday_at, created_at, updated_at 
)
VALUES
	('Denis', '1983-01-28', NULL, NULL),
	('Mikhail', '1985-01-31', NULL, NULL),
	('Alexey', '1988-01-23', NULL, NULL),
	('Dmitry', '1982-01-14', NULL, NULL),
	('Roman', '1990-01-02', NULL, NULL),
	('Viktoriya', '1943-01-22', NULL, NULL);
UPDATE users 
SET 
	created_at = NOW(),
	updated_at  = NOW();

-- filters2

DROP TABLE IF EXISTS users;
CREATE TABLE users (
id SERIAL PRIMARY KEY,
name VARCHAR(255),
birthday_at DATE,
created_at VARCHAR(255),
updated_at VARCHAR(255)
);
INSERT INTO 
users (name, birthday_at, created_at, updated_at )
VALUES
	('Dmitry', '2001-01-26', '20.10.2020 8:10', '20.10.2020 8:10'),
	('Denis', '1984-08-26', '15.01.2020 4:45', '15.01.2020 4:45'),
	('Anastasia', '1990-11-15', '15.01.2020 6:10', '15.01.2020 6:10')
;
UPDATE users 
SET 
created_at = STR_TO_DATE (created_at, '%d.%m.%Y %k:%i'),
updated_at = STR_TO_DATE (updated_at, '%d.%m.%Y %k:%i');

-- filters3

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
id SERIAL PRIMARY KEY,
storehouse_name VARCHAR(255) COMMENT 'STOREHOUSE NAME',
product_name VARCHAR(255) COMMENT 'ANY PRODUCT NAME',
value INT UNSIGNED COMMENT 'PRODUCT VALUE AT STOREHOUSE',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
INSERT INTO storehouses_products (storehouse_name, product_name, value)
VALUES
('eastern', 'phone', 1),
('western', 'pc', 0),
('south', 'printer', 3),
('western', 'keyboard', 4),
('eastern', 'mouse', 2),
('south', 'scanner', 0);

SELECT * FROM storehouses_products ORDER BY value;
SELECT * FROM storehouses_products ORDER BY value = 0, value;
SELECT DISTINCT 

-- agregation 1

SELECT AVG(TIMESTAMPDIFF (YEAR, birthday_at, NOW())) AS average_age FROM users;

-- agregation 2

SELECT
  DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
  COUNT(*) AS total
FROM
  users
GROUP BY
  day
ORDER BY
  total DESC;

