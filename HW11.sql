-- 1 
USE VK;
CREATE TABLE logs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    table_name varchar(50) NOT NULL,
    row_id INT UNSIGNED NOT NULL,
    row_name varchar(255)
) ENGINE = Archive;

DELIMITER //
CREATE TRIGGER insert_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, "products", NEW.product_id, NEW.product_name);
END//

CREATE TRIGGER insert_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, "users", NEW.id, NEW.first_name);
END//

CREATE TRIGGER insert_catalogs AFTER INSERT ON catalogues
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, "catalogs", NEW.id, NEW.catal_name);
END//

DELIMITER ;

INSERT INTO users VALUES (NULL, 'first', 'second', 'third', 'name@name.ru', '79586535656', '4', '100' , 'm','1986-09-10', '5', DEFAULT,DEFAULT );
INSERT INTO products VALUES ('456', 'some name', '352', '1' );
INSERT INTO catalogues VALUES (NULL, 'Printers');

SELECT * FROM logs;

-- 2
CREATE TABLE buyers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Name',
  birthday_at DATE COMMENT 'Birthday',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Buyers';

INSERT INTO buyers (name, birthday_at) VALUES
  ('Evgeniy', '2000-11-05'),
  ('Mikhail', '1976-09-08'),
  ('Oleg', '1978-06-01'),
  ('Darya', '1981-02-26'),
  ('Maxim', '1997-01-18'),
  ('Demis', '1994-07-30'),
  ('Olga', '1997-08-17'),
  ('Dmitry', '1999-09-10'),
  ('Ilya', '1988-09-05'),
  ('Maria', '1982-09-15');

SELECT
  COUNT(*)
FROM
  buyers AS fst,
  buyers AS snd,
  buyers AS thd,
  buyers AS fth,
  buyers AS fif,
  buyers AS sth;

SELECT COUNT(*) FROM users;

SELECT * FROM users LIMIT 10;
