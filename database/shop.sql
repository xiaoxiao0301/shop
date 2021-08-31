/*
 Navicat Premium Data Transfer

 Source Server         : docker-mysql
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : localhost:13306
 Source Schema         : shop

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 31/08/2021 16:01:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_extension_histories
-- ----------------------------
DROP TABLE IF EXISTS `admin_extension_histories`;
CREATE TABLE `admin_extension_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '1',
  `version` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `detail` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_extension_histories_name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_extension_histories
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for admin_extensions
-- ----------------------------
DROP TABLE IF EXISTS `admin_extensions`;
CREATE TABLE `admin_extensions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `is_enabled` tinyint(4) NOT NULL DEFAULT '0',
  `options` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_extensions_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_extensions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL DEFAULT '0',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uri` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `show` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_menu
-- ----------------------------
BEGIN;
INSERT INTO `admin_menu` VALUES (1, 0, 1, 'Index', 'feather icon-bar-chart-2', '/', '', 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_menu` VALUES (2, 0, 2, 'Admin', 'feather icon-settings', '', '', 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_menu` VALUES (3, 2, 3, 'Users', '', 'auth/users', '', 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_menu` VALUES (4, 2, 4, 'Roles', '', 'auth/roles', '', 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_menu` VALUES (5, 2, 5, 'Permission', '', 'auth/permissions', '', 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_menu` VALUES (6, 2, 6, 'Menu', '', 'auth/menu', '', 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_menu` VALUES (7, 2, 7, 'Extensions', '', 'auth/extensions', '', 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_menu` VALUES (8, 0, 8, '用户管理', 'fa-user', 'users', '', 1, '2021-08-26 11:00:49', '2021-08-26 11:00:49');
INSERT INTO `admin_menu` VALUES (9, 0, 9, '商品管理', NULL, NULL, '', 1, '2021-08-26 11:00:59', '2021-08-26 11:00:59');
INSERT INTO `admin_menu` VALUES (10, 9, 10, '商品列表', 'fa-cart-plus', 'products', '', 1, '2021-08-26 11:01:32', '2021-08-26 11:01:32');
INSERT INTO `admin_menu` VALUES (11, 9, 11, '商品SKU列表', 'fa-align-justify', 'skus', '', 1, '2021-08-26 11:02:01', '2021-08-26 11:02:18');
INSERT INTO `admin_menu` VALUES (12, 0, 12, '订单管理', 'fa-cc-paypal', 'orders', '', 1, '2021-08-30 13:58:22', '2021-08-30 13:58:22');
INSERT INTO `admin_menu` VALUES (13, 0, 13, '优惠券管理', 'fa-credit-card', 'coupons', '', 1, '2021-08-31 09:04:01', '2021-08-31 09:04:01');
COMMIT;

-- ----------------------------
-- Table structure for admin_permission_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_permission_menu`;
CREATE TABLE `admin_permission_menu` (
  `permission_id` bigint(20) NOT NULL,
  `menu_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `admin_permission_menu_permission_id_menu_id_unique` (`permission_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_permission_menu
-- ----------------------------
BEGIN;
INSERT INTO `admin_permission_menu` VALUES (1, 2, '2021-08-31 15:23:42', '2021-08-31 15:23:42');
INSERT INTO `admin_permission_menu` VALUES (2, 3, '2021-08-31 15:23:48', '2021-08-31 15:23:48');
INSERT INTO `admin_permission_menu` VALUES (3, 4, '2021-08-31 15:23:54', '2021-08-31 15:23:54');
INSERT INTO `admin_permission_menu` VALUES (4, 5, '2021-08-31 15:23:59', '2021-08-31 15:23:59');
INSERT INTO `admin_permission_menu` VALUES (5, 6, '2021-08-31 15:24:04', '2021-08-31 15:24:04');
INSERT INTO `admin_permission_menu` VALUES (6, 7, '2021-08-31 15:24:09', '2021-08-31 15:24:09');
INSERT INTO `admin_permission_menu` VALUES (7, 8, '2021-08-31 15:20:23', '2021-08-31 15:20:23');
INSERT INTO `admin_permission_menu` VALUES (8, 9, '2021-08-31 15:24:47', '2021-08-31 15:24:47');
INSERT INTO `admin_permission_menu` VALUES (8, 10, '2021-08-31 15:24:47', '2021-08-31 15:24:47');
INSERT INTO `admin_permission_menu` VALUES (8, 11, '2021-08-31 15:24:47', '2021-08-31 15:24:47');
INSERT INTO `admin_permission_menu` VALUES (9, 12, '2021-08-31 15:25:30', '2021-08-31 15:25:30');
INSERT INTO `admin_permission_menu` VALUES (10, 13, '2021-08-31 15:26:02', '2021-08-31 15:26:02');
COMMIT;

-- ----------------------------
-- Table structure for admin_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_permissions`;
CREATE TABLE `admin_permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `http_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `http_path` text COLLATE utf8mb4_unicode_ci,
  `order` int(11) NOT NULL DEFAULT '0',
  `parent_id` bigint(20) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_permissions_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_permissions
-- ----------------------------
BEGIN;
INSERT INTO `admin_permissions` VALUES (1, 'Auth management', 'auth-management', '', '', 1, 0, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_permissions` VALUES (2, 'Users', 'users', '', '/auth/users*', 2, 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_permissions` VALUES (3, 'Roles', 'roles', '', '/auth/roles*', 3, 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_permissions` VALUES (4, 'Permissions', 'permissions', '', '/auth/permissions*', 4, 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_permissions` VALUES (5, 'Menu', 'menu', '', '/auth/menu*', 5, 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_permissions` VALUES (6, 'Extension', 'extension', '', '/auth/extensions*', 6, 1, '2021-08-26 11:00:07', NULL);
INSERT INTO `admin_permissions` VALUES (7, '用户', 'user', '', '/users*', 7, 0, '2021-08-31 15:20:23', '2021-08-31 15:20:23');
INSERT INTO `admin_permissions` VALUES (8, '商品', 'product', '', '/products*,/skus*', 8, 0, '2021-08-31 15:24:47', '2021-08-31 15:29:08');
INSERT INTO `admin_permissions` VALUES (9, '订单', 'order', '', '/orders*', 9, 0, '2021-08-31 15:25:30', '2021-08-31 15:25:30');
INSERT INTO `admin_permissions` VALUES (10, '优惠券', 'coupon_code', '', '/coupons*', 10, 0, '2021-08-31 15:26:02', '2021-08-31 15:26:02');
COMMIT;

-- ----------------------------
-- Table structure for admin_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_menu`;
CREATE TABLE `admin_role_menu` (
  `role_id` bigint(20) NOT NULL,
  `menu_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `admin_role_menu_role_id_menu_id_unique` (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_role_menu
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for admin_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_permissions`;
CREATE TABLE `admin_role_permissions` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `admin_role_permissions_role_id_permission_id_unique` (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_role_permissions
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_permissions` VALUES (2, 7, '2021-08-31 15:20:50', '2021-08-31 15:20:50');
INSERT INTO `admin_role_permissions` VALUES (2, 8, '2021-08-31 15:26:41', '2021-08-31 15:26:41');
INSERT INTO `admin_role_permissions` VALUES (2, 9, '2021-08-31 15:26:41', '2021-08-31 15:26:41');
INSERT INTO `admin_role_permissions` VALUES (2, 10, '2021-08-31 15:26:41', '2021-08-31 15:26:41');
COMMIT;

-- ----------------------------
-- Table structure for admin_role_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_users`;
CREATE TABLE `admin_role_users` (
  `role_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `admin_role_users_role_id_user_id_unique` (`role_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_role_users
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_users` VALUES (1, 1, '2021-08-26 11:00:07', '2021-08-26 11:00:07');
INSERT INTO `admin_role_users` VALUES (2, 2, '2021-08-31 15:21:18', '2021-08-31 15:21:18');
COMMIT;

-- ----------------------------
-- Table structure for admin_roles
-- ----------------------------
DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE `admin_roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_roles
-- ----------------------------
BEGIN;
INSERT INTO `admin_roles` VALUES (1, 'Administrator', 'administrator', '2021-08-26 11:00:07', '2021-08-26 11:00:07');
INSERT INTO `admin_roles` VALUES (2, '运营', 'operator', '2021-08-31 15:20:50', '2021-08-31 15:20:50');
COMMIT;

-- ----------------------------
-- Table structure for admin_settings
-- ----------------------------
DROP TABLE IF EXISTS `admin_settings`;
CREATE TABLE `admin_settings` (
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_settings
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
BEGIN;
INSERT INTO `admin_users` VALUES (1, 'admin', '$2y$10$6zJFMH2yKHnVuVHtLMlY.eD9Cenxj.iLbqt8ZWZVReZCkYiiWOB1G', 'Administrator', NULL, NULL, '2021-08-26 11:00:07', '2021-08-26 11:00:07');
INSERT INTO `admin_users` VALUES (2, 'operator', '$2y$10$JMb704N3BLbzHe3//u/RWOTLCTx9FgsgK21mGL2OA/e9Qs3O2tOf6', '运营', 'images/3aceca8de3f99ae6bfeb97718e09ab17.jpeg', NULL, '2021-08-31 15:21:18', '2021-08-31 15:21:18');
COMMIT;

-- ----------------------------
-- Table structure for cart_items
-- ----------------------------
DROP TABLE IF EXISTS `cart_items`;
CREATE TABLE `cart_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `product_sku_id` bigint(20) unsigned NOT NULL COMMENT '商品skuID',
  `amount` int(10) unsigned NOT NULL COMMENT '数量',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_items_product_sku_id_foreign` (`product_sku_id`),
  CONSTRAINT `cart_items_product_sku_id_foreign` FOREIGN KEY (`product_sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cart_items
-- ----------------------------
BEGIN;
INSERT INTO `cart_items` VALUES (1, 2648187705527107584, 4, 3, '2021-08-27 15:06:54', '2021-08-28 15:32:18', '2021-08-28 15:32:18');
INSERT INTO `cart_items` VALUES (2, 2648187705556467712, 7, 12, '2021-08-27 15:20:22', '2021-08-27 15:20:22', NULL);
COMMIT;

-- ----------------------------
-- Table structure for coupon_codes
-- ----------------------------
DROP TABLE IF EXISTS `coupon_codes`;
CREATE TABLE `coupon_codes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '优惠券标题',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '优惠券码',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '优惠类型, 固定金额和百分比折扣',
  `value` decimal(8,2) NOT NULL COMMENT '折扣值',
  `total` int(10) unsigned NOT NULL COMMENT '总量',
  `used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前已兑换的数量',
  `min_amount` decimal(10,2) NOT NULL COMMENT '使用该优惠券的最低订单金额',
  `not_before` timestamp NULL DEFAULT NULL COMMENT '在这个时间之前不可用',
  `not_after` timestamp NULL DEFAULT NULL COMMENT '在这个时间之后不可用',
  `enabled` tinyint(1) NOT NULL COMMENT '是否有效',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupon_codes_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of coupon_codes
-- ----------------------------
BEGIN;
INSERT INTO `coupon_codes` VALUES (1, 'sequi enim id', 'H1M29TSRQ1A69WR', 'percent', 17.00, 1000, 0, 111.00, NULL, NULL, 1, '2021-08-31 09:20:11', '2021-08-31 10:00:52', '2021-08-31 10:00:52');
INSERT INTO `coupon_codes` VALUES (2, 'saepe facere repellendus', 'KGIHBRLXGODVUSP', 'percent', 11.00, 1000, 0, 559.00, NULL, NULL, 1, '2021-08-31 09:20:11', '2021-08-31 09:20:11', NULL);
INSERT INTO `coupon_codes` VALUES (3, 'dignissimos distinctio magni', 'HXBUWUMKZRNC4KP', 'fixed', 79.00, 1000, 0, 79.01, NULL, NULL, 1, '2021-08-31 09:20:11', '2021-08-31 09:20:11', NULL);
INSERT INTO `coupon_codes` VALUES (4, 'aliquam beatae illum', 'UDUONFPL3TP94KH', 'percent', 22.00, 1000, 0, 914.00, NULL, NULL, 1, '2021-08-31 09:20:11', '2021-08-31 09:20:11', NULL);
INSERT INTO `coupon_codes` VALUES (5, 'occaecati aut ducimus', 'ADXPXAXZXKQ5FOI', 'percent', 31.00, 1000, 0, 0.00, NULL, NULL, 1, '2021-08-31 09:20:11', '2021-08-31 09:20:11', NULL);
INSERT INTO `coupon_codes` VALUES (6, 'est nam dolor', 'BVQYVSQAB6BQYFB', 'percent', 38.00, 1000, 0, 0.00, NULL, NULL, 1, '2021-08-31 09:20:11', '2021-08-31 09:20:11', NULL);
INSERT INTO `coupon_codes` VALUES (7, 'molestias ut sunt', 'CFU7Y3KYYGBKYKY', 'percent', 45.00, 1000, 0, 0.00, NULL, NULL, 1, '2021-08-31 09:20:12', '2021-08-31 09:20:12', NULL);
INSERT INTO `coupon_codes` VALUES (8, 'recusandae dolores excepturi', 'D5QZ51ANWA9PBJC', 'fixed', 61.00, 1000, 0, 61.01, NULL, NULL, 1, '2021-08-31 09:20:12', '2021-08-31 09:20:12', NULL);
INSERT INTO `coupon_codes` VALUES (9, 'et porro et', '0TA8RJKWL81KDEM', 'fixed', 85.00, 1000, 0, 85.01, NULL, NULL, 1, '2021-08-31 09:20:12', '2021-08-31 09:20:12', NULL);
INSERT INTO `coupon_codes` VALUES (10, 'autem modi reprehenderit', 'HTTSFKSIIUB4GUJ', 'fixed', 144.00, 1000, 0, 144.01, NULL, NULL, 1, '2021-08-31 09:20:12', '2021-08-31 09:20:12', NULL);
INSERT INTO `coupon_codes` VALUES (11, '半价优惠', 'CFU7Y3KYYGBKYKF', 'percent', 50.00, 10, 0, 100.00, '2021-09-02 09:00:00', '2021-09-06 09:00:00', 1, '2021-08-31 09:48:11', '2021-08-31 09:54:52', NULL);
COMMIT;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------
BEGIN;
INSERT INTO `failed_jobs` VALUES (1, 'redis', 'default', '{\"displayName\":\"App\\\\Jobs\\\\CloseOrderJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"delay\":null,\"timeout\":null,\"timeoutAt\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\CloseOrderJob\",\"command\":\"O:22:\\\"App\\\\Jobs\\\\CloseOrderJob\\\":9:{s:8:\\\"\\u0000*\\u0000order\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Order\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:1:{i:0;s:4:\\\"user\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"\\u0000*\\u0000job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";i:30;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"},\"id\":\"aGXhr44FKSTDIUdQILFTAcHsvqAf2Grg\",\"attempts\":0}', 'BadMethodCallException: Call to undefined method Illuminate\\Database\\Eloquent\\Relations\\BelongsTo::addStock() in /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Support/Traits/ForwardsCalls.php:50\nStack trace:\n#0 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Support/Traits/ForwardsCalls.php(36): Illuminate\\Database\\Eloquent\\Relations\\Relation::throwBadMethodCallException(\'addStock\')\n#1 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Relations/Relation.php(385): Illuminate\\Database\\Eloquent\\Relations\\Relation->forwardCallTo(Object(Illuminate\\Database\\Eloquent\\Builder), \'addStock\', Array)\n#2 /Users/xiaoxiao/dev/codes/php/shop/app/Jobs/CloseOrderJob.php(52): Illuminate\\Database\\Eloquent\\Relations\\Relation->__call(\'addStock\', Array)\n#3 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Database/Concerns/ManagesTransactions.php(29): App\\Jobs\\CloseOrderJob->App\\Jobs\\{closure}(Object(Illuminate\\Database\\MySqlConnection))\n#4 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Database/DatabaseManager.php(349): Illuminate\\Database\\Connection->transaction(Object(Closure))\n#5 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Support/Facades/Facade.php(261): Illuminate\\Database\\DatabaseManager->__call(\'transaction\', Array)\n#6 /Users/xiaoxiao/dev/codes/php/shop/app/Jobs/CloseOrderJob.php(54): Illuminate\\Support\\Facades\\Facade::__callStatic(\'transaction\', Array)\n#7 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): App\\Jobs\\CloseOrderJob->handle()\n#8 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Container.php(590): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(94): Illuminate\\Container\\Container->call(Array)\n#13 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(130): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\CloseOrderJob))\n#14 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(105): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\CloseOrderJob))\n#15 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(98): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(83): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\CloseOrderJob), false)\n#17 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(130): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\CloseOrderJob))\n#18 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(105): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\CloseOrderJob))\n#19 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(85): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(59): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(App\\Jobs\\CloseOrderJob))\n#21 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(88): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\RedisJob), Array)\n#22 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(368): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(314): Illuminate\\Queue\\Worker->process(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(134): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\RedisJob), \'redis\', Object(Illuminate\\Queue\\WorkerOptions))\n#25 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(112): Illuminate\\Queue\\Worker->daemon(\'redis\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#26 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(96): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'redis\', \'default\')\n#27 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Container.php(590): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(134): Illuminate\\Container\\Container->call(Array)\n#33 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Command/Command.php(255): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(1009): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(273): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(149): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Application.php(93): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(131): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 /Users/xiaoxiao/dev/codes/php/shop/artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#41 {main}', '2021-08-28 15:19:39');
INSERT INTO `failed_jobs` VALUES (2, 'redis', 'default', '{\"timeout\":null,\"id\":\"GmVQf1ylwD2NtS1C9osv49L7qjXwhuFy\",\"data\":{\"command\":\"O:22:\\\"App\\\\Jobs\\\\CloseOrderJob\\\":9:{s:8:\\\"\\u0000*\\u0000order\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Order\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:1:{i:0;s:4:\\\"user\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"\\u0000*\\u0000job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";i:30;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\",\"commandName\":\"App\\\\Jobs\\\\CloseOrderJob\"},\"displayName\":\"App\\\\Jobs\\\\CloseOrderJob\",\"timeoutAt\":null,\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"delay\":null,\"attempts\":1}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\CloseOrderJob has been attempted too many times or run too long. The job may have previously timed out. in /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php:632\nStack trace:\n#0 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(446): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\RedisJob))\n#1 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(358): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), 1)\n#2 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(314): Illuminate\\Queue\\Worker->process(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Queue\\WorkerOptions))\n#3 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(134): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\RedisJob), \'redis\', Object(Illuminate\\Queue\\WorkerOptions))\n#4 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(112): Illuminate\\Queue\\Worker->daemon(\'redis\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(96): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'redis\', \'default\')\n#6 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#7 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#8 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#9 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#10 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Container.php(590): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#11 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(134): Illuminate\\Container\\Container->call(Array)\n#12 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Command/Command.php(255): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#13 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(1009): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#15 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(273): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(149): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Application.php(93): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(131): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 /Users/xiaoxiao/dev/codes/php/shop/artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 {main}', '2021-08-28 15:27:59');
INSERT INTO `failed_jobs` VALUES (3, 'redis', 'default', '{\"timeout\":null,\"id\":\"jnpYTuaSnI5trT9p0vQNjotEXwhNgRvg\",\"data\":{\"command\":\"O:22:\\\"App\\\\Jobs\\\\CloseOrderJob\\\":9:{s:8:\\\"\\u0000*\\u0000order\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Order\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:1:{i:0;s:4:\\\"user\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"\\u0000*\\u0000job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";i:30;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\",\"commandName\":\"App\\\\Jobs\\\\CloseOrderJob\"},\"displayName\":\"App\\\\Jobs\\\\CloseOrderJob\",\"timeoutAt\":null,\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"delay\":null,\"attempts\":1}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Jobs\\CloseOrderJob has been attempted too many times or run too long. The job may have previously timed out. in /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php:632\nStack trace:\n#0 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(446): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\RedisJob))\n#1 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(358): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), 1)\n#2 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(314): Illuminate\\Queue\\Worker->process(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Queue\\WorkerOptions))\n#3 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(134): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\RedisJob), \'redis\', Object(Illuminate\\Queue\\WorkerOptions))\n#4 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(112): Illuminate\\Queue\\Worker->daemon(\'redis\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(96): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'redis\', \'default\')\n#6 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#7 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#8 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#9 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#10 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Container.php(590): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#11 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(134): Illuminate\\Container\\Container->call(Array)\n#12 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Command/Command.php(255): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#13 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(1009): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#15 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(273): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(149): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Application.php(93): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(131): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 /Users/xiaoxiao/dev/codes/php/shop/artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 {main}', '2021-08-28 15:27:59');
INSERT INTO `failed_jobs` VALUES (4, 'redis', 'default', '{\"displayName\":\"App\\\\Jobs\\\\CloseOrderJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"delay\":null,\"timeout\":null,\"timeoutAt\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\CloseOrderJob\",\"command\":\"O:22:\\\"App\\\\Jobs\\\\CloseOrderJob\\\":9:{s:8:\\\"\\u0000*\\u0000order\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Order\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:1:{i:0;s:4:\\\"user\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:6:\\\"\\u0000*\\u0000job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";i:30;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"},\"id\":\"hgFTyWQTQ3lxFP1ZsHIsxxP1TYpLDltW\",\"attempts\":0}', 'BadMethodCallException: Call to undefined method Illuminate\\Database\\Eloquent\\Relations\\BelongsTo::addStock() in /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Support/Traits/ForwardsCalls.php:50\nStack trace:\n#0 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Support/Traits/ForwardsCalls.php(36): Illuminate\\Database\\Eloquent\\Relations\\Relation::throwBadMethodCallException(\'addStock\')\n#1 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Relations/Relation.php(385): Illuminate\\Database\\Eloquent\\Relations\\Relation->forwardCallTo(Object(Illuminate\\Database\\Eloquent\\Builder), \'addStock\', Array)\n#2 /Users/xiaoxiao/dev/codes/php/shop/app/Jobs/CloseOrderJob.php(53): Illuminate\\Database\\Eloquent\\Relations\\Relation->__call(\'addStock\', Array)\n#3 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Database/Concerns/ManagesTransactions.php(29): App\\Jobs\\CloseOrderJob->App\\Jobs\\{closure}(Object(Illuminate\\Database\\MySqlConnection))\n#4 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Database/DatabaseManager.php(349): Illuminate\\Database\\Connection->transaction(Object(Closure))\n#5 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Support/Facades/Facade.php(261): Illuminate\\Database\\DatabaseManager->__call(\'transaction\', Array)\n#6 /Users/xiaoxiao/dev/codes/php/shop/app/Jobs/CloseOrderJob.php(55): Illuminate\\Support\\Facades\\Facade::__callStatic(\'transaction\', Array)\n#7 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): App\\Jobs\\CloseOrderJob->handle()\n#8 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Container.php(590): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(94): Illuminate\\Container\\Container->call(Array)\n#13 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(130): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\CloseOrderJob))\n#14 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(105): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\CloseOrderJob))\n#15 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(98): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(83): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\CloseOrderJob), false)\n#17 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(130): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\CloseOrderJob))\n#18 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(105): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\CloseOrderJob))\n#19 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(85): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(59): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(App\\Jobs\\CloseOrderJob))\n#21 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(88): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\RedisJob), Array)\n#22 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(368): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(314): Illuminate\\Queue\\Worker->process(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(134): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\RedisJob), \'redis\', Object(Illuminate\\Queue\\WorkerOptions))\n#25 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(112): Illuminate\\Queue\\Worker->daemon(\'redis\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#26 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(96): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'redis\', \'default\')\n#27 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Container.php(590): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(134): Illuminate\\Container\\Container->call(Array)\n#33 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Command/Command.php(255): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(1009): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(273): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(149): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Application.php(93): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(131): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 /Users/xiaoxiao/dev/codes/php/shop/artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#41 {main}', '2021-08-28 15:28:38');
INSERT INTO `failed_jobs` VALUES (5, 'redis', 'default', '{\"displayName\":\"App\\\\Notifications\\\\OrderPaid\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"delay\":null,\"timeout\":null,\"timeoutAt\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":13:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:12:\\\"notification\\\";O:27:\\\"App\\\\Notifications\\\\OrderPaid\\\":10:{s:8:\\\"\\u0000*\\u0000order\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Order\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:2:\\\"id\\\";s:36:\\\"520e5726-760c-4635-bb48-1a12d7935ed8\\\";s:6:\\\"locale\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:6:\\\"\\u0000*\\u0000job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"},\"id\":\"buHvhqIXGSUtiUMjef99R7jjlQ0uy2Ou\",\"attempts\":0}', 'BadMethodCallException: Method Illuminate\\Database\\Eloquent\\Collection::product does not exist. in /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Support/Traits/Macroable.php:103\nStack trace:\n#0 /Users/xiaoxiao/dev/codes/php/shop/app/Notifications/OrderPaid.php(48): Illuminate\\Support\\Collection->__call(\'product\', Array)\n#1 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/Channels/DatabaseChannel.php(41): App\\Notifications\\OrderPaid->toArray(Object(App\\Models\\User))\n#2 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/Channels/DatabaseChannel.php(59): Illuminate\\Notifications\\Channels\\DatabaseChannel->getData(Object(App\\Models\\User), Object(App\\Notifications\\OrderPaid))\n#3 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/Channels/DatabaseChannel.php(20): Illuminate\\Notifications\\Channels\\DatabaseChannel->buildPayload(Object(App\\Models\\User), Object(App\\Notifications\\OrderPaid))\n#4 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(148): Illuminate\\Notifications\\Channels\\DatabaseChannel->send(Object(App\\Models\\User), Object(App\\Notifications\\OrderPaid))\n#5 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(106): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(App\\Models\\User), \'bdd859ae-5eee-4...\', Object(App\\Notifications\\OrderPaid), \'database\')\n#6 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Support/Traits/Localizable.php(19): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()\n#7 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(109): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#8 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/ChannelManager.php(54): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(App\\Notifications\\OrderPaid), Array)\n#9 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/SendQueuedNotifications.php(74): Illuminate\\Notifications\\ChannelManager->sendNow(Object(App\\Models\\User), Object(App\\Notifications\\OrderPaid), Array)\n#10 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#11 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#12 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#13 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#14 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Container.php(590): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#15 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(94): Illuminate\\Container\\Container->call(Array)\n#16 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(130): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#17 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(105): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#18 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(98): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#19 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(83): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#20 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(130): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#21 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(105): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#22 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(85): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#23 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(59): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#24 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(88): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\RedisJob), Array)\n#25 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(368): Illuminate\\Queue\\Jobs\\Job->fire()\n#26 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(314): Illuminate\\Queue\\Worker->process(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Queue\\WorkerOptions))\n#27 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(134): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\RedisJob), \'redis\', Object(Illuminate\\Queue\\WorkerOptions))\n#28 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(112): Illuminate\\Queue\\Worker->daemon(\'redis\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#29 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(96): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'redis\', \'default\')\n#30 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#31 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#32 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#33 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#34 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Container.php(590): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#35 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(134): Illuminate\\Container\\Container->call(Array)\n#36 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Command/Command.php(255): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#37 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#38 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(1009): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(273): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(149): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#41 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Application.php(93): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#42 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(131): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#43 /Users/xiaoxiao/dev/codes/php/shop/artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#44 {main}', '2021-08-30 10:47:02');
INSERT INTO `failed_jobs` VALUES (6, 'redis', 'default', '{\"displayName\":\"App\\\\Notifications\\\\OrderPaid\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"delay\":null,\"timeout\":null,\"timeoutAt\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":13:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:12:\\\"notification\\\";O:27:\\\"App\\\\Notifications\\\\OrderPaid\\\":10:{s:8:\\\"\\u0000*\\u0000order\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Order\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:2:\\\"id\\\";s:36:\\\"981a567a-d50b-4f1f-aba5-be96a4c1a36b\\\";s:6:\\\"locale\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:6:\\\"\\u0000*\\u0000job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"},\"id\":\"40D7IxB5MEuMa4cbhkr5MGLS5pAa4344\",\"attempts\":0}', 'BadMethodCallException: Method Illuminate\\Database\\Eloquent\\Collection::product does not exist. in /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Support/Traits/Macroable.php:103\nStack trace:\n#0 /Users/xiaoxiao/dev/codes/php/shop/app/Notifications/OrderPaid.php(48): Illuminate\\Support\\Collection->__call(\'product\', Array)\n#1 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/Channels/DatabaseChannel.php(41): App\\Notifications\\OrderPaid->toArray(Object(App\\Models\\User))\n#2 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/Channels/DatabaseChannel.php(59): Illuminate\\Notifications\\Channels\\DatabaseChannel->getData(Object(App\\Models\\User), Object(App\\Notifications\\OrderPaid))\n#3 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/Channels/DatabaseChannel.php(20): Illuminate\\Notifications\\Channels\\DatabaseChannel->buildPayload(Object(App\\Models\\User), Object(App\\Notifications\\OrderPaid))\n#4 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(148): Illuminate\\Notifications\\Channels\\DatabaseChannel->send(Object(App\\Models\\User), Object(App\\Notifications\\OrderPaid))\n#5 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(106): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(App\\Models\\User), \'1354f345-9b73-4...\', Object(App\\Notifications\\OrderPaid), \'database\')\n#6 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Support/Traits/Localizable.php(19): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()\n#7 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(109): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#8 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/ChannelManager.php(54): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(App\\Notifications\\OrderPaid), Array)\n#9 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Notifications/SendQueuedNotifications.php(74): Illuminate\\Notifications\\ChannelManager->sendNow(Object(App\\Models\\User), Object(App\\Notifications\\OrderPaid), Array)\n#10 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#11 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#12 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#13 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#14 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Container.php(590): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#15 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(94): Illuminate\\Container\\Container->call(Array)\n#16 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(130): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#17 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(105): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#18 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(98): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#19 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(83): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#20 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(130): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#21 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(105): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#22 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(85): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#23 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(59): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#24 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(88): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\RedisJob), Array)\n#25 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(368): Illuminate\\Queue\\Jobs\\Job->fire()\n#26 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(314): Illuminate\\Queue\\Worker->process(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Queue\\WorkerOptions))\n#27 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(134): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\RedisJob), \'redis\', Object(Illuminate\\Queue\\WorkerOptions))\n#28 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(112): Illuminate\\Queue\\Worker->daemon(\'redis\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#29 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(96): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'redis\', \'default\')\n#30 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#31 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#32 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#33 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#34 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Container.php(590): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#35 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(134): Illuminate\\Container\\Container->call(Array)\n#36 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Command/Command.php(255): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#37 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#38 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(1009): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(273): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(149): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#41 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Application.php(93): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#42 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(131): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#43 /Users/xiaoxiao/dev/codes/php/shop/artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#44 {main}', '2021-08-30 10:47:02');
INSERT INTO `failed_jobs` VALUES (7, 'redis', 'default', '{\"timeout\":null,\"id\":\"6nLaTxnWAyrDCckKCN1JQzm2vCZTLFcP\",\"data\":{\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":13:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:12:\\\"notification\\\";O:27:\\\"App\\\\Notifications\\\\OrderPaid\\\":10:{s:8:\\\"\\u0000*\\u0000order\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Order\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:2:\\\"id\\\";s:36:\\\"113fc058-a0dd-4d04-a11a-61cc3df28802\\\";s:6:\\\"locale\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}s:8:\\\"channels\\\";a:1:{i:0;s:8:\\\"database\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:6:\\\"\\u0000*\\u0000job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\",\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\"},\"displayName\":\"App\\\\Notifications\\\\OrderPaid\",\"timeoutAt\":null,\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"delay\":null,\"attempts\":1}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Notifications\\OrderPaid has been attempted too many times or run too long. The job may have previously timed out. in /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php:632\nStack trace:\n#0 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(446): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\RedisJob))\n#1 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(358): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), 1)\n#2 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(314): Illuminate\\Queue\\Worker->process(\'redis\', Object(Illuminate\\Queue\\Jobs\\RedisJob), Object(Illuminate\\Queue\\WorkerOptions))\n#3 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(134): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\RedisJob), \'redis\', Object(Illuminate\\Queue\\WorkerOptions))\n#4 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(112): Illuminate\\Queue\\Worker->daemon(\'redis\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(96): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'redis\', \'default\')\n#6 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#7 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#8 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#9 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#10 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Container/Container.php(590): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#11 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(134): Illuminate\\Container\\Container->call(Array)\n#12 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Command/Command.php(255): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#13 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(1009): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#15 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(273): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 /Users/xiaoxiao/dev/codes/php/shop/vendor/symfony/console/Application.php(149): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Console/Application.php(93): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 /Users/xiaoxiao/dev/codes/php/shop/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(131): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 /Users/xiaoxiao/dev/codes/php/shop/artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 {main}', '2021-08-30 10:47:02');
COMMIT;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
BEGIN;
INSERT INTO `migrations` VALUES (35, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (36, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (37, '2016_01_04_173148_create_admin_tables', 1);
INSERT INTO `migrations` VALUES (38, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (39, '2020_09_07_090635_create_admin_settings_table', 1);
INSERT INTO `migrations` VALUES (40, '2020_09_22_015815_create_admin_extensions_table', 1);
INSERT INTO `migrations` VALUES (41, '2020_11_01_083237_update_admin_menu_table', 1);
INSERT INTO `migrations` VALUES (42, '2021_08_23_110302_add_user_id_to_users_table', 1);
INSERT INTO `migrations` VALUES (43, '2021_08_23_111416_create_user_addresses_table', 1);
INSERT INTO `migrations` VALUES (44, '2021_08_25_095702_create_products_table', 1);
INSERT INTO `migrations` VALUES (45, '2021_08_25_095723_create_product_skus_table', 1);
INSERT INTO `migrations` VALUES (47, '2021_08_26_155422_create_user_favorite_products_table', 2);
INSERT INTO `migrations` VALUES (48, '2021_08_27_141728_create_cart_items_table', 3);
INSERT INTO `migrations` VALUES (49, '2021_08_27_161554_create_orders_table', 4);
INSERT INTO `migrations` VALUES (50, '2021_08_27_161611_create_order_items_table', 4);
INSERT INTO `migrations` VALUES (51, '2021_08_30_095156_add_notification_count_to_user_table', 5);
INSERT INTO `migrations` VALUES (52, '2021_08_30_103153_create_notifications_table', 6);
INSERT INTO `migrations` VALUES (53, '2021_08_31_084302_create_coupon_codes_table', 7);
INSERT INTO `migrations` VALUES (54, '2021_08_31_085139_orders_add_coupon_code_id', 7);
COMMIT;

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of notifications
-- ----------------------------
BEGIN;
INSERT INTO `notifications` VALUES ('b2b20813-0d50-4a76-8a5b-230a33b3e5e2', 'App\\Notifications\\OrderPaid', 'App\\Models\\User', 1, '{\"message\":\"\\u60a8\\u597d\\uff0c\\u60a8\\u4e8e08-28 15:32\\u521b\\u5efa\\u7684\\u8ba2\\u5355\\u5df2\\u7ecf\\u652f\\u4ed8\\u6210\\u529f\\u4e86\\u3002\\u70b9\\u51fb\\u6b64\\u5904\\u67e5\\u770b\\u8ba2\\u5355\\u8be6\\u60c5\",\"link\":\"http:\\/\\/local.shop.cn\\/api\\/v1\\/orders\\/1\"}', '2021-08-30 12:21:19', '2021-08-30 11:52:03', '2021-08-30 12:21:19');
INSERT INTO `notifications` VALUES ('cecf4c19-d078-4de7-beac-2495a57a9718', 'App\\Notifications\\OrderPaid', 'App\\Models\\User', 1, '{\"message\":\"\\u60a8\\u597d\\uff0c\\u60a8\\u4e8e08-28 15:32\\u521b\\u5efa\\u7684\\u8ba2\\u5355\\u5df2\\u7ecf\\u652f\\u4ed8\\u6210\\u529f\\u4e86\\u3002\\u70b9\\u51fb\\u6b64\\u5904\\u67e5\\u770b\\u8ba2\\u5355\\u8be6\\u60c5\",\"link\":\"http:\\/\\/local.shop.cn\\/api\\/v1\\/orders\\/1\"}', '2021-08-30 11:28:34', '2021-08-30 11:12:48', '2021-08-30 11:28:34');
INSERT INTO `notifications` VALUES ('d594c0e9-ab73-41a7-a83f-c104512251ab', 'App\\Notifications\\OrderPaid', 'App\\Models\\User', 1, '{\"message\":\"\\u60a8\\u597d\\uff0c\\u60a8\\u4e8e08-28 15:32\\u521b\\u5efa\\u7684\\u8ba2\\u5355\\u5df2\\u7ecf\\u652f\\u4ed8\\u6210\\u529f\\u4e86\\u3002\\u70b9\\u51fb\\u6b64\\u5904\\u67e5\\u770b\\u8ba2\\u5355\\u8be6\\u60c5\",\"link\":\"http:\\/\\/local.shop.cn\\/api\\/v1\\/orders\\/1\"}', '2021-08-30 11:28:34', '2021-08-30 11:02:42', '2021-08-30 11:28:34');
COMMIT;

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL COMMENT '订单流水号',
  `product_id` bigint(20) unsigned NOT NULL COMMENT '对应商品ID',
  `product_sku_id` bigint(20) unsigned NOT NULL COMMENT '对应商品SKU ID',
  `amount` int(10) unsigned NOT NULL COMMENT '数量',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `rating` int(10) unsigned DEFAULT NULL COMMENT '用户打分',
  `review` text COLLATE utf8mb4_unicode_ci COMMENT '用户评价',
  `reviewed_at` timestamp NULL DEFAULT NULL COMMENT '评价时间',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_product_id_foreign` (`product_id`),
  KEY `order_items_product_sku_id_foreign` (`product_sku_id`),
  CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_product_sku_id_foreign` FOREIGN KEY (`product_sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of order_items
-- ----------------------------
BEGIN;
INSERT INTO `order_items` VALUES (1, 2648982898132123648, 2, 4, 3, 5262.00, 5, '商品质量非常好', '2021-08-30 16:25:47', '2021-08-28 15:32:18', '2021-08-30 16:25:47', NULL);
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` bigint(20) NOT NULL COMMENT '订单流水号',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '下单的用户ID',
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'JSON格式的收货地址',
  `total_amount` decimal(8,2) NOT NULL COMMENT '订单总金额',
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT '订单备注',
  `paid_at` datetime DEFAULT NULL COMMENT '支付时间',
  `coupon_code_id` bigint(20) unsigned DEFAULT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付方式',
  `payment_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付平台订单号',
  `refund_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending' COMMENT '退款状态',
  `refund_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '退款单号',
  `closed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单是否已关闭',
  `reviewed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单是否已评价',
  `ship_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending' COMMENT '物流状态',
  `ship_data` text COLLATE utf8mb4_unicode_ci COMMENT '物流数据',
  `extra` text COLLATE utf8mb4_unicode_ci COMMENT '其他额外的数据',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_order_no_unique` (`order_no`),
  KEY `orders_coupon_code_id_foreign` (`coupon_code_id`),
  CONSTRAINT `orders_coupon_code_id_foreign` FOREIGN KEY (`coupon_code_id`) REFERENCES `coupon_codes` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` VALUES (1, 2648982898132123648, 2648187705527107584, '{\"address\":\"\\u6cb3\\u5317\\u7701\\u77f3\\u5bb6\\u5e84\\u5e02\\u957f\\u5b89\\u533a\\u7b2c6\\u8857\\u9053677\\u53f7\",\"zip\":778400,\"contact_name\":\"\\u8ba1\\u6587\\u5a1f\",\"contact_phone\":\"18417043558\"}', 15786.00, '当前的订单备注', '2021-08-27 15:32:18', NULL, 'alipay', '2018060421001004060200312091', 'pending', NULL, 0, 1, 'received', '{\"express_company\":\"\\u5706\\u901a\\u901f\\u9012\",\"express_no\":\"YT5625520277743\"}', '{\"refund_reason\":\"\\u6d4b\\u8bd5\\u9000\\u6b3e\",\"refund_disagree_reason\":\"\\u4e70\\u5bb6\\u8bef\\u64cd\\u4f5c\"}', '2021-08-28 15:32:18', '2021-08-30 21:12:55', NULL);
COMMIT;

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of password_resets
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for product_skus
-- ----------------------------
DROP TABLE IF EXISTS `product_skus`;
CREATE TABLE `product_skus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'SKU名称',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'SKU描述',
  `price` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'SKU价格',
  `stock` int(10) unsigned NOT NULL COMMENT '库存',
  `product_id` bigint(20) unsigned NOT NULL COMMENT '商品id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_skus_product_id_foreign` (`product_id`),
  CONSTRAINT `product_skus_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of product_skus
-- ----------------------------
BEGIN;
INSERT INTO `product_skus` VALUES (1, '白色64G', 'iphon12 白色64G', '6099.00', 100, 1, '2021-08-26 11:03:52', '2021-08-26 11:03:52', NULL);
INSERT INTO `product_skus` VALUES (2, '绿色128G', 'iphon12 绿色128G', '6599.00', 50, 1, '2021-08-26 11:03:52', '2021-08-26 11:03:52', NULL);
INSERT INTO `product_skus` VALUES (3, '蓝色256G', 'iphon12 蓝色256G', '7399.00', 10, 1, '2021-08-26 11:03:52', '2021-08-26 11:03:52', NULL);
INSERT INTO `product_skus` VALUES (4, 'laborum', 'Dignissimos tempore dolorem quidem hic quidem ipsam dolores.', '5262', 5623, 2, '2021-08-26 12:38:40', '2021-08-28 15:32:50', NULL);
INSERT INTO `product_skus` VALUES (5, 'ipsa', 'Dolorum adipisci natus enim.', '3157', 6776, 2, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (6, 'delectus', 'Velit et exercitationem quam est.', '9443', 96544, 2, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (7, 'provident', 'Sed vero autem qui.', '4932', 45474, 3, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (8, 'autem', 'Rerum necessitatibus numquam ex ut occaecati nihil nisi.', '675', 3081, 3, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (9, 'accusantium', 'Sint id qui iure odit non.', '505', 67907, 3, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (10, 'consequatur', 'Sequi illo unde et.', '4767', 93737, 4, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (11, 'optio', 'Autem beatae eos perspiciatis qui ad eaque et fugit.', '9059', 67927, 4, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (12, 'qui', 'Asperiores doloremque necessitatibus ullam delectus aut iste tempora.', '902', 62810, 4, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (13, 'ea', 'Quia et et eum tempora nesciunt velit.', '5976', 38563, 5, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (14, 'beatae', 'Quia aut delectus voluptas modi autem.', '1529', 37150, 5, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (15, 'cupiditate', 'Sint ut magnam numquam ratione molestiae aspernatur voluptates sit.', '5426', 80268, 5, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (16, 'et', 'Dicta numquam in natus labore nisi totam.', '1091', 80138, 6, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (17, 'accusantium', 'Magni a veritatis mollitia.', '6387', 17854, 6, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (18, 'optio', 'Et aliquid soluta sed hic rem quos.', '6926', 96503, 6, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (19, 'ipsam', 'Non velit est adipisci aut.', '8475', 13121, 7, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (20, 'corporis', 'A nihil et voluptatibus nemo ipsam.', '8913', 58672, 7, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (21, 'saepe', 'Tenetur ullam aliquid maiores blanditiis molestiae.', '3414', 27739, 7, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (22, 'natus', 'Est magni omnis possimus sapiente quia.', '8805', 70281, 8, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (23, 'est', 'Nulla voluptatum consequatur ullam.', '8145', 23347, 8, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (24, 'quia', 'Et harum voluptatem sed atque atque ipsum laboriosam.', '5481', 2778, 8, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (25, 'aut', 'Cumque dignissimos et officiis fugiat sit dicta ut.', '42', 24739, 9, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (26, 'veniam', 'Deserunt cumque quae eum.', '872', 8794, 9, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (27, 'impedit', 'Nam numquam est consequatur omnis placeat quis quisquam.', '3165', 98952, 9, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (28, 'mollitia', 'Quia alias molestiae ad qui dolorem est neque doloremque.', '4383', 2537, 10, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (29, 'laudantium', 'Voluptas velit praesentium dolores iure animi.', '9618', 11858, 10, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (30, 'quo', 'Qui quaerat est consequatur qui.', '7252', 14019, 10, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (31, 'tempora', 'Quo ut nihil ut repellat est sed ipsum.', '662', 32771, 11, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (32, 'vel', 'Id ex veniam et quo voluptate.', '4273', 93980, 11, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (33, 'provident', 'Sequi officiis ullam rerum fugit sunt voluptatum.', '154', 56534, 11, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (34, 'rerum', 'Neque aperiam nostrum qui quis corporis.', '4029', 79710, 12, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (35, 'vero', 'Molestiae illo maxime perferendis eveniet.', '9744', 59714, 12, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (36, 'alias', 'Voluptatibus laudantium repellendus vel consequatur magnam exercitationem non.', '9434', 86641, 12, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (37, 'minima', 'Modi quia assumenda non maiores.', '5076', 93674, 13, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (38, 'minima', 'Dicta ut libero ducimus sit error consectetur consectetur qui.', '4310', 75516, 13, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (39, 'adipisci', 'Autem et neque explicabo soluta voluptatem harum.', '4652', 64644, 13, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (40, 'unde', 'Corrupti quia error culpa culpa vel incidunt voluptates amet.', '3168', 89040, 14, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (41, 'nam', 'Maiores doloribus architecto rerum perspiciatis exercitationem natus quas non.', '9730', 49332, 14, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (42, 'asperiores', 'Perferendis voluptas quaerat qui itaque.', '6400', 47517, 14, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (43, 'praesentium', 'Harum aut voluptatem et libero tempore dolorem accusantium.', '1350', 93970, 15, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (44, 'vel', 'Aut fugiat inventore corrupti consequatur laboriosam dignissimos voluptatum.', '330', 79435, 15, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (45, 'sed', 'Blanditiis praesentium fuga mollitia quisquam magni ea iusto.', '6532', 884, 15, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (46, 'earum', 'Delectus placeat quasi consequuntur consequatur id recusandae fugiat tempora.', '5634', 70438, 16, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (47, 'nam', 'Recusandae quia nihil voluptatibus eos.', '1598', 78079, 16, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (48, 'quis', 'In cum illum et ut blanditiis libero.', '6515', 3198, 16, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (49, 'est', 'Doloremque autem reprehenderit quia sint.', '6811', 38960, 17, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (50, 'ut', 'Debitis cupiditate eos ut saepe dignissimos et totam.', '689', 32663, 17, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (51, 'fugiat', 'Libero culpa voluptatibus ea quibusdam doloremque itaque minus.', '8880', 41775, 17, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (52, 'totam', 'Eum nisi repellendus labore odio nostrum omnis.', '839', 69137, 18, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (53, 'culpa', 'Voluptatum at a ab voluptatibus odio at.', '3036', 71075, 18, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (54, 'quis', 'Enim dicta aspernatur illum numquam neque.', '9764', 64991, 18, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (55, 'qui', 'Repellat consequatur autem sequi ipsa.', '2805', 33694, 19, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (56, 'reprehenderit', 'Asperiores omnis corporis blanditiis sed quibusdam.', '8791', 46385, 19, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (57, 'sint', 'Veniam facilis aut amet voluptas deleniti occaecati voluptatum.', '4169', 35298, 19, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (58, 'eligendi', 'Ducimus est qui sapiente.', '9654', 97664, 20, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (59, 'quia', 'Nisi molestiae eum et quam facere.', '4835', 13669, 20, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (60, 'rem', 'Minus debitis hic eos ut consequatur.', '2495', 28650, 20, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (61, 'aut', 'Sit et quibusdam accusamus.', '7197', 12022, 21, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (62, 'harum', 'Soluta nisi nulla dolorem sit minus amet.', '1741', 55763, 21, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (63, 'ipsam', 'A natus qui assumenda voluptate.', '3934', 10988, 21, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (64, 'necessitatibus', 'Sit similique sint aut perferendis rem.', '7034', 34686, 22, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (65, 'ea', 'Facere sed animi ipsum officia ex vel ut recusandae.', '4378', 80315, 22, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (66, 'nam', 'Deserunt id tempora vitae fuga expedita velit sint a.', '4210', 79043, 22, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (67, 'animi', 'Ut quis fugiat voluptatem amet ut aut.', '1924', 20321, 23, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (68, 'voluptates', 'Sit vel ullam blanditiis ad vitae.', '8972', 72659, 23, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (69, 'et', 'Iste illum enim porro illo quasi earum.', '1865', 43758, 23, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (70, 'placeat', 'Molestias non reiciendis doloribus occaecati rerum.', '7478', 84520, 24, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (71, 'ut', 'Cupiditate unde ut molestiae eveniet voluptatum dignissimos et.', '1217', 36155, 24, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (72, 'modi', 'Itaque laborum occaecati in nostrum neque voluptas modi.', '1155', 61422, 24, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (73, 'quia', 'Doloribus inventore cum voluptatibus et sapiente.', '4234', 37239, 25, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (74, 'temporibus', 'Quas eveniet vel et minima est aut.', '7757', 62719, 25, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (75, 'ullam', 'Est ut qui nostrum perspiciatis doloribus est.', '2479', 1119, 25, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (76, 'beatae', 'Aut quia consectetur at non delectus.', '5848', 3322, 26, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (77, 'et', 'Qui quam nisi inventore ut.', '3442', 29333, 26, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (78, 'non', 'Ab animi et optio placeat ut voluptatum.', '7350', 19758, 26, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (79, 'tenetur', 'Harum odio eum officia aut.', '2136', 30457, 27, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (80, 'ea', 'Vel quo ut debitis eum doloremque.', '1358', 64289, 27, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (81, 'totam', 'Explicabo quas itaque rem blanditiis voluptate earum.', '6091', 81994, 27, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (82, 'perspiciatis', 'Modi ab ut et necessitatibus ipsa explicabo.', '1907', 53068, 28, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (83, 'voluptatibus', 'Perferendis omnis dolores molestiae praesentium cupiditate voluptas in iste.', '8208', 67153, 28, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (84, 'voluptatem', 'Excepturi esse expedita facilis voluptates facilis aliquam.', '8126', 87696, 28, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (85, 'error', 'Aperiam in consectetur rem nostrum.', '6831', 80110, 29, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (86, 'itaque', 'Est vel molestias voluptas molestias et non id.', '7355', 17039, 29, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (87, 'itaque', 'Iure quia nobis est sed ut.', '787', 88713, 29, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (88, 'libero', 'In veniam quos sint.', '228', 96557, 30, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (89, 'quod', 'Suscipit in consectetur quaerat odit laudantium itaque itaque.', '1217', 52444, 30, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (90, 'porro', 'Dicta omnis minus voluptas et dolor.', '5612', 71432, 30, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (91, 'quaerat', 'Nihil dignissimos ut voluptatibus dicta.', '7381', 21675, 31, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (92, 'quam', 'Expedita quasi perferendis quos ea voluptatum.', '4379', 40903, 31, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `product_skus` VALUES (93, 'doloremque', 'Iure asperiores molestiae beatae eum natus nihil fugit.', '4206', 55958, 31, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
COMMIT;

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名称',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品详情',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品封面图',
  `on_sale` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否在售卖 0 未售 1 在售',
  `rating` double(8,2) NOT NULL DEFAULT '5.00' COMMENT '商品平均评分',
  `sold_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '销量',
  `review_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数量',
  `price` decimal(10,2) NOT NULL COMMENT 'SKU最低价格',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of products
-- ----------------------------
BEGIN;
INSERT INTO `products` VALUES (1, 'Apple iPhone 12 (A2404) 128GB 白色 支持移动联通电信5G 双卡双待手机', '<p>Apple iPhone 12 (A2404) 128GB 白色 支持移动联通电信5G 双卡双待手机,全网首发，快快来购买哈。</p>', 'http://local.shop.cn/storage/admin/images/89172627eda3cf2bf1b73f8cab654a6e.png', 0, 5.00, 0, 0, 6099.00, '2021-08-26 11:03:52', '2021-08-26 12:44:17', NULL);
INSERT INTO `products` VALUES (2, 'praesentium', 'Quis labore aut autem.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 5.00, 0, 1, 3157.00, '2021-08-26 12:38:40', '2021-08-30 16:25:48', NULL);
INSERT INTO `products` VALUES (3, 'magnam', 'Quo fugiat et sequi et repellat tempore.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 2.00, 0, 0, 505.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (4, 'fuga', 'Autem neque asperiores laudantium labore.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 5.00, 0, 0, 902.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (5, 'sunt', 'Dignissimos laborum minus libero excepturi dolorum rerum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 5.00, 0, 0, 1529.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (6, 'beatae', 'Voluptatibus nam vero et itaque commodi.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 0.00, 0, 0, 1091.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (7, 'rerum', 'Occaecati doloribus odio quas nulla assumenda veniam.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 3.00, 0, 0, 3414.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (8, 'sint', 'Voluptate itaque eligendi assumenda velit.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 5.00, 0, 0, 5481.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (9, 'ipsa', 'Ut voluptas itaque cumque nostrum alias consequatur et sit.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 3.00, 0, 0, 42.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (10, 'accusantium', 'Voluptatem maiores voluptatem omnis delectus aut ut aut.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 5.00, 0, 0, 4383.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (11, 'quo', 'Quas quo molestiae ut nihil a est quas.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 2.00, 0, 0, 154.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (12, 'aut', 'Ut et possimus aut quia ea est ratione.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 1.00, 0, 0, 4029.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (13, 'repellat', 'Rerum aut aut ducimus molestiae.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 1.00, 0, 0, 4310.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (14, 'tenetur', 'Tempora sunt asperiores iure assumenda voluptatibus consequatur voluptate enim.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 1.00, 0, 0, 3168.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (15, 'earum', 'Natus est quibusdam cupiditate veniam ea voluptas laudantium.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 3.00, 0, 0, 330.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (16, 'aspernatur', 'Et molestiae cum sunt magni dicta consequatur.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 1.00, 0, 0, 1598.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (17, 'non', 'Rerum aut veritatis ipsam enim est inventore et qui.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 5.00, 0, 0, 689.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (18, 'similique', 'Aut deleniti nam ipsa recusandae.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 2.00, 0, 0, 839.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (19, 'neque', 'Unde quas aut tenetur corporis ad eum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 3.00, 0, 0, 2805.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (20, 'voluptatem', 'Provident quia omnis et repellat quia qui aliquam.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 1.00, 0, 0, 2495.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (21, 'fuga', 'Et provident ipsam inventore non eveniet earum et.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 0.00, 0, 0, 1741.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (22, 'provident', 'Qui aspernatur praesentium fugit doloribus.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 2.00, 0, 0, 4210.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (23, 'reprehenderit', 'Est dolorem aut libero ipsum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 2.00, 0, 0, 1865.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (24, 'recusandae', 'Mollitia non et doloremque sed corporis consectetur recusandae.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 3.00, 0, 0, 1155.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (25, 'sint', 'Dolore est qui magni non repellendus.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 3.00, 0, 0, 2479.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (26, 'est', 'Doloremque quos vel vel et sed omnis.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 4.00, 0, 0, 3442.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (27, 'beatae', 'Aliquid sunt quae ea sint.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 2.00, 0, 0, 1358.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (28, 'eum', 'Quia et eum sit recusandae veniam necessitatibus et.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 5.00, 0, 0, 1907.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (29, 'quo', 'Facere et quam voluptas et est repellat et.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 2.00, 0, 0, 787.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (30, 'ipsam', 'Velit dignissimos deserunt rerum dolore.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 1.00, 0, 0, 228.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
INSERT INTO `products` VALUES (31, 'voluptas', 'Harum in distinctio eligendi id atque sit.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 1.00, 0, 0, 4206.00, '2021-08-26 12:38:40', '2021-08-26 12:38:40', NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_addresses
-- ----------------------------
DROP TABLE IF EXISTS `user_addresses`;
CREATE TABLE `user_addresses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户编号',
  `province` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '省',
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '市',
  `district` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '区',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '详细地址',
  `zip` int(10) unsigned NOT NULL COMMENT '邮编',
  `contact_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人姓名',
  `contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系人电话',
  `last_used_at` timestamp NULL DEFAULT NULL COMMENT '最后一次使用时间',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of user_addresses
-- ----------------------------
BEGIN;
INSERT INTO `user_addresses` VALUES (1, 2648187705556467712, '北京市', '市辖区', '东城区', '第16街道388号', 611000, '武桂英', '18993386343', NULL, '2021-08-26 10:52:29', '2021-08-26 10:52:29', NULL);
INSERT INTO `user_addresses` VALUES (2, 2648187705556467712, '北京市', '市辖区', '东城区', '第52街道619号', 417000, '苟龙', '14736023544', NULL, '2021-08-26 10:52:30', '2021-08-26 10:52:30', NULL);
INSERT INTO `user_addresses` VALUES (3, 2648187705560662016, '广东省', '深圳市', '福田区', '第89街道83号', 84100, '阎超', '15160523471', NULL, '2021-08-26 10:52:30', '2021-08-26 10:52:30', NULL);
INSERT INTO `user_addresses` VALUES (4, 2648187705560662016, '陕西省', '西安市', '雁塔区', '第24街道93号', 762200, '薄桂芬', '17057208202', NULL, '2021-08-26 10:52:30', '2021-08-26 10:52:30', NULL);
INSERT INTO `user_addresses` VALUES (5, 2648187705556467712, '陕西省', '宝鸡市', '渭滨区', '第18街道946号', 518200, '栗建华', '17103167257', NULL, '2021-08-26 10:52:30', '2021-08-26 10:52:30', NULL);
INSERT INTO `user_addresses` VALUES (6, 2648187705527107584, '河北省', '石家庄市', '长安区', '第6街道677号', 778400, '计文娟', '18417043558', '2021-08-28 15:32:18', '2021-08-26 10:52:30', '2021-08-28 15:32:18', NULL);
INSERT INTO `user_addresses` VALUES (7, 2648187705560662016, '北京市', '市辖区', '东城区', '第23街道247号', 845300, '党春梅', '15144306418', NULL, '2021-08-26 10:52:30', '2021-08-26 10:52:30', NULL);
INSERT INTO `user_addresses` VALUES (8, 2648187705527107584, '江苏省', '苏州市', '相城区', '第7街道179号', 547300, '翁晶', '18875641114', NULL, '2021-08-26 10:52:30', '2021-08-26 10:52:30', NULL);
INSERT INTO `user_addresses` VALUES (9, 2648187705556467712, '北京市', '市辖区', '丰台区', '第30街道243号', 615800, '练正豪', '17771456029', NULL, '2021-08-26 10:52:30', '2021-08-26 10:52:30', NULL);
INSERT INTO `user_addresses` VALUES (10, 2648187705527107584, '江苏省', '苏州市', '相城区', '第13街道523号', 492100, '崔秀云', '17012530541', NULL, '2021-08-26 10:52:30', '2021-08-26 10:52:30', NULL);
INSERT INTO `user_addresses` VALUES (11, 2648187705527107584, '上海市', '市辖区', '华龙区', '第2街道420号', 137300, '岑倩', '15039453001', NULL, '2021-08-26 10:57:16', '2021-08-26 10:57:39', '2021-08-26 10:57:39');
INSERT INTO `user_addresses` VALUES (12, 2648187705527107584, '北京市', '市辖区', '丰台区', '测试地址02', 100001, '张三2', '15556482257', NULL, '2021-08-27 11:13:58', '2021-08-27 11:13:58', NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_favorite_products
-- ----------------------------
DROP TABLE IF EXISTS `user_favorite_products`;
CREATE TABLE `user_favorite_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户编号',
  `product_id` bigint(20) unsigned NOT NULL COMMENT '商品id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_favorite_products_product_id_foreign` (`product_id`),
  CONSTRAINT `user_favorite_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of user_favorite_products
-- ----------------------------
BEGIN;
INSERT INTO `user_favorite_products` VALUES (2, 1, 3, '2021-08-26 17:03:43', '2021-08-26 17:03:43');
INSERT INTO `user_favorite_products` VALUES (3, 1, 2, '2021-08-27 09:40:34', '2021-08-27 09:40:34');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '用户ID,雪花ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `notification_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '未读数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_phone_unique` (`phone`),
  UNIQUE KEY `users_user_id_unique` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (1, 2648187705527107584, '柳岩', '17800721672', 'consequatur.tenetur@example.org', '2021-08-26 10:52:29', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'QGnDH0iw6D', '2007-06-06 17:50:19', '2021-08-30 12:21:19', NULL, 0);
INSERT INTO `users` VALUES (2, 2648187705556467712, '邸腊梅', '17198751988', 'quasi_debitis@example.com', '2021-08-26 10:52:29', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'SUvgTlMXVC', '1984-09-30 07:06:46', '1997-10-07 11:19:42', NULL, 0);
INSERT INTO `users` VALUES (3, 2648187705560662016, '覃祥', '13118871548', 'consectetur14@example.com', '2021-08-26 10:52:29', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'b3c3bOeyx9', '2001-06-13 13:25:27', '2006-04-08 21:22:47', NULL, 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
