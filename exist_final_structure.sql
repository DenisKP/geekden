DROP DATABASE IF EXISTS existru; 
CREATE DATABASE IF NOT EXISTS existru;
USE existru;
-- tables 
-- Users personal data of user 
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "User identifier", 
  first_name VARCHAR(100) NOT NULL COMMENT "User name",
  last_name VARCHAR(100) NOT NULL COMMENT "User surname",
  middle_name VARCHAR(100) NOT NULL COMMENT "User middle name",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "User email",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Phone number",
  home_region INT UNSIGNED NOT NULL COMMENT "home region",
  main_adress INT UNSIGNED NOT NULL UNIQUE COMMENT "main adress id for documents",
  gender CHAR(1) COMMENT "User gender",
  birthday DATE COMMENT "Birthday date",
  photo_id INT UNSIGNED NOT NULL DEFAULT "1" COMMENT "Link to user avatar",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "Users info";  
-- Profile data with internal info
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  client_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "client code, can be changed by manager, to help identify between shops", 
  user_type ENUM('Cutomer - Private person','Customer - Legal Entity', 'Supplier - Legal Entity',
  	'Supplier - Private person', 'Account manager - web portal', 'Administrator', 'Super Administrator' ), 
  price_level INT UNSIGNED NOT NULL DEFAULT 1 COMMENT "Price level",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "Profile info"; 

