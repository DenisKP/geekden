-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: localhost    Database: existru
-- ------------------------------------------------------
-- Server version	8.0.21-0ubuntu0.20.04.4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alert_types`
--

DROP TABLE IF EXISTS `alert_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert_types` (
  `alerts_type_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'alert_type id',
  `alert_type_name` varchar(255) NOT NULL COMMENT 'type name for example - messages',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`alerts_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='alert types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_types`
--

LOCK TABLES `alert_types` WRITE;
/*!40000 ALTER TABLE `alert_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `alerts_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'alerts id',
  `alert_type` int unsigned NOT NULL COMMENT 'link to alert types',
  `user_id` int unsigned NOT NULL COMMENT 'user_id',
  `sms_alert` tinyint(1) DEFAULT NULL COMMENT 'sms alert yes or no',
  `email_alert` tinyint(1) DEFAULT NULL COMMENT 'email alert yes or no',
  `call_alert` tinyint(1) DEFAULT NULL COMMENT 'manager will call by phone with voice message',
  `social_alert` tinyint(1) DEFAULT NULL COMMENT 'manager will use social network to contact with customer',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`alerts_id`),
  KEY `alerts_FK` (`alert_type`),
  KEY `alerts_FK_1` (`user_id`),
  CONSTRAINT `alerts_FK` FOREIGN KEY (`alert_type`) REFERENCES `alert_types` (`alerts_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `alerts_FK_1` FOREIGN KEY (`user_id`) REFERENCES `profiles` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='alerts for any situation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `garage`
--

DROP TABLE IF EXISTS `garage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `garage` (
  `vehicle_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'user vehicle id',
  `user_id` int unsigned NOT NULL COMMENT 'user_id',
  `vin` varchar(17) NOT NULL COMMENT 'vin number of vehicle',
  `chassis` varchar(17) DEFAULT NULL COMMENT 'chassis number of vehicle',
  `engine` int unsigned NOT NULL COMMENT 'engine number',
  `media_attached` int unsigned DEFAULT NULL COMMENT 'link to car logo or photo',
  `vehicle_power` int unsigned DEFAULT NULL COMMENT 'vehicle power in horse units',
  `color` varchar(255) DEFAULT NULL COMMENT 'vehicle color',
  `year_of_issue` int NOT NULL COMMENT 'vehicle year of issue',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`vehicle_id`),
  KEY `garage_FK` (`user_id`),
  KEY `garage_FK_1` (`media_attached`),
  CONSTRAINT `garage_FK` FOREIGN KEY (`user_id`) REFERENCES `profiles` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `garage_FK_1` FOREIGN KEY (`media_attached`) REFERENCES `media_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Users Garage';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garage`
--

LOCK TABLES `garage` WRITE;
/*!40000 ALTER TABLE `garage` DISABLE KEYS */;
/*!40000 ALTER TABLE `garage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_content`
--

DROP TABLE IF EXISTS `media_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_content` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'media id',
  `user_id` int unsigned NOT NULL COMMENT 'Link to user who uploaded and owner of picture',
  `filename` varchar(255) NOT NULL COMMENT 'file name',
  `file_size` int NOT NULL COMMENT 'File size',
  `metadata` json DEFAULT NULL COMMENT 'Metadata',
  `media_type_id` int unsigned NOT NULL COMMENT 'link to Media type id',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `media_content_FK` (`media_type_id`),
  KEY `media_content_FK_1` (`user_id`),
  CONSTRAINT `media_content_FK` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_content_FK_1` FOREIGN KEY (`user_id`) REFERENCES `profiles` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Mediafiles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_content`
--

LOCK TABLES `media_content` WRITE;
/*!40000 ALTER TABLE `media_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Stroke identifier',
  `name` varchar(255) NOT NULL COMMENT 'Name type',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Mediafiles types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'order id',
  `user_id` int unsigned NOT NULL COMMENT 'user_id',
  `order_content` int NOT NULL COMMENT 'order content id',
  `order_cost` int unsigned NOT NULL COMMENT 'total order cost include delivery',
  `manager_id` int unsigned NOT NULL COMMENT 'manager id who will lead that order',
  `delivery_adress` int unsigned NOT NULL COMMENT 'delivery adress id',
  `for_car_id` int unsigned DEFAULT NULL COMMENT 'for which vehicle order what exists',
  `request_number` int unsigned DEFAULT NULL COMMENT 'if request was initiated user can choose request number to simplify order, if not request number = NULL',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`order_id`),
  KEY `orders_FK` (`user_id`),
  KEY `orders_FK_1` (`delivery_adress`),
  KEY `orders_FK_2` (`for_car_id`),
  KEY `orders_FK_3` (`request_number`),
  CONSTRAINT `orders_FK` FOREIGN KEY (`user_id`) REFERENCES `profiles` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_FK_1` FOREIGN KEY (`delivery_adress`) REFERENCES `users_adresses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_FK_2` FOREIGN KEY (`for_car_id`) REFERENCES `garage` (`vehicle_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orders_FK_3` FOREIGN KEY (`request_number`) REFERENCES `requests` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Orders';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricings`
--

DROP TABLE IF EXISTS `pricings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pricings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'type id',
  `pricing_name` varchar(255) NOT NULL COMMENT 'prices type name',
  `discount_level` int NOT NULL DEFAULT '0' COMMENT 'discount in %',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='discount programm';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricings`
--

LOCK TABLES `pricings` WRITE;
/*!40000 ALTER TABLE `pricings` DISABLE KEYS */;
/*!40000 ALTER TABLE `pricings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `client_id` int unsigned NOT NULL COMMENT 'client code, can be changed by manager, to help identify between shops',
  `user_type` enum('Cutomer - Private person','Customer - Legal Entity','Supplier - Legal Entity','Supplier - Private person','Account manager - web portal','Administrator','Super Administrator') DEFAULT NULL,
  `price_level` int unsigned NOT NULL DEFAULT '1' COMMENT 'Price level',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`client_id`),
  KEY `profiles_FK_1` (`price_level`),
  CONSTRAINT `profiles_FK` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `profiles_FK_1` FOREIGN KEY (`price_level`) REFERENCES `pricings` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Profile info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regions` (
  `region_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'region identifier',
  `name` varchar(100) NOT NULL COMMENT 'region name',
  `delivery_time` int NOT NULL COMMENT 'approx delivery time to region from main warehousein days',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Delivery regions and office locator';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests` (
  `request_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'request id',
  `user_id` int unsigned NOT NULL COMMENT 'user_id',
  `request_content` text NOT NULL COMMENT 'text area for request',
  `vin` varchar(17) DEFAULT NULL COMMENT 'vin number of vehicle if customer has no vehicles in garage',
  `engine` int unsigned NOT NULL COMMENT 'engine number if customer has no vehicles in garage',
  `for_car_id` int unsigned DEFAULT NULL COMMENT 'for which vehicle order what exists',
  `media_attached` int unsigned DEFAULT NULL COMMENT 'link to media content if user want to show needed part or something else',
  `manager_id` int unsigned NOT NULL COMMENT 'manager id who will lead that order',
  `manager_reply` text COMMENT 'manager reply for request',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`request_id`),
  KEY `requests_FK_1` (`for_car_id`),
  KEY `requests_FK` (`user_id`),
  KEY `requests_FK_2` (`media_attached`),
  CONSTRAINT `requests_FK` FOREIGN KEY (`user_id`) REFERENCES `profiles` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `requests_FK_1` FOREIGN KEY (`for_car_id`) REFERENCES `garage` (`vehicle_id`) ON UPDATE CASCADE,
  CONSTRAINT `requests_FK_2` FOREIGN KEY (`media_attached`) REFERENCES `media_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Spare parts Requests';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_nets`
--

DROP TABLE IF EXISTS `social_nets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_nets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'social network id',
  `network_name` varchar(255) NOT NULL COMMENT 'network name',
  `network_icon` int unsigned NOT NULL COMMENT 'link to network icon id from media content',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `social_net_FK` (`network_icon`),
  CONSTRAINT `social_net_FK` FOREIGN KEY (`network_icon`) REFERENCES `media_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Social Networks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_nets`
--

LOCK TABLES `social_nets` WRITE;
/*!40000 ALTER TABLE `social_nets` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_nets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_network_passports`
--

DROP TABLE IF EXISTS `social_network_passports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_network_passports` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'social_network_passport identifier',
  `user_id` int unsigned NOT NULL COMMENT 'user id, who use social network, needed because user can be registered in different social networks',
  `profile_link` varchar(255) DEFAULT NULL COMMENT 'Link to social network profile',
  `social_net` int unsigned NOT NULL COMMENT 'linl to social name and icon',
  `login_by` tinyint(1) DEFAULT NULL COMMENT 'login by social network boolean yes or no',
  `visiblility` tinyint(1) DEFAULT NULL COMMENT 'visibility of social networks information for other users or managers',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `social_network_passport_FK_1` (`user_id`),
  KEY `social_network_passport_FK` (`social_net`),
  CONSTRAINT `social_network_passport_FK` FOREIGN KEY (`social_net`) REFERENCES `social_nets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `social_network_passport_FK_1` FOREIGN KEY (`user_id`) REFERENCES `profiles` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='social network passport';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_network_passports`
--

LOCK TABLES `social_network_passports` WRITE;
/*!40000 ALTER TABLE `social_network_passports` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_network_passports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'User identifier',
  `first_name` varchar(100) NOT NULL COMMENT 'User name',
  `last_name` varchar(100) NOT NULL COMMENT 'User surname',
  `middle_name` varchar(100) NOT NULL COMMENT 'User middle name',
  `email` varchar(100) NOT NULL COMMENT 'User email',
  `phone` varchar(100) NOT NULL COMMENT 'Phone number',
  `home_region` int unsigned NOT NULL COMMENT 'home region',
  `main_adress` int unsigned NOT NULL COMMENT 'main adress id for documents',
  `gender` char(1) DEFAULT NULL COMMENT 'User gender',
  `birthday` date DEFAULT NULL COMMENT 'Birthday date',
  `photo_id` int unsigned NOT NULL DEFAULT '1' COMMENT 'Link to user avatar',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `main_adress` (`main_adress`),
  KEY `users_FK` (`home_region`),
  KEY `users_FK_2` (`photo_id`),
  CONSTRAINT `users_FK` FOREIGN KEY (`home_region`) REFERENCES `regions` (`region_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_FK_1` FOREIGN KEY (`main_adress`) REFERENCES `users_adresses` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `users_FK_2` FOREIGN KEY (`photo_id`) REFERENCES `media_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Users info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_adresses`
--

DROP TABLE IF EXISTS `users_adresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_adresses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'User delivery adress identifier',
  `user_id` int unsigned NOT NULL COMMENT 'user id, because users can have a lot of delivery adresses',
  `zip_code` int DEFAULT NULL COMMENT 'ZIP CODE',
  `city` varchar(100) DEFAULT NULL COMMENT 'USER CITY',
  `street_name` varchar(100) DEFAULT NULL COMMENT 'street name without building number',
  `building` varchar(10) DEFAULT NULL COMMENT 'building number',
  `appartment` varchar(5) DEFAULT NULL COMMENT 'appart number',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `user_adress_FK` (`user_id`),
  CONSTRAINT `user_adress_FK` FOREIGN KEY (`user_id`) REFERENCES `profiles` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Users adress book and delivery adresses';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_adresses`
--

LOCK TABLES `users_adresses` WRITE;
/*!40000 ALTER TABLE `users_adresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_adresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_comments`
--

DROP TABLE IF EXISTS `users_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_comments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'user_comments id',
  `user_id` int unsigned NOT NULL COMMENT 'user_id',
  `comment_content` text NOT NULL COMMENT 'comment content',
  `comment_type` int unsigned NOT NULL COMMENT 'comment type id',
  `commented_id` int unsigned NOT NULL COMMENT 'to what post or to what spare part id',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'creation time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `user_comments_FK` (`user_id`),
  CONSTRAINT `user_comments_FK` FOREIGN KEY (`user_id`) REFERENCES `profiles` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Comments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_comments`
--

LOCK TABLES `users_comments` WRITE;
/*!40000 ALTER TABLE `users_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_comments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-13 15:06:53
