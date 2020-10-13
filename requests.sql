USE existru;
-- select users which birthday month same with shop birthday month to send them greetings card with special discount
SELECT  first_name AS 'BIRTHDAY SALE ', email 
  FROM users
  WHERE DATE_FORMAT(birthday, '%M') IN ('january')   ;

-- average users age
SELECT
  AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())) AS 'average age'
FROM
  users;

-- average order costs
 
SELECT AVG(order_cost) AS 'average order cost' FROM orders; 

-- who made more orders male or female and total numbers of orders
SELECT
	(SELECT gender FROM users WHERE id = orders.user_id) AS gender,
	COUNT(*) AS total
    FROM orders 
    GROUP BY gender
    ORDER BY total DESC
    LIMIT 2;  

-- who made more orders from any category from users
SELECT
	(SELECT user_type FROM profiles WHERE client_id = orders.user_id) AS User_type,
	COUNT(*) AS total
    FROM orders 
    GROUP BY User_type 
    ORDER BY total DESC
    LIMIT 7;  
   
-- searching for users who made minimum requests and orders    
	  
SELECT 
  CONCAT(first_name, ' ', middle_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM orders WHERE orders.user_id = users.id) + 
	(SELECT COUNT(*) FROM requests WHERE requests.user_id = users.id) 
	AS overall_activity 
	  FROM users
	  ORDER BY overall_activity DESC
	  LIMIT 10;
	  
-- searching for users who has vehicle from garage and order it by id to look for each VIN
	 
SELECT u.id, u.first_name, g.vin 
  FROM users AS u
   LEFT JOIN garage AS g
     ON u.id = g.user_id 
     WHERE g.user_id IS NOT NULL
    ORDER BY u.id;

-- SHOW all id, name price level and discounts from same user type you can choose from 1 to 7 to check all types, Default 4 

SELECT p.user_type AS 'User Type', u.id AS 'id', u.first_name AS 'User Name', pricings.pricing_name AS 'Price level', pricings.discount_level AS 'Discount in %'
  FROM users AS u
  JOIN profiles AS p 
  ON u.id = p.client_id 
  LEFT JOIN pricings
  ON pricings.id = p.price_level
  WHERE p.user_type = 4
   ;
 
 -- SHOW all requests wich where processed by Account managers
SELECT r.request_id AS 'request id', r.user_id AS 'user id', u.first_name AS 'User Name', r.for_car_id AS 'User CAR ID', r.request_content AS 'User TEXT', p.price_level, pricings.pricing_name AS 'discount name', 
 pricings.discount_level AS 'Discount in %', r.manager_id
 FROM users AS u
 LEFT JOIN requests AS r
 ON u.id = r.user_id 
 LEFT JOIN profiles AS p
 ON p.client_id = u.id 
 LEFT JOIN pricings
 ON pricings.id = p.price_level
 WHERE manager_id BETWEEN 4 AND 6
 ORDER BY manager_id 
 ;
-- VIEW select users who has no cars in garage 
DROP VIEW IF EXISTS garage_view;
CREATE VIEW garage_view
AS SELECT u.id, u.first_name
  FROM users AS u
   LEFT JOIN garage AS g
     ON u.id = g.user_id 
     WHERE g.user_id IS NULL;

    SELECT * FROM garage_view;

   -- VIEW SHOW customers without orders
DROP VIEW IF EXISTS orders_view;
CREATE VIEW orders_view
AS SELECT u.id, u.first_name, o.user_id 
  FROM users AS u
   LEFT JOIN orders AS o
     ON u.id = o.user_id 
     WHERE o.user_id IS NULL;

    SELECT * FROM orders_view;
   
 -- VIEW SHOW customers with orders and their numbers
 DROP VIEW IF EXISTS orders_view_not_null;
   CREATE VIEW orders_view_not_null
AS SELECT u.id, u.first_name, o.order_id AS 'Order Numbers' 
  FROM users AS u
   LEFT JOIN orders AS o
     ON u.id = o.user_id 
     WHERE o.user_id IS NOT NULL;

    SELECT * FROM orders_view_not_null;
   
-- procedure to calculate all orders    
DELIMITER //
DROP PROCEDURE IF EXISTS numorders//
CREATE PROCEDURE numorders (OUT total INT)
BEGIN
  SELECT COUNT(*) INTO total FROM orders;
END//

CALL numorders(@'Всего заказов')//
SELECT @'Всего заказов'//

DELIMITER ;

-- triggers for requests and orders, special table for managers to take data into their terminals when new request or oder appeared. 
DROP TABLE IF EXISTS managers_alerts_logs;
   CREATE TABLE managers_alerts_logs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    table_name varchar(50) NOT NULL,
    row_order_id INT UNSIGNED NOT NULL,
    row_user_name INT UNSIGNED NOT NULL,
    row_cost_sum INT UNSIGNED NOT NULL DEFAULT 0,
    updated_at DATETIME
) ENGINE = Archive;


DELIMITER //
DROP TRIGGER IF EXISTS orders_insertion//
CREATE TRIGGER orders_insertion 
AFTER INSERT ON orders
FOR EACH ROW BEGIN 
INSERT INTO managers_alerts_logs VALUES(NULL, DEFAULT, 'new_order', NEW.order_id , NEW.user_id, NEW.order_cost, NEW.created_at);
END//


DELIMITER //
DROP TRIGGER IF EXISTS requests_insertion//
CREATE TRIGGER requests_insertion 
AFTER INSERT ON requests
FOR EACH ROW BEGIN 
	INSERT INTO managers_alerts_logs VALUES (NULL, DEFAULT, 'new_request', NEW.request_id, NEW.user_id, DEFAULT, NEW.created_at);
END //
DELIMITER ;
-- add new rows to order and to request. Show table with worked triggers/
INSERT INTO orders VALUES (NULL,'37','94','23453','4','61','17','99',DEFAULT,DEFAULT);
INSERT INTO requests VALUES (NULL,'92','March Harehite Rabbit with pink eyes ran close.','78907088355885615','703954634','28','52','6','On which Seven looked up eagerly, half hoping she',DEFAULT,DEFAULT);
SELECT * FROM managers_alerts_logs; 