-- Delivery regions
DROP TABLE IF EXISTS regions;
CREATE TABLE IF NOT EXISTS regions (
  region_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "region identifier",
  name VARCHAR(100) NOT NULL COMMENT "region name",
  delivery_time INT NOT NULL COMMENT "approx delivery time to region from main warehousein days",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "Delivery regions and office locator";

-- addresses
DROP TABLE IF EXISTS users_adresses;
CREATE TABLE IF NOT EXISTS users_adresses (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "User delivery adress identifier", 
	user_id INT UNSIGNED NOT NULL COMMENT "user id, because users can have a lot of delivery adresses",
	zip_code INT COMMENT "ZIP CODE",
	city VARCHAR(100) COMMENT "USER CITY",
	street_name VARCHAR(100) COMMENT "street name without building number",
	building VARCHAR(10) COMMENT "building number",
	appartment VARCHAR(5) COMMENT "appart number",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
)  COMMENT "Users adress book and delivery adresses";
-- media
DROP TABLE IF EXISTS media_content;
CREATE TABLE IF NOT EXISTS media_content (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "media id",
    user_id INT UNSIGNED NOT NULL COMMENT "Link to user who uploaded and owner of picture",
    filename VARCHAR(255) NOT NULL COMMENT "file name",
    file_size INT NOT NULL COMMENT "File size",
    metadata JSON COMMENT "Metadata",
    media_type_id INT UNSIGNED NOT NULL COMMENT "link to Media type id",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "Mediafiles";
-- media types 
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Stroke identifier",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Name type",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "Mediafiles types";

-- social network passport
DROP TABLE IF EXISTS social_network_passports;
CREATE TABLE IF NOT EXISTS social_network_passports (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "social_network_passport identifier", 
	user_id INT UNSIGNED NOT NULL COMMENT "user id, who use social network, needed because user can be registered in different social networks",
	profile_link VARCHAR(255) COMMENT "Link to social network profile",
	social_net INT UNSIGNED NOT NULL COMMENT "linl to social name and icon",
	login_by BOOLEAN default NULL COMMENT "login by social network boolean yes or no",
	visiblility BOOLEAN default NULL COMMENT "visibility of social networks information for other users or managers",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
)  COMMENT "social network passport";
-- socials networks
DROP TABLE IF EXISTS social_nets;
CREATE TABLE IF NOT EXISTS social_nets (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "social network id",
    network_name VARCHAR(255) NOT NULL COMMENT "network name",
    network_icon INT UNSIGNED NOT NULL COMMENT "link to network icon id from media content",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "Social Networks";

-- comments
DROP TABLE IF EXISTS users_comments;
CREATE TABLE IF NOT EXISTS users_comments (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "user_comments id",
    user_id INT UNSIGNED NOT NULL COMMENT "user_id",
    comment_content TEXT NOT NULL COMMENT "comment content",
    comment_type INT UNSIGNED NOT NULL COMMENT "comment type id",
    commented_id INT UNSIGNED NOT NULL COMMENT "to what post or to what spare part id",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "Comments";


-- pricing
DROP TABLE IF EXISTS pricings;
CREATE TABLE IF NOT EXISTS pricings (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "type id",
    pricing_name VARCHAR(255) NOT NULL COMMENT "prices type name",
    discount_level INT(2) NOT NULL DEFAULT 0 COMMENT "discount in %",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "discount programm";

-- orders
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders (
	order_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "order id",
    user_id INT UNSIGNED NOT NULL COMMENT "user_id",
    order_content INT NOT NULL COMMENT "order content id",
    order_cost INT UNSIGNED NOT NULL COMMENT "total order cost include delivery",
    manager_id INT UNSIGNED NOT NULL COMMENT "manager id who will lead that order",
    delivery_adress INT UNSIGNED NOT NULL COMMENT "delivery adress id",
    for_car_id INT UNSIGNED COMMENT "for which vehicle order what exists",
    request_number INT UNSIGNED DEFAULT NULL COMMENT "if request was initiated user can choose request number to simplify order, if not request number = NULL",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "Orders";

-- requests
DROP TABLE IF EXISTS requests;
CREATE TABLE IF NOT EXISTS requests (
	request_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "request id",
    user_id INT UNSIGNED NOT NULL COMMENT "user_id",
    request_content TEXT NOT NULL COMMENT "text area for request",
    vin VARCHAR(17) COMMENT "vin number of vehicle if customer has no vehicles in garage",
    engine INT UNSIGNED NOT NULL COMMENT "engine number if customer has no vehicles in garage",
    for_car_id INT UNSIGNED COMMENT "for which vehicle order what exists",
    media_attached INT UNSIGNED COMMENT "link to media content if user want to show needed part or something else",
    manager_id INT UNSIGNED NOT NULL COMMENT "manager id who will lead that order",
    manager_reply TEXT COMMENT "manager reply for request",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "Spare parts Requests";

-- garage
DROP TABLE IF EXISTS garage;
CREATE TABLE IF NOT EXISTS garage (
	vehicle_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "user vehicle id",
    user_id INT UNSIGNED NOT NULL COMMENT "user_id",
    vin VARCHAR(17) NOT NULL COMMENT "vin number of vehicle",
    chassis VARCHAR(17) COMMENT "chassis number of vehicle",
    engine INT UNSIGNED NOT NULL COMMENT "engine number",
    media_attached INT UNSIGNED COMMENT "link to car logo or photo",
    vehicle_power INT(6) UNSIGNED COMMENT "vehicle power in horse units",
    color VARCHAR(255) COMMENT "vehicle color",
    year_of_issue INT(4) NOT NULL COMMENT "vehicle year of issue",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "Users Garage";
-- alerts
DROP TABLE IF EXISTS alerts;
CREATE TABLE IF NOT EXISTS alerts (
	alerts_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "alerts id",
	alert_type INT UNSIGNED NOT NULL COMMENT "link to alert types",
    user_id INT UNSIGNED NOT NULL COMMENT "user_id",
    sms_alert BOOLEAN default NULL COMMENT "sms alert yes or no",
    email_alert BOOLEAN default NULL COMMENT "email alert yes or no",
    call_alert BOOLEAN default NULL COMMENT "manager will call by phone with voice message",
    social_alert BOOLEAN default NULL COMMENT "manager will use social network to contact with customer",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "alerts for any situation";
-- alert types
DROP TABLE IF EXISTS alert_types;
CREATE TABLE IF NOT EXISTS alert_types (
	alerts_type_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "alert_type id",
	alert_type_name VARCHAR(255) NOT NULL COMMENT "type name for example - messages",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "creation time",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "update time"
) COMMENT "alert types";




	