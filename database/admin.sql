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
-- Dumping data for table `admin_menu`
--

LOCK TABLES `admin_menu` WRITE;
/*!40000 ALTER TABLE `admin_menu` DISABLE KEYS */;
INSERT INTO `admin_menu` VALUES (1,0,1,'Index','feather icon-bar-chart-2','/','',1,'2021-09-02 02:55:09',NULL),(2,0,2,'Admin','feather icon-settings','','',1,'2021-09-02 02:55:09',NULL),(3,2,3,'Users','','auth/users','',1,'2021-09-02 02:55:09',NULL),(4,2,4,'Roles','','auth/roles','',1,'2021-09-02 02:55:09',NULL),(5,2,5,'Permission','','auth/permissions','',1,'2021-09-02 02:55:09',NULL),(6,2,6,'Menu','','auth/menu','',1,'2021-09-02 02:55:09',NULL),(7,2,7,'Extensions','','auth/extensions','',1,'2021-09-02 02:55:09',NULL),(8,0,8,'用户管理','fa-users','users','',1,'2021-09-02 03:30:39','2021-09-02 03:30:39'),(9,0,9,'商品管理','fa-cubes','products','',1,'2021-09-02 03:31:40','2021-09-02 03:31:40'),(10,0,10,'优惠券管理','fa-tags','coupons','',1,'2021-09-04 03:33:25','2021-09-04 03:33:25'),(11,0,11,'订单管理','fa-rmb','orders','',1,'2021-09-07 07:20:11','2021-09-07 07:20:11'),(14,0,14,'退款列表','fa-hand-o-up','refund','',1,'2021-09-08 06:42:44','2021-09-08 06:56:00'),(15,0,15,'商品类目管理','fa-bars','categories','',1,'2021-09-10 02:07:57','2021-09-10 02:08:47'),(17,9,17,'普通商品管理','fa-cubes','products','',1,'2021-09-13 08:07:40','2021-09-13 08:10:51'),(18,9,18,'众筹商品管理','fa-flag-checkered','crowdfunding_products','',1,'2021-09-13 08:08:22','2021-09-14 02:08:46'),(19,9,19,'秒杀商品','fa-bolt','seckill_products','',1,'2021-09-21 08:04:51','2021-09-21 08:04:51');
/*!40000 ALTER TABLE `admin_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_permission_menu`
--

LOCK TABLES `admin_permission_menu` WRITE;
/*!40000 ALTER TABLE `admin_permission_menu` DISABLE KEYS */;
INSERT INTO `admin_permission_menu` VALUES (1,2,'2021-09-02 03:22:28','2021-09-02 03:22:28'),(2,3,'2021-09-02 03:22:35','2021-09-02 03:22:35'),(3,4,'2021-09-02 03:22:40','2021-09-02 03:22:40'),(4,5,'2021-09-02 03:22:45','2021-09-02 03:22:45'),(5,6,'2021-09-02 03:22:50','2021-09-02 03:22:50'),(6,7,'2021-09-02 03:22:54','2021-09-02 03:22:54');
/*!40000 ALTER TABLE `admin_permission_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_permissions`
--

LOCK TABLES `admin_permissions` WRITE;
/*!40000 ALTER TABLE `admin_permissions` DISABLE KEYS */;
INSERT INTO `admin_permissions` VALUES (1,'Auth management','auth-management','','',1,0,'2021-09-02 02:55:09',NULL),(2,'Users','users','','/auth/users*',2,1,'2021-09-02 02:55:09',NULL),(3,'Roles','roles','','/auth/roles*',3,1,'2021-09-02 02:55:09',NULL),(4,'Permissions','permissions','','/auth/permissions*',4,1,'2021-09-02 02:55:09',NULL),(5,'Menu','menu','','/auth/menu*',5,1,'2021-09-02 02:55:09',NULL),(6,'Extension','extension','','/auth/extensions*',6,1,'2021-09-02 02:55:09',NULL);
/*!40000 ALTER TABLE `admin_permissions` ENABLE KEYS */;
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
/*!40000 ALTER TABLE `admin_role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_role_users`
--

LOCK TABLES `admin_role_users` WRITE;
/*!40000 ALTER TABLE `admin_role_users` DISABLE KEYS */;
INSERT INTO `admin_role_users` VALUES (1,1,'2021-09-02 02:55:09','2021-09-02 02:55:09');
/*!40000 ALTER TABLE `admin_role_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_roles`
--

LOCK TABLES `admin_roles` WRITE;
/*!40000 ALTER TABLE `admin_roles` DISABLE KEYS */;
INSERT INTO `admin_roles` VALUES (1,'Administrator','administrator','2021-09-02 02:55:09','2021-09-02 02:55:09');
/*!40000 ALTER TABLE `admin_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'admin','$2y$10$CjSyenpvkB/Ftb1QTC96B.MdsQDleoaqtwjr5t/yeUr2BcgtkV0Uu','Administrator',NULL,NULL,'2021-09-02 02:55:09','2021-09-02 02:55:09');
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

-- Dump completed on 2021-09-22 14:12:10
