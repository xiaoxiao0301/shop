-- MySQL dump 10.13  Distrib 5.7.35, for Linux (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	5.7.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `admin_extension_histories`
--

LOCK TABLES `admin_extension_histories` WRITE;
/*!40000 ALTER TABLE `admin_extension_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_extension_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_extensions`
--

LOCK TABLES `admin_extensions` WRITE;
/*!40000 ALTER TABLE `admin_extensions` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_menu`
--

LOCK TABLES `admin_menu` WRITE;
/*!40000 ALTER TABLE `admin_menu` DISABLE KEYS */;
INSERT INTO `admin_menu` VALUES (1,0,1,'Index','feather icon-bar-chart-2','/','',1,'2021-08-26 03:00:07',NULL),(2,0,2,'Admin','feather icon-settings','','',1,'2021-08-26 03:00:07',NULL),(3,2,3,'Users','','auth/users','',1,'2021-08-26 03:00:07',NULL),(4,2,4,'Roles','','auth/roles','',1,'2021-08-26 03:00:07',NULL),(5,2,5,'Permission','','auth/permissions','',1,'2021-08-26 03:00:07',NULL),(6,2,6,'Menu','','auth/menu','',1,'2021-08-26 03:00:07',NULL),(7,2,7,'Extensions','','auth/extensions','',1,'2021-08-26 03:00:07',NULL),(8,0,8,'用户管理','fa-user','users','',1,'2021-08-26 03:00:49','2021-08-26 03:00:49'),(9,0,9,'商品管理',NULL,NULL,'',1,'2021-08-26 03:00:59','2021-08-26 03:00:59'),(10,9,10,'商品列表','fa-cart-plus','products','',1,'2021-08-26 03:01:32','2021-08-26 03:01:32'),(11,9,11,'商品SKU列表','fa-align-justify','skus','',1,'2021-08-26 03:02:01','2021-08-26 03:02:18'),(12,0,12,'订单管理','fa-cc-paypal','orders','',1,'2021-08-30 05:58:22','2021-08-30 05:58:22'),(13,0,13,'优惠券管理','fa-credit-card','coupons','',1,'2021-08-31 01:04:01','2021-08-31 01:04:01');
/*!40000 ALTER TABLE `admin_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_permissions`
--

LOCK TABLES `admin_permissions` WRITE;
/*!40000 ALTER TABLE `admin_permissions` DISABLE KEYS */;
INSERT INTO `admin_permissions` VALUES (1,'Auth management','auth-management','','',1,0,'2021-08-26 03:00:07',NULL),(2,'Users','users','','/auth/users*',2,1,'2021-08-26 03:00:07',NULL),(3,'Roles','roles','','/auth/roles*',3,1,'2021-08-26 03:00:07',NULL),(4,'Permissions','permissions','','/auth/permissions*',4,1,'2021-08-26 03:00:07',NULL),(5,'Menu','menu','','/auth/menu*',5,1,'2021-08-26 03:00:07',NULL),(6,'Extension','extension','','/auth/extensions*',6,1,'2021-08-26 03:00:07',NULL),(7,'用户','user','','/users*',7,0,'2021-08-31 07:20:23','2021-08-31 07:20:23'),(8,'商品','product','','/products*,/skus*',8,0,'2021-08-31 07:24:47','2021-08-31 07:29:08'),(9,'订单','order','','/orders*',9,0,'2021-08-31 07:25:30','2021-08-31 07:25:30'),(10,'优惠券','coupon_code','','/coupons*',10,0,'2021-08-31 07:26:02','2021-08-31 07:26:02');
/*!40000 ALTER TABLE `admin_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_permission_menu`
--

LOCK TABLES `admin_permission_menu` WRITE;
/*!40000 ALTER TABLE `admin_permission_menu` DISABLE KEYS */;
INSERT INTO `admin_permission_menu` VALUES (1,2,'2021-08-31 07:23:42','2021-08-31 07:23:42'),(2,3,'2021-08-31 07:23:48','2021-08-31 07:23:48'),(3,4,'2021-08-31 07:23:54','2021-08-31 07:23:54'),(4,5,'2021-08-31 07:23:59','2021-08-31 07:23:59'),(5,6,'2021-08-31 07:24:04','2021-08-31 07:24:04'),(6,7,'2021-08-31 07:24:09','2021-08-31 07:24:09'),(7,8,'2021-08-31 07:20:23','2021-08-31 07:20:23'),(8,9,'2021-08-31 07:24:47','2021-08-31 07:24:47'),(8,10,'2021-08-31 07:24:47','2021-08-31 07:24:47'),(8,11,'2021-08-31 07:24:47','2021-08-31 07:24:47'),(9,12,'2021-08-31 07:25:30','2021-08-31 07:25:30'),(10,13,'2021-08-31 07:26:02','2021-08-31 07:26:02');
/*!40000 ALTER TABLE `admin_permission_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_role_menu`
--

LOCK TABLES `admin_role_menu` WRITE;
/*!40000 ALTER TABLE `admin_role_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_role_permissions`
--

LOCK TABLES `admin_role_permissions` WRITE;
/*!40000 ALTER TABLE `admin_role_permissions` DISABLE KEYS */;
INSERT INTO `admin_role_permissions` VALUES (2,7,'2021-08-31 07:20:50','2021-08-31 07:20:50'),(2,8,'2021-08-31 07:26:41','2021-08-31 07:26:41'),(2,9,'2021-08-31 07:26:41','2021-08-31 07:26:41'),(2,10,'2021-08-31 07:26:41','2021-08-31 07:26:41');
/*!40000 ALTER TABLE `admin_role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_role_users`
--

LOCK TABLES `admin_role_users` WRITE;
/*!40000 ALTER TABLE `admin_role_users` DISABLE KEYS */;
INSERT INTO `admin_role_users` VALUES (1,1,'2021-08-26 03:00:07','2021-08-26 03:00:07'),(2,2,'2021-08-31 07:21:18','2021-08-31 07:21:18');
/*!40000 ALTER TABLE `admin_role_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_roles`
--

LOCK TABLES `admin_roles` WRITE;
/*!40000 ALTER TABLE `admin_roles` DISABLE KEYS */;
INSERT INTO `admin_roles` VALUES (1,'Administrator','administrator','2021-08-26 03:00:07','2021-08-26 03:00:07'),(2,'运营','operator','2021-08-31 07:20:50','2021-08-31 07:20:50');
/*!40000 ALTER TABLE `admin_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_settings`
--

LOCK TABLES `admin_settings` WRITE;
/*!40000 ALTER TABLE `admin_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'admin','$2y$10$6zJFMH2yKHnVuVHtLMlY.eD9Cenxj.iLbqt8ZWZVReZCkYiiWOB1G','Administrator',NULL,NULL,'2021-08-26 03:00:07','2021-08-26 03:00:07'),(2,'operator','$2y$10$JMb704N3BLbzHe3//u/RWOTLCTx9FgsgK21mGL2OA/e9Qs3O2tOf6','运营','images/3aceca8de3f99ae6bfeb97718e09ab17.jpeg',NULL,'2021-08-31 07:21:18','2021-08-31 07:21:18');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-31 15:56:01
