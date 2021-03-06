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

 Date: 10/09/2021 15:05:46
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_menu
-- ----------------------------
BEGIN;
INSERT INTO `admin_menu` VALUES (1, 0, 1, 'Index', 'feather icon-bar-chart-2', '/', '', 1, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_menu` VALUES (2, 0, 2, 'Admin', 'feather icon-settings', '', '', 1, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_menu` VALUES (3, 2, 3, 'Users', '', 'auth/users', '', 1, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_menu` VALUES (4, 2, 4, 'Roles', '', 'auth/roles', '', 1, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_menu` VALUES (5, 2, 5, 'Permission', '', 'auth/permissions', '', 1, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_menu` VALUES (6, 2, 6, 'Menu', '', 'auth/menu', '', 1, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_menu` VALUES (7, 2, 7, 'Extensions', '', 'auth/extensions', '', 1, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_menu` VALUES (8, 0, 8, '????????????', 'fa-users', 'users', '', 1, '2021-09-02 11:30:39', '2021-09-02 11:30:39');
INSERT INTO `admin_menu` VALUES (9, 0, 9, '????????????', 'fa-cubes', 'products', '', 1, '2021-09-02 11:31:40', '2021-09-02 11:31:40');
INSERT INTO `admin_menu` VALUES (10, 0, 10, '???????????????', 'fa-tags', 'coupons', '', 1, '2021-09-04 11:33:25', '2021-09-04 11:33:25');
INSERT INTO `admin_menu` VALUES (11, 0, 11, '????????????', 'fa-rmb', 'orders', '', 1, '2021-09-07 15:20:11', '2021-09-07 15:20:11');
INSERT INTO `admin_menu` VALUES (14, 0, 14, '????????????', 'fa-hand-o-up', 'refund', '', 1, '2021-09-08 14:42:44', '2021-09-08 14:56:00');
INSERT INTO `admin_menu` VALUES (15, 0, 15, '??????????????????', 'fa-bars', 'categories', '', 1, '2021-09-10 10:07:57', '2021-09-10 10:08:47');
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
INSERT INTO `admin_permission_menu` VALUES (1, 2, '2021-09-02 11:22:28', '2021-09-02 11:22:28');
INSERT INTO `admin_permission_menu` VALUES (2, 3, '2021-09-02 11:22:35', '2021-09-02 11:22:35');
INSERT INTO `admin_permission_menu` VALUES (3, 4, '2021-09-02 11:22:40', '2021-09-02 11:22:40');
INSERT INTO `admin_permission_menu` VALUES (4, 5, '2021-09-02 11:22:45', '2021-09-02 11:22:45');
INSERT INTO `admin_permission_menu` VALUES (5, 6, '2021-09-02 11:22:50', '2021-09-02 11:22:50');
INSERT INTO `admin_permission_menu` VALUES (6, 7, '2021-09-02 11:22:54', '2021-09-02 11:22:54');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_permissions
-- ----------------------------
BEGIN;
INSERT INTO `admin_permissions` VALUES (1, 'Auth management', 'auth-management', '', '', 1, 0, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_permissions` VALUES (2, 'Users', 'users', '', '/auth/users*', 2, 1, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_permissions` VALUES (3, 'Roles', 'roles', '', '/auth/roles*', 3, 1, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_permissions` VALUES (4, 'Permissions', 'permissions', '', '/auth/permissions*', 4, 1, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_permissions` VALUES (5, 'Menu', 'menu', '', '/auth/menu*', 5, 1, '2021-09-02 10:55:09', NULL);
INSERT INTO `admin_permissions` VALUES (6, 'Extension', 'extension', '', '/auth/extensions*', 6, 1, '2021-09-02 10:55:09', NULL);
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
INSERT INTO `admin_role_users` VALUES (1, 1, '2021-09-02 10:55:09', '2021-09-02 10:55:09');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_roles
-- ----------------------------
BEGIN;
INSERT INTO `admin_roles` VALUES (1, 'Administrator', 'administrator', '2021-09-02 10:55:09', '2021-09-02 10:55:09');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
BEGIN;
INSERT INTO `admin_users` VALUES (1, 'admin', '$2y$10$CjSyenpvkB/Ftb1QTC96B.MdsQDleoaqtwjr5t/yeUr2BcgtkV0Uu', 'Administrator', NULL, NULL, '2021-09-02 10:55:09', '2021-09-02 10:55:09');
COMMIT;

-- ----------------------------
-- Table structure for cart_items
-- ----------------------------
DROP TABLE IF EXISTS `cart_items`;
CREATE TABLE `cart_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL COMMENT '??????ID',
  `product_sku_id` bigint(20) unsigned NOT NULL COMMENT '??????skuID',
  `amount` int(10) unsigned NOT NULL COMMENT '??????',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_items_product_sku_id_foreign` (`product_sku_id`),
  CONSTRAINT `cart_items_product_sku_id_foreign` FOREIGN KEY (`product_sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cart_items
-- ----------------------------
BEGIN;
INSERT INTO `cart_items` VALUES (1, 253729546698752, 1, 3, '2021-09-03 16:04:54', '2021-09-06 11:30:32', NULL);
INSERT INTO `cart_items` VALUES (2, 236522779443200, 2, 3, '2021-09-03 16:04:59', '2021-09-06 14:13:20', NULL);
INSERT INTO `cart_items` VALUES (3, 236522779443200, 3, 3, '2021-09-03 16:05:04', '2021-09-03 16:05:04', NULL);
INSERT INTO `cart_items` VALUES (4, 236522779443200, 4, 3, '2021-09-03 16:05:07', '2021-09-03 16:05:07', NULL);
INSERT INTO `cart_items` VALUES (5, 236522779443200, 5, 3, '2021-09-03 16:05:11', '2021-09-03 16:05:11', NULL);
INSERT INTO `cart_items` VALUES (6, 236522779443200, 6, 3, '2021-09-03 16:05:14', '2021-09-03 16:05:14', NULL);
INSERT INTO `cart_items` VALUES (7, 253729546698752, 70, 7, '2021-09-03 16:16:22', '2021-09-03 16:16:22', NULL);
INSERT INTO `cart_items` VALUES (8, 253729584447488, 2, 7, '2021-09-03 16:16:22', '2021-09-03 16:16:22', NULL);
INSERT INTO `cart_items` VALUES (9, 253729592836096, 57, 9, '2021-09-03 16:16:22', '2021-09-03 16:16:22', NULL);
INSERT INTO `cart_items` VALUES (10, 253729597030400, 77, 1, '2021-09-03 16:16:22', '2021-09-03 16:16:22', NULL);
INSERT INTO `cart_items` VALUES (11, 253729597030402, 64, 4, '2021-09-03 16:16:22', '2021-09-03 16:16:22', NULL);
INSERT INTO `cart_items` VALUES (12, 253729605419008, 58, 3, '2021-09-03 16:16:22', '2021-09-03 16:16:22', NULL);
INSERT INTO `cart_items` VALUES (13, 253729609613312, 18, 6, '2021-09-03 16:16:22', '2021-09-03 16:16:22', NULL);
INSERT INTO `cart_items` VALUES (14, 253729613807616, 78, 10, '2021-09-03 16:16:22', '2021-09-03 16:16:22', NULL);
INSERT INTO `cart_items` VALUES (15, 253729618001920, 50, 10, '2021-09-03 16:16:22', '2021-09-03 16:16:22', NULL);
INSERT INTO `cart_items` VALUES (16, 253729622196224, 15, 4, '2021-09-03 16:16:22', '2021-09-03 16:16:22', NULL);
INSERT INTO `cart_items` VALUES (17, 236522779443200, 21, 10, '2021-09-07 12:01:34', '2021-09-07 14:41:29', '2021-09-07 14:41:29');
INSERT INTO `cart_items` VALUES (18, 236522779443200, 25, 10, '2021-09-07 12:01:48', '2021-09-07 14:41:29', '2021-09-07 14:41:29');
INSERT INTO `cart_items` VALUES (19, 236522779443200, 33, 1, '2021-09-09 14:59:49', '2021-09-09 15:01:22', '2021-09-09 15:01:22');
INSERT INTO `cart_items` VALUES (20, 236522779443200, 34, 1, '2021-09-09 15:30:22', '2021-09-09 15:30:44', '2021-09-09 15:30:44');
INSERT INTO `cart_items` VALUES (21, 236522779443200, 34, 1, '2021-09-09 15:35:00', '2021-09-09 15:35:08', '2021-09-09 15:35:08');
COMMIT;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '????????????',
  `parent_id` bigint(20) unsigned DEFAULT NULL COMMENT '?????????ID',
  `is_directory` tinyint(1) NOT NULL COMMENT '??????????????????',
  `level` int(10) unsigned NOT NULL COMMENT '??????????????????',
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '???????????????????????????ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of categories
-- ----------------------------
BEGIN;
INSERT INTO `categories` VALUES (1, '????????????', NULL, 1, 0, '-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (2, '?????????', 1, 0, 1, '-1-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (3, '??????', 1, 0, 1, '-1-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (4, '?????????', 1, 0, 1, '-1-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (5, '?????????', 1, 0, 1, '-1-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (6, '?????????', 1, 0, 1, '-1-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (7, '??????', 1, 1, 1, '-1-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (8, '????????????', 7, 0, 1, '-1-7-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (9, '????????????', 7, 0, 1, '-1-7-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (10, '????????????', NULL, 1, 0, '-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (11, '?????????', 10, 0, 1, '-10-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (12, '??????', 10, 0, 1, '-10-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (13, '??????', 10, 0, 1, '-10-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (14, 'CPU', 10, 0, 1, '-10-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (15, '??????', 10, 0, 1, '-10-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (16, '??????', 10, 0, 1, '-10-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (17, '????????????', NULL, 1, 0, '-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (18, '?????????', 17, 0, 1, '-17-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (19, '?????????', 17, 0, 1, '-17-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (20, '????????????', 17, 0, 1, '-17-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (21, '?????????', 17, 0, 1, '-17-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (22, '?????????', 17, 0, 1, '-17-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (23, '?????????', 17, 0, 1, '-17-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (24, '????????????', NULL, 1, 0, '-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (25, '?????????', 24, 0, 1, '-24-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (26, '?????????', 24, 0, 1, '-24-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (27, '?????????', 24, 0, 1, '-24-', '2021-09-10 10:11:21', '2021-09-10 10:11:21', NULL);
INSERT INTO `categories` VALUES (28, 'api prots34', 7, 0, 1, '-1-7-', '2021-09-10 11:06:44', '2021-09-10 11:07:20', '2021-09-10 11:07:20');
INSERT INTO `categories` VALUES (29, '????????????', NULL, 1, 0, '-', '2021-09-10 11:09:44', '2021-09-10 11:09:44', NULL);
INSERT INTO `categories` VALUES (30, '?????????', 29, 0, 1, '-29-', '2021-09-10 11:10:09', '2021-09-10 11:10:09', NULL);
COMMIT;

-- ----------------------------
-- Table structure for coupons
-- ----------------------------
DROP TABLE IF EXISTS `coupons`;
CREATE TABLE `coupons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '??????',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '??????',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '???',
  `total_number` int(10) unsigned NOT NULL COMMENT '??????',
  `got_number` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '?????????',
  `used_number` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '??????',
  `start_time` datetime DEFAULT NULL COMMENT '??????????????????',
  `end_time` datetime DEFAULT NULL COMMENT '??????????????????',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '??????, ??????????????????',
  `value` decimal(8,2) NOT NULL COMMENT '?????????',
  `min_amount` decimal(8,2) NOT NULL COMMENT '??????????????????',
  `is_available` tinyint(1) NOT NULL DEFAULT '0' COMMENT '????????????',
  `shop_id` bigint(20) unsigned DEFAULT NULL COMMENT '??????id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupons_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of coupons
-- ----------------------------
BEGIN;
INSERT INTO `coupons` VALUES (1, 'et maiores error', 'Et veniam eos laudantium eaque eos. Hic rem ipsam aut sit et ipsum eos vitae. Consequatur quam eum repudiandae et ut ut et occaecati. Quos eos repellat facilis.', 'LTTYWH2G8Z7UNYI', 13, 1, 0, '2021-09-01 00:00:00', '2021-09-03 00:00:00', 'fixed', 10.00, 91.00, 1, 1, '2021-09-04 11:31:04', '2021-09-05 20:38:05', NULL);
INSERT INTO `coupons` VALUES (2, 'excepturi expedita incidunt', 'Aut molestiae nulla dolorem. Vitae voluptas sunt eos perferendis quia. Et nobis laudantium quas tempore sed optio voluptas est. Voluptatem minus soluta perspiciatis.', 'FJGV4V9N5JPEOLX', 26, 1, 0, '2021-09-01 00:00:00', '2021-09-10 00:00:00', 'fixed', 17.00, 95.00, 1, 1, '2021-09-04 11:31:04', '2021-09-06 14:16:00', NULL);
INSERT INTO `coupons` VALUES (3, 'optio aliquam totam', 'Rerum voluptas autem cupiditate aut laborum a minus. Architecto ut non suscipit voluptates occaecati. Soluta officiis animi omnis laudantium. Consequatur quis quidem cupiditate repudiandae.', 'MJDAHVFZ05AIQKS', 38, 1, 1, '2021-09-01 00:00:00', '2021-09-10 00:00:00', 'fixed', 112.00, 206.00, 1, 1, '2021-09-04 11:31:04', '2021-09-07 14:02:19', NULL);
INSERT INTO `coupons` VALUES (4, 'vel sit mollitia', 'Ut doloremque dignissimos voluptatibus ea natus odio aut. Labore doloribus aspernatur et voluptate voluptas. Architecto qui omnis in tempore facere.', 'RHYX7IUIJTYC6JT', 16, 16, 1, '2021-09-06 00:00:00', '2021-09-10 00:00:00', 'fixed', 88.00, 153.00, 1, 1, '2021-09-04 11:31:04', '2021-09-07 14:41:29', NULL);
INSERT INTO `coupons` VALUES (5, 'quia enim est', 'Accusantium eveniet quod non et dolorem et impedit. Eos deleniti magni illum corrupti. Est laudantium corporis ipsa enim omnis. Nemo voluptatibus voluptatem eum neque odit.', 'P3G0YEABGZNK0SY', 35, 0, 0, NULL, NULL, 'percent', 47.00, 0.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (6, 'nesciunt assumenda est', 'Magni officia autem dolores quae. Totam nihil vero sunt et id beatae dolores. Nam nostrum voluptas earum sed. Perferendis qui quia porro laudantium laborum nemo amet.', 'AVILPE88G0YCG0L', 34, 0, 0, NULL, NULL, 'fixed', 17.00, 37.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (7, 'voluptate enim omnis', 'Et molestiae voluptatem itaque esse iusto est distinctio ipsum. Delectus dicta ea earum voluptatum molestiae. Reiciendis ullam similique modi. Quae id voluptatem voluptatibus fugiat.', 'LFBEMK1VUAGSMBW', 27, 0, 0, NULL, NULL, 'fixed', 115.00, 178.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (8, 'eos porro consequuntur', 'Reiciendis modi totam sit occaecati veritatis rerum temporibus. Voluptas quidem doloribus quas quo id. Et ut cum ut rerum. Rerum cum porro architecto quia.', '5K0AB5SGKBVCLPW', 28, 0, 0, NULL, NULL, 'fixed', 178.00, 193.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (9, 'cumque eius ut', 'Tempora ipsam id velit deserunt. Aliquid sit aut dicta. Soluta placeat nulla reiciendis eligendi.', 'CONEEJVX2NXCC5W', 37, 0, 0, NULL, NULL, 'fixed', 35.00, 104.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (10, 'animi illum et', 'Voluptate voluptas a sed explicabo repellat. Incidunt architecto voluptatem officia corporis maxime et nobis repellat. Fuga et rerum dolore quia qui.', 'R3GGF1YCDO7YHKW', 38, 0, 0, NULL, NULL, 'fixed', 88.00, 151.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (11, 'et veritatis perspiciatis', 'Officia est perspiciatis eaque saepe. Molestiae eaque suscipit magni esse laudantium. Sequi totam tempore esse nemo voluptas ab velit.', '4VY3DKBAD1WN5GF', 36, 0, 0, NULL, NULL, 'fixed', 153.00, 209.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (12, 'consequatur est quaerat', 'Minima aut ut et. Autem exercitationem dolore voluptatem sapiente aspernatur ipsam expedita. Esse magnam dolores facilis velit blanditiis. Ea molestiae deleniti ad laboriosam enim ab omnis.', 'FB5GEIMYFPFTL0W', 26, 0, 0, NULL, NULL, 'fixed', 42.00, 55.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (13, 'culpa delectus rerum', 'Sint cupiditate quibusdam non cupiditate possimus sit voluptatem. Illum voluptatem fugit sit in. Nostrum minima minus consequatur at soluta sint.', 'JT8OINHAZ9GIJN7', 41, 0, 0, NULL, NULL, 'fixed', 135.00, 187.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (14, 'recusandae cumque non', 'Nam qui et iusto et vel saepe. Voluptatum sequi ullam autem dolorem enim id ipsum quia. Enim officiis tempora reprehenderit in qui. Error aut provident voluptas ducimus nulla est dignissimos porro.', 'H9A4C35ZSGNQ7BK', 36, 0, 0, NULL, NULL, 'percent', 36.00, 0.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (15, 'dolorem ea deserunt', 'Illum saepe accusantium totam quia illo itaque. Debitis cum est voluptas facere aut aut.', '4LHWSPIY4MPVFCR', 16, 0, 0, NULL, NULL, 'fixed', 12.00, 52.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (16, 'consequatur velit qui', 'Fuga sed soluta tempore aut voluptatem doloribus. Quasi voluptatum temporibus laudantium sed amet eum commodi. Et sit molestiae accusamus architecto quibusdam voluptatem.', 'OXTVLGPVCYCRYAO', 14, 0, 0, NULL, NULL, 'percent', 11.00, 0.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (17, 'iusto illo eos', 'Facilis id omnis sit. Odit perspiciatis ad aut deserunt aliquid a. Dignissimos impedit nihil cumque officia facilis ipsa.', '4NIYO2SRKEFK59U', 30, 0, 0, NULL, NULL, 'fixed', 15.00, 75.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (18, 'doloremque molestiae vel', 'Ut atque commodi quod unde. Fuga aperiam illum rerum non et. Nobis earum autem exercitationem odit.', 'LAHUT0KHDGEPPEB', 35, 0, 0, NULL, NULL, 'fixed', 119.00, 129.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (19, 'vero eum rerum', 'Ut rerum molestias qui ut. Ut minima voluptatum id occaecati et quasi illo. Omnis libero officiis ipsum incidunt beatae. Cum quidem qui officia qui dignissimos ipsa.', 'MJGMGUTA9V2HK4Q', 49, 0, 0, NULL, NULL, 'fixed', 124.00, 195.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (20, 'placeat ut vitae', 'Eos est a ea dolor mollitia aut. Aperiam nulla labore atque quam. Impedit tempora error non culpa vel dolore odio.', 'ZQLCWEFSMBUP8OQ', 25, 0, 0, NULL, NULL, 'fixed', 197.00, 293.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (21, 'et velit nobis', 'Suscipit commodi officiis laudantium hic. Qui ut officiis magni officiis architecto. Dicta autem qui consequuntur rerum dolorum. Cupiditate alias accusantium et enim quibusdam aperiam.', 'A7I0J1FMWVVGATC', 40, 0, 0, NULL, NULL, 'fixed', 33.00, 44.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (22, 'incidunt ut natus', 'Dolore est debitis voluptatem tenetur in. Voluptates esse quos ut qui.', '3QYSLKYOJKLGXST', 21, 0, 0, NULL, NULL, 'percent', 1.00, 0.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (23, 'saepe dignissimos id', 'Eaque voluptatem cumque ex eum. Totam cumque totam atque ea ipsum. Deserunt in velit eos aperiam debitis voluptas ut.', 'VSJFKAYXC1WHQJS', 44, 0, 0, NULL, NULL, 'percent', 22.00, 333.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (24, 'alias neque doloremque', 'Aut libero et eum mollitia. Mollitia voluptas qui consectetur dolor voluptatem consequatur dolores harum. Ut omnis sit est qui et ut. Cum reiciendis rerum ipsa aliquid sint ad.', 'UFEYVZE3BB1DLMD', 30, 0, 0, NULL, NULL, 'fixed', 184.00, 271.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (25, 'omnis perferendis necessitatibus', 'Soluta sequi aspernatur quisquam non debitis numquam. Ad laudantium corrupti ipsum. Consequatur et eveniet aspernatur accusamus assumenda. Omnis tenetur et ut sed maiores nisi deserunt.', 'DX4VTP4UVHGAHHL', 22, 0, 0, NULL, NULL, 'fixed', 2.00, 73.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (26, 'similique et ut', 'Exercitationem at sunt adipisci ut voluptas porro. Doloribus qui omnis iusto fugiat. Perferendis voluptatem aut architecto nesciunt non. Laborum culpa quas placeat autem molestias.', 'SAZ79KOY251ZMQG', 46, 0, 0, NULL, NULL, 'percent', 20.00, 0.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (27, 'debitis quo pariatur', 'Excepturi explicabo odit quasi sit debitis autem. Repellat placeat aut adipisci sit. Sit qui et officia dolore molestiae qui.', 'ZB945X9OWDQR80R', 49, 0, 0, NULL, NULL, 'fixed', 149.00, 161.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (28, 'est illum qui', 'Fugiat id voluptate debitis ullam aut dolorum doloribus. Sint qui enim explicabo reiciendis esse laudantium. Eveniet quia ipsa dolores. Dolor quisquam mollitia consectetur illo reiciendis saepe at.', 'HL2B3ICDEYOWZQC', 45, 0, 0, NULL, NULL, 'percent', 17.00, 612.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (29, 'eos sequi quia', 'Natus dolor est hic doloremque. Aut ipsum sit repellat ut doloremque architecto. Dicta sit voluptas ea quis corporis.', '5OMALDS6C3LALVF', 36, 0, 0, NULL, NULL, 'percent', 3.00, 519.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (30, 'sunt in incidunt', 'Aliquam sunt cum laudantium omnis voluptatem. Exercitationem totam repellendus quae sapiente. Soluta est fugit aliquid aut consequatur.', 'EXCXA0PAB3VVDUO', 36, 0, 0, NULL, NULL, 'percent', 14.00, 625.00, 1, 1, '2021-09-04 11:31:04', '2021-09-04 11:31:04', NULL);
INSERT INTO `coupons` VALUES (31, '???????????????', '???100???50', 'LTTYWH2G8Z7UNYF', 10, 0, 0, '2021-09-01 00:00:00', '2021-09-05 00:00:00', 'fixed', 50.00, 100.00, 1, 1, '2021-09-04 11:55:20', '2021-09-04 11:55:59', NULL);
COMMIT;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------
BEGIN;
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
BEGIN;
INSERT INTO `migrations` VALUES (4, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (5, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (6, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (7, '2021_09_01_162821_create_user_addresses_table', 2);
INSERT INTO `migrations` VALUES (8, '2016_01_04_173148_create_admin_tables', 3);
INSERT INTO `migrations` VALUES (9, '2020_09_07_090635_create_admin_settings_table', 3);
INSERT INTO `migrations` VALUES (10, '2020_09_22_015815_create_admin_extensions_table', 3);
INSERT INTO `migrations` VALUES (11, '2020_11_01_083237_update_admin_menu_table', 3);
INSERT INTO `migrations` VALUES (12, '2021_09_02_105644_create_products_table', 4);
INSERT INTO `migrations` VALUES (13, '2021_09_02_105808_create_product_skus_table', 4);
INSERT INTO `migrations` VALUES (14, '2021_09_02_150000_create_user_favorite_proudcts_table', 5);
INSERT INTO `migrations` VALUES (15, '2021_09_03_100710_create_cart_items_table', 6);
INSERT INTO `migrations` VALUES (16, '2021_09_04_105305_create_coupons_table', 7);
INSERT INTO `migrations` VALUES (17, '2021_09_04_123832_create_user_has_coupons_table', 8);
INSERT INTO `migrations` VALUES (18, '2021_09_05_111717_create_orders_table', 9);
INSERT INTO `migrations` VALUES (19, '2021_09_05_111747_create_order_items_table', 9);
INSERT INTO `migrations` VALUES (20, '2021_09_07_094651_create_notifications_table', 10);
INSERT INTO `migrations` VALUES (23, '2021_09_09_170752_create_categories_table', 11);
INSERT INTO `migrations` VALUES (24, '2021_09_09_172923_alter_products_add_category_id', 11);
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
INSERT INTO `notifications` VALUES ('5003eb1e-58fb-4d81-88ff-e8f71160dfa3', 'App\\Notifications\\OrderPaid', 'App\\Models\\User', 1, '{\"message\":\"\\u60a8\\u597d\\uff0c\\u60a8\\u4e8e09-07 14:02\\u521b\\u5efa\\u7684\\u8ba2\\u5355\\u5df2\\u7ecf\\u652f\\u4ed8\\u6210\\u529f\\u4e86\\u3002\\u70b9\\u51fb\\u6b64\\u5904\\u67e5\\u770b\\u8ba2\\u5355\\u8be6\\u60c5\",\"link\":\"http:\\/\\/local.shop.cn\\/api\\/v1\\/orders\\/9\"}', '2021-09-07 14:30:12', '2021-09-07 14:27:17', '2021-09-07 14:30:12');
INSERT INTO `notifications` VALUES ('625e5b1b-23e0-45e5-b611-1ed7acfeee22', 'App\\Notifications\\OrderPaid', 'App\\Models\\User', 1, '{\"message\":\"\\u60a8\\u597d\\uff0c\\u60a8\\u4e8e09-07 14:41\\u521b\\u5efa\\u7684\\u8ba2\\u5355\\u5df2\\u7ecf\\u652f\\u4ed8\\u6210\\u529f\\u4e86\\u3002\\u70b9\\u51fb\\u6b64\\u5904\\u67e5\\u770b\\u8ba2\\u5355\\u8be6\\u60c5\",\"link\":\"http:\\/\\/api.shop.jixiaoxiao.com\\/api\\/v1\\/orders\\/10\"}', NULL, '2021-09-07 14:49:02', '2021-09-07 14:49:02');
INSERT INTO `notifications` VALUES ('6294afd5-e5b9-4ee0-ad47-a2e388ced68f', 'App\\Notifications\\OrderPaid', 'App\\Models\\User', 1, '{\"message\":\"\\u60a8\\u597d\\uff0c\\u60a8\\u4e8e09-09 15:01\\u521b\\u5efa\\u7684\\u8ba2\\u5355\\u5df2\\u7ecf\\u652f\\u4ed8\\u6210\\u529f\\u4e86\\u3002\\u70b9\\u51fb\\u6b64\\u5904\\u67e5\\u770b\\u8ba2\\u5355\\u8be6\\u60c5\",\"link\":\"http:\\/\\/api.shop.jixiaoxiao.com\\/api\\/v1\\/orders\\/11\"}', NULL, '2021-09-09 15:05:23', '2021-09-09 15:05:23');
INSERT INTO `notifications` VALUES ('6813c267-c5b4-4033-b212-244c9dfd7062', 'App\\Notifications\\OrderPaid', 'App\\Models\\User', 1, '{\"message\":\"\\u60a8\\u597d\\uff0c\\u60a8\\u4e8e09-07 14:02\\u521b\\u5efa\\u7684\\u8ba2\\u5355\\u5df2\\u7ecf\\u652f\\u4ed8\\u6210\\u529f\\u4e86\\u3002\\u70b9\\u51fb\\u6b64\\u5904\\u67e5\\u770b\\u8ba2\\u5355\\u8be6\\u60c5\",\"link\":\"http:\\/\\/local.shop.cn\\/api\\/v1\\/orders\\/9\"}', '2021-09-07 14:30:12', '2021-09-07 14:27:58', '2021-09-07 14:30:12');
INSERT INTO `notifications` VALUES ('f98c7f49-609e-4705-afb1-6644461ea4bd', 'App\\Notifications\\OrderPaid', 'App\\Models\\User', 1, '{\"message\":\"\\u60a8\\u597d\\uff0c\\u60a8\\u4e8e09-06 11:35\\u521b\\u5efa\\u7684\\u8ba2\\u5355\\u5df2\\u7ecf\\u652f\\u4ed8\\u6210\\u529f\\u4e86\\u3002\\u70b9\\u51fb\\u6b64\\u5904\\u67e5\\u770b\\u8ba2\\u5355\\u8be6\\u60c5\",\"link\":\"http:\\/\\/local.shop.cn\\/api\\/v1\\/orders\\/5\"}', '2021-09-07 11:55:22', '2021-09-07 11:31:32', '2021-09-07 11:55:22');
INSERT INTO `notifications` VALUES ('fd548adc-1e21-44a4-b6a4-bc9ff59150ba', 'App\\Notifications\\OrderPaid', 'App\\Models\\User', 1, '{\"message\":\"\\u60a8\\u597d\\uff0c\\u60a8\\u4e8e09-07 14:02\\u521b\\u5efa\\u7684\\u8ba2\\u5355\\u5df2\\u7ecf\\u652f\\u4ed8\\u6210\\u529f\\u4e86\\u3002\\u70b9\\u51fb\\u6b64\\u5904\\u67e5\\u770b\\u8ba2\\u5355\\u8be6\\u60c5\",\"link\":\"http:\\/\\/local.shop.cn\\/api\\/v1\\/orders\\/9\"}', '2021-09-07 14:30:12', '2021-09-07 14:28:11', '2021-09-07 14:30:12');
COMMIT;

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL COMMENT '???????????????',
  `product_id` bigint(20) unsigned NOT NULL COMMENT '????????????ID',
  `product_sku_id` bigint(20) unsigned NOT NULL COMMENT '????????????SKU ID',
  `amount` int(10) unsigned NOT NULL COMMENT '??????',
  `price` decimal(10,2) NOT NULL COMMENT '??????',
  `rating` int(10) unsigned DEFAULT NULL COMMENT '????????????',
  `review` text COLLATE utf8mb4_unicode_ci COMMENT '????????????',
  `reviewed_at` datetime DEFAULT NULL COMMENT '????????????',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_product_id_foreign` (`product_id`),
  KEY `order_items_product_sku_id_foreign` (`product_sku_id`),
  CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_product_sku_id_foreign` FOREIGN KEY (`product_sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of order_items
-- ----------------------------
BEGIN;
INSERT INTO `order_items` VALUES (1, 1952368425959424, 1, 1, 3, 5121.00, NULL, NULL, NULL, '2021-09-06 09:18:00', '2021-09-06 09:18:00', NULL);
INSERT INTO `order_items` VALUES (2, 1973649468817408, 1, 1, 3, 5121.00, NULL, NULL, NULL, '2021-09-06 10:42:34', '2021-09-06 10:42:34', NULL);
INSERT INTO `order_items` VALUES (3, 1979984033873920, 1, 1, 3, 5121.00, NULL, NULL, NULL, '2021-09-06 11:07:44', '2021-09-06 11:07:44', NULL);
INSERT INTO `order_items` VALUES (4, 1985717945237504, 1, 1, 3, 5121.00, NULL, NULL, NULL, '2021-09-06 11:30:32', '2021-09-06 11:30:32', NULL);
INSERT INTO `order_items` VALUES (5, 1987002719272960, 2, 2, 3, 3218.00, NULL, NULL, NULL, '2021-09-06 11:35:38', '2021-09-06 11:35:38', NULL);
INSERT INTO `order_items` VALUES (6, 1991036582756352, 2, 2, 3, 3218.00, NULL, NULL, NULL, '2021-09-06 11:51:40', '2021-09-06 11:51:40', NULL);
INSERT INTO `order_items` VALUES (7, 1991426682388480, 2, 2, 3, 3218.00, NULL, NULL, NULL, '2021-09-06 11:53:13', '2021-09-06 11:53:13', NULL);
INSERT INTO `order_items` VALUES (8, 2026689177583616, 2, 2, 3, 3218.00, NULL, NULL, NULL, '2021-09-06 14:13:20', '2021-09-06 14:13:20', NULL);
INSERT INTO `order_items` VALUES (9, 2386304348192769, 7, 21, 10, 4226.00, NULL, NULL, NULL, '2021-09-07 14:02:19', '2021-09-07 14:02:19', NULL);
INSERT INTO `order_items` VALUES (10, 2386304348192769, 8, 25, 10, 1901.00, NULL, NULL, NULL, '2021-09-07 14:02:19', '2021-09-07 14:02:19', NULL);
INSERT INTO `order_items` VALUES (11, 2396162871001088, 7, 21, 10, 42.00, 5, '?????????????????????', '2021-09-08 11:41:29', '2021-09-07 14:41:29', '2021-09-08 10:57:37', NULL);
INSERT INTO `order_items` VALUES (12, 2396162871001088, 8, 25, 10, 19.00, 4, '??????????????????', '2021-09-08 11:41:29', '2021-09-07 14:41:29', '2021-09-08 10:57:37', NULL);
INSERT INTO `order_items` VALUES (13, 3125940494270464, 11, 33, 1, 5219.00, NULL, NULL, NULL, '2021-09-09 15:01:22', '2021-09-09 15:01:22', NULL);
INSERT INTO `order_items` VALUES (14, 3133330526568448, 11, 34, 1, 200.00, NULL, NULL, NULL, '2021-09-09 15:30:44', '2021-09-09 15:30:44', NULL);
INSERT INTO `order_items` VALUES (15, 3134437113987072, 11, 34, 1, 200.00, NULL, NULL, NULL, '2021-09-09 15:35:08', '2021-09-09 15:35:08', NULL);
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` bigint(20) NOT NULL COMMENT '???????????????',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '??????ID',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '????????????',
  `total_amount` decimal(8,2) NOT NULL COMMENT '???????????????',
  `remark` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '????????????',
  `paid_at` datetime DEFAULT NULL COMMENT '????????????',
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '????????????',
  `payment_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '?????????????????????',
  `refund_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending' COMMENT '????????????',
  `refund_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '????????????',
  `closed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '?????????????????????',
  `reviewed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '?????????????????????',
  `ship_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending' COMMENT '????????????',
  `ship_data` text COLLATE utf8mb4_unicode_ci COMMENT '????????????',
  `extra` text COLLATE utf8mb4_unicode_ci COMMENT '?????????????????????',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` VALUES (1, 1952368425959424, 253729546698752, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 15346.00, '?????????????????????', NULL, NULL, NULL, 'pending', NULL, 1, 0, 'pending', NULL, NULL, '2021-09-06 09:18:00', '2021-09-06 10:38:38', NULL);
INSERT INTO `orders` VALUES (2, 1973649468817408, 236522779443200, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 15363.00, '??????????????????????????????', NULL, NULL, NULL, 'pending', NULL, 1, 0, 'pending', NULL, NULL, '2021-09-06 10:22:34', '2021-09-06 10:56:47', NULL);
INSERT INTO `orders` VALUES (3, 1979984033873920, 253729546698752, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 15363.00, '??????????????????????????????', NULL, NULL, NULL, 'pending', NULL, 1, 0, 'pending', NULL, NULL, '2021-09-06 11:07:44', '2021-09-06 11:09:39', NULL);
INSERT INTO `orders` VALUES (4, 1985717945237504, 253729546698752, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 15346.00, '??????????????????????????????', NULL, NULL, NULL, 'pending', NULL, 1, 0, 'pending', NULL, NULL, '2021-09-06 11:30:32', '2021-09-06 11:32:57', NULL);
INSERT INTO `orders` VALUES (5, 1987002719272960, 236522779443200, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 9637.00, '????????????????????????', '2021-09-06 19:09:32', 'alipay', '2021090622001480940501285096', 'failed', NULL, 0, 0, 'pending', NULL, '{\"refund_reason\":\"\\u6211\\u5c31\\u662f\\u8981\\u9000\\u6b3e\",\"refund_disagree_reason\":\"1\"}', '2021-09-06 11:35:38', '2021-09-09 15:24:42', NULL);
INSERT INTO `orders` VALUES (6, 1991036582756352, 236522779443200, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 9637.00, '????????????????????????', '2021-09-06 18:54:02', 'alipay', '2021090622001480940501284260', 'failed', NULL, 0, 0, 'pending', NULL, '{\"refund_reason\":\"\\u6211\\u5c31\\u662f\\u8981\\u9000\\u6b3e\"}', '2021-09-06 11:51:40', '2021-09-09 15:29:18', NULL);
INSERT INTO `orders` VALUES (7, 1991426682388480, 236522779443200, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 9637.00, '????????????????????????', '2021-09-07 14:22:25', 'wechat', NULL, 'processing', '733bdbf1cf5d4b0ea57bd344fe8ffd7a', 1, 0, 'pending', NULL, '{\"refund_reason\":\"\\u6211\\u5c31\\u662f\\u8981\\u9000\\u6b3e\"}', '2021-09-06 11:23:13', '2021-09-09 16:06:02', NULL);
INSERT INTO `orders` VALUES (8, 2026689177583616, 236522779443200, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 9637.00, '????????????????????????', NULL, NULL, NULL, 'pending', NULL, 1, 0, 'pending', NULL, NULL, '2021-09-06 13:13:20', '2021-09-06 14:16:00', NULL);
INSERT INTO `orders` VALUES (9, 2386304348192769, 236522779443200, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 61158.00, '????????????????????????', '2021-09-07 14:22:25', 'alipay', '2021090722001480940501284600', 'failed', NULL, 0, 0, 'pending', NULL, '{\"refund_reason\":\"\\u6211\\u5c31\\u662f\\u8981\\u9000\\u6b3e\",\"refund_disagree_reason\":\"1\"}', '2021-09-07 14:02:19', '2021-09-09 15:27:09', NULL);
INSERT INTO `orders` VALUES (10, 2396162871001088, 236522779443200, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 522.00, '????????????????????????', '2021-09-07 14:49:02', 'alipay', '2021090722001480940501286723', 'failed', NULL, 0, 1, 'received', '{\"express_company\":\"\\u5706\\u901a\\u901f\\u9012\",\"express_no\":\"YT5625520277743\"}', '{\"refund_reason\":\"\\u6211\\u5c31\\u662f\\u8981\\u9000\\u6b3e\",\"refund_disagree_reason\":\"1\"}', '2021-09-07 14:41:29', '2021-09-09 15:27:38', NULL);
INSERT INTO `orders` VALUES (11, 3125940494270464, 236522779443200, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 219.00, '?????????????????????????????????????????????', '2021-09-09 15:05:23', 'alipay', '2021090922001480940501291828', 'success', '2021090922001480940501291828', 0, 0, 'pending', NULL, '{\"refund_reason\":\"\\u6211\\u5c31\\u662f\\u8981\\u9000\\u6b3e\"}', '2021-09-09 15:01:22', '2021-09-09 15:07:46', NULL);
INSERT INTO `orders` VALUES (12, 3133330526568448, 236522779443200, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 200.00, '?????????????????????????????????????????????', NULL, NULL, NULL, 'pending', NULL, 0, 0, 'pending', NULL, NULL, '2021-09-09 15:30:44', '2021-09-09 15:30:44', NULL);
INSERT INTO `orders` VALUES (13, 3134437113987072, 236522779443200, '{\"address\":\"\\u5317\\u4eac\\u5e02\\u5e02\\u8f96\\u533a\\u4e30\\u53f0\\u533a\\u7b2c26\\u8857\\u905379\\u53f7\",\"zip\":418400,\"contact_name\":\"\\u7eaa\\u79c0\\u4e91\",\"contact_phone\":\"17008646282\"}', 200.00, '?????????????????????????????????????????????', NULL, NULL, NULL, 'pending', NULL, 0, 0, 'pending', NULL, NULL, '2021-09-09 15:35:08', '2021-09-09 15:35:08', NULL);
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
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'SKU??????',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'SKU??????',
  `price` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'SKU??????',
  `stock` int(10) unsigned NOT NULL COMMENT '??????',
  `product_id` bigint(20) unsigned NOT NULL COMMENT '??????id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_skus_product_id_foreign` (`product_id`),
  CONSTRAINT `product_skus_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of product_skus
-- ----------------------------
BEGIN;
INSERT INTO `product_skus` VALUES (1, 'reprehenderit', 'Officiis accusamus consequatur similique molestiae amet est ipsa.', '5121', 37453, 1, '2021-09-02 11:21:42', '2021-09-06 11:32:58', NULL);
INSERT INTO `product_skus` VALUES (2, 'ea', 'Harum omnis voluptas dicta dolorem odio corrupti.', '3218', 97250, 2, '2021-09-02 11:21:42', '2021-09-06 14:16:00', NULL);
INSERT INTO `product_skus` VALUES (3, 'aut', 'Quia aliquam quasi in.', '2911', 5398, 2, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (4, 'eum', 'Eum voluptatem nisi sunt dolorem exercitationem.', '4292', 72891, 2, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (5, 'reiciendis', 'Id iusto eius saepe perspiciatis.', '4943', 79766, 2, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (6, 'quia', 'Repellat qui cum dolores sit et dicta non labore.', '7156', 24503, 2, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (7, 'qui', 'Occaecati ipsam maiores voluptatem rerum quidem sint vero.', '3489', 15795, 3, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (8, 'occaecati', 'Quis eos a quibusdam sint voluptatem ipsam.', '8983', 73657, 3, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (9, 'reprehenderit', 'Minima quam libero soluta quis.', '2201', 67401, 3, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (10, 'fugit', 'Aut ad qui rerum dolores error eos.', '9923', 30641, 3, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (11, 'aut', 'Quam dolor delectus et.', '2847', 57767, 3, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (12, 'est', 'Ut et explicabo doloribus nesciunt reprehenderit praesentium pariatur.', '8285', 56528, 4, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (13, 'vero', 'Dignissimos alias ipsa itaque asperiores neque optio.', '5067', 19087, 5, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (14, 'et', 'Sit sequi animi distinctio mollitia ut quasi.', '5634', 77911, 5, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (15, 'sit', 'Rerum aliquam facere quaerat.', '5433', 34403, 5, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (16, 'expedita', 'Tempore nemo modi nihil aliquam dicta quia quos nihil.', '6398', 82507, 5, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (17, 'animi', 'Unde nihil mollitia explicabo rem nisi consequuntur nesciunt.', '2537', 9429, 5, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (18, 'et', 'Sint voluptate rerum aliquam unde molestias labore.', '762', 21976, 6, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (19, 'repudiandae', 'Et odit sed non occaecati.', '28', 29177, 6, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (20, 'ipsa', 'Vitae voluptatem culpa sint recusandae ex.', '531', 68691, 6, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (21, 'autem', 'Quibusdam dolor et eos est voluptas corrupti dicta officiis.', '42', 75030, 7, '2021-09-02 11:21:42', '2021-09-07 14:41:29', NULL);
INSERT INTO `product_skus` VALUES (22, 'totam', 'Vero molestiae eos blanditiis non iste quia rerum saepe.', '1512', 20, 7, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (23, 'unde', 'Repellendus neque consequatur sunt et.', '7475', 1088, 7, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (24, 'quos', 'Ut ut dolorem necessitatibus incidunt unde dolores cupiditate.', '8290', 71265, 7, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (25, 'dolorum', 'Et consequatur deserunt tempore et veniam omnis.', '19', 64015, 8, '2021-09-02 11:21:42', '2021-09-07 14:41:29', NULL);
INSERT INTO `product_skus` VALUES (26, 'quo', 'Blanditiis a quia omnis sed optio et dolorem et.', '6474', 83023, 8, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (27, 'deleniti', 'Et recusandae itaque sunt porro aut id.', '1080', 82717, 8, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (28, 'vel', 'Voluptas perferendis ut ea voluptas officiis.', '2699', 46242, 8, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (29, 'repellat', 'Perferendis est ducimus laudantium odit quia.', '9617', 69518, 8, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (30, 'esse', 'Corrupti veniam et non sint rerum dicta soluta.', '9216', 27608, 9, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (31, 'voluptatem', 'Et autem delectus nihil mollitia praesentium ad qui rerum.', '4211', 61175, 9, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL);
INSERT INTO `product_skus` VALUES (32, 'dolores', 'Ut ut hic libero.', '8003', 82543, 10, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (33, 'inventore', 'Iste facilis nobis quidem.', '219', 499, 11, '2021-09-02 11:21:43', '2021-09-09 15:01:22', NULL);
INSERT INTO `product_skus` VALUES (34, 'et', 'Non illo ipsam cum id.', '200', 6534, 11, '2021-09-02 11:21:43', '2021-09-09 15:35:08', NULL);
INSERT INTO `product_skus` VALUES (35, 'non', 'Non dignissimos sit quia.', '6101', 92106, 11, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (36, 'dolorem', 'Rerum eaque cupiditate et molestiae.', '9347', 72706, 12, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (37, 'dolorum', 'Non in sint sint minima voluptatibus vel eaque.', '7482', 36579, 12, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (38, 'aut', 'Ullam eveniet molestiae nesciunt numquam corrupti officiis et.', '4766', 86196, 13, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (39, 'et', 'Accusantium vel quibusdam dolor voluptates.', '2272', 95503, 14, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (40, 'assumenda', 'Repellat ratione consequatur aut quos consectetur illo.', '4762', 39355, 14, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (41, 'dolorem', 'Hic et laudantium sint animi a qui sequi.', '253', 89841, 15, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (42, 'explicabo', 'Dicta quod tempore aspernatur est eum ea.', '2244', 12292, 15, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (43, 'et', 'Aut recusandae veritatis consectetur molestias qui sint ducimus.', '3654', 41846, 15, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (44, 'laborum', 'Culpa sint provident ipsum maiores labore.', '9917', 356, 15, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (45, 'dolor', 'Ratione excepturi libero quia a sed sunt quod.', '9655', 93754, 15, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (46, 'accusantium', 'Nisi aliquam commodi dolor recusandae voluptas odio sequi.', '6042', 69585, 16, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (47, 'error', 'Officia fugit sequi aut expedita odit enim.', '7401', 68440, 16, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (48, 'molestiae', 'Tempora aliquam ut sint repellat.', '7083', 69679, 16, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (49, 'a', 'Exercitationem est dicta quis aperiam.', '6958', 95024, 17, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (50, 'ratione', 'Quis totam reprehenderit et fugiat eum labore sint aut.', '3498', 33815, 17, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (51, 'est', 'At qui illum et consequatur dolorem.', '7107', 53265, 18, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (52, 'dolorem', 'Cupiditate vel qui quaerat ipsa alias molestiae.', '5374', 93441, 18, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (53, 'perferendis', 'Nihil occaecati nobis illo rerum.', '3004', 43139, 19, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (54, 'non', 'Dolor ullam dicta laudantium expedita.', '7535', 60267, 19, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (55, 'et', 'Architecto nulla velit fugit iste aut sequi qui voluptatem.', '5007', 72911, 19, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (56, 'consequatur', 'Eaque earum libero voluptas.', '2698', 750, 20, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (57, 'nulla', 'Incidunt voluptate mollitia ut commodi.', '9393', 41867, 21, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (58, 'corrupti', 'Adipisci dolor voluptatem autem excepturi nulla et repellendus.', '7624', 98274, 22, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (59, 'quasi', 'Placeat consectetur dolore sed magnam in.', '1971', 68493, 22, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (60, 'quaerat', 'Et porro autem corporis libero delectus qui non non.', '7435', 39205, 23, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (61, 'dolor', 'Libero esse dolorem blanditiis delectus accusantium officia explicabo.', '7168', 42830, 24, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (62, 'dignissimos', 'Odit repudiandae dolor sed et ipsam vero voluptas.', '7744', 43848, 24, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (63, 'perferendis', 'Perspiciatis fugiat ad impedit iste reiciendis quis.', '6821', 65566, 25, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (64, 'non', 'Distinctio accusantium et et illum.', '1575', 99103, 25, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (65, 'rerum', 'Ut dolor rerum eveniet tempora.', '4025', 2923, 26, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (66, 'quia', 'Nisi quo soluta perspiciatis earum voluptatem voluptas.', '1908', 63558, 27, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (67, 'aut', 'Exercitationem et aliquam dolor pariatur omnis.', '5436', 52830, 27, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (68, 'nihil', 'Doloribus fugit sed neque labore in et.', '7127', 42058, 27, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (69, 'debitis', 'Et suscipit et dolor voluptates optio.', '9557', 60833, 27, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (70, 'voluptatem', 'Corporis natus incidunt tempora.', '5036', 58807, 28, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (71, 'aut', 'Consequuntur aperiam error fugiat vel.', '8139', 8820, 28, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (72, 'et', 'Sit vel iste cum nemo provident.', '1858', 91263, 28, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (73, 'dolores', 'Et velit velit eveniet consequatur nostrum veritatis.', '273', 63519, 28, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (74, 'voluptatem', 'Laboriosam voluptatem et qui commodi expedita.', '8938', 32386, 28, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (75, 'est', 'Corporis quibusdam fugit facere dolore quam explicabo exercitationem.', '9699', 99255, 29, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (76, 'ut', 'Dolores quisquam consequatur quasi et doloribus.', '8183', 60562, 29, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (77, 'officiis', 'Eos ab qui iste libero.', '6926', 68058, 29, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (78, 'excepturi', 'Enim assumenda quia voluptatum totam asperiores.', '5412', 79840, 29, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (79, 'et', 'Aspernatur sed modi consequatur voluptatem.', '3628', 17752, 30, '2021-09-02 11:21:43', '2021-09-02 11:21:43', NULL);
INSERT INTO `product_skus` VALUES (80, '??????64G', 'iphon12 ??????64G', '6099.00', 100, 31, '2021-09-02 11:49:04', '2021-09-02 11:49:04', NULL);
INSERT INTO `product_skus` VALUES (81, '??????128G', 'iphon12 ??????128G', '6599.00', 50, 31, '2021-09-02 11:49:04', '2021-09-02 11:49:04', NULL);
INSERT INTO `product_skus` VALUES (82, '??????256G', 'iphon12 ??????256G', '7399.00', 10, 31, '2021-09-02 11:49:04', '2021-09-02 11:49:04', NULL);
COMMIT;

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '????????????',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '????????????',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '???????????????',
  `on_sale` tinyint(1) NOT NULL DEFAULT '0' COMMENT '?????? 0 ?????? 1 ??????',
  `rating` double(8,2) NOT NULL DEFAULT '5.00' COMMENT '??????????????????',
  `sold_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '??????',
  `review_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '????????????',
  `price` decimal(10,2) NOT NULL COMMENT 'SKU????????????',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `shop_id` int(10) DEFAULT NULL COMMENT '??????ID',
  PRIMARY KEY (`id`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of products
-- ----------------------------
BEGIN;
INSERT INTO `products` VALUES (1, NULL, 'vitae', 'Et atque eos suscipit corrupti porro adipisci.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 2.00, 0, 0, 5121.00, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL, 1);
INSERT INTO `products` VALUES (2, NULL, 'impedit', 'A et et similique assumenda adipisci accusantium non.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 1.00, 6, 0, 2911.00, '2021-09-02 11:21:42', '2021-09-07 11:10:02', NULL, 1);
INSERT INTO `products` VALUES (3, NULL, 'sint', 'Aspernatur aut voluptatem ab aperiam eos libero voluptatem.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 0.00, 0, 0, 2201.00, '2021-09-02 11:21:42', '2021-09-02 14:56:46', NULL, 1);
INSERT INTO `products` VALUES (4, NULL, 'eos', 'Quasi sapiente nihil numquam.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 0.00, 0, 0, 8285.00, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL, 1);
INSERT INTO `products` VALUES (5, NULL, 'enim', 'Modi atque nam eos doloribus unde excepturi expedita.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 5.00, 0, 0, 2537.00, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL, 1);
INSERT INTO `products` VALUES (6, NULL, 'doloremque', 'Id molestiae laborum aut voluptate similique.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 0.00, 0, 0, 531.00, '2021-09-02 11:21:42', '2021-09-02 11:21:42', NULL, 1);
INSERT INTO `products` VALUES (7, NULL, 'distinctio', 'Repellendus est aut sed aut.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 5.00, 20, 1, 1512.00, '2021-09-02 11:21:42', '2021-09-08 10:57:37', NULL, 1);
INSERT INTO `products` VALUES (8, NULL, 'et', 'Vitae sapiente nostrum corrupti expedita blanditiis doloribus illo.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 4.00, 20, 1, 1080.00, '2021-09-02 11:21:42', '2021-09-08 10:57:37', NULL, 1);
INSERT INTO `products` VALUES (9, NULL, 'aut', 'Eum et tenetur impedit corrupti ducimus.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 1.00, 0, 0, 4211.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (10, NULL, 'dolorem', 'Adipisci illum quas accusantium veritatis voluptatem sed hic.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 0.00, 0, 0, 8003.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (11, NULL, 'dolore', 'Et quos ratione quam inventore ea dolores aut cumque.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 3.00, 1, 0, 5219.00, '2021-09-02 11:21:42', '2021-09-09 15:05:23', NULL, 1);
INSERT INTO `products` VALUES (12, NULL, 'nostrum', 'Dolor dolores aliquam sed.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 4.00, 0, 0, 7482.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (13, NULL, 'minus', 'Porro adipisci eius unde est.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 2.00, 0, 0, 4766.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (14, NULL, 'qui', 'Maxime qui aspernatur enim provident.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 2.00, 0, 0, 2272.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (15, NULL, 'quis', 'In qui nobis tenetur accusamus ea.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 2.00, 0, 0, 253.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (16, NULL, 'voluptas', 'Accusantium eligendi non alias molestias ullam.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 1.00, 0, 0, 6042.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (17, NULL, 'non', 'Voluptatum quis ut quas consectetur sequi.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 5.00, 0, 0, 3498.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (18, NULL, 'distinctio', 'Accusamus nam non non ut eum perspiciatis saepe.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 0.00, 0, 0, 5374.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (19, NULL, 'velit', 'Quis ducimus illum quae deleniti et.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 1.00, 0, 0, 3004.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (20, NULL, 'et', 'Numquam et est ratione sequi qui.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 2.00, 0, 0, 2698.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (21, NULL, 'ea', 'Corporis maiores fugiat odio molestias.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 2.00, 0, 0, 9393.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (22, NULL, 'consequuntur', 'Omnis praesentium voluptatum provident cumque.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 3.00, 0, 0, 1971.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (23, NULL, 'tempora', 'Exercitationem odit minima autem voluptas.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 4.00, 0, 0, 7435.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (24, NULL, 'quia', 'Alias aut eaque aut aliquam sit earum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 4.00, 0, 0, 7168.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (25, NULL, 'natus', 'Aut cupiditate quos aliquam est eligendi.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 1.00, 0, 0, 1575.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (26, NULL, 'adipisci', 'Quidem hic amet a aut.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 1.00, 0, 0, 4025.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (27, NULL, 'nulla', 'Reprehenderit dicta animi facilis dolor consequatur.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 1.00, 0, 0, 1908.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (28, NULL, 'harum', 'Fugiat nesciunt nam assumenda quae sit.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 3.00, 0, 0, 273.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (29, NULL, 'nemo', 'Veritatis nihil consequatur laudantium omnis illo eos.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 5.00, 0, 0, 5412.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (30, NULL, 'quia', 'Accusamus vero magni aperiam quis maxime.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 5.00, 0, 0, 3628.00, '2021-09-02 11:21:42', '2021-09-02 11:21:43', NULL, 1);
INSERT INTO `products` VALUES (31, NULL, 'Apple iPhone 12 (A2404) 128GB', '<p>???????????????Apple iPhone 12 (A2404) 128GB ?????? ????????????????????????5G ??????????????????</p>', 'http://local.shop.cn/storage/admin/images/5d79e745f62367d99dd93056b1e219e9.png', 1, 5.00, 0, 0, 6099.00, '2021-09-02 11:49:04', '2021-09-02 14:28:17', NULL, 1);
INSERT INTO `products` VALUES (32, NULL, 'non', 'Quibusdam qui quas cupiditate non alias.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL, 1);
INSERT INTO `products` VALUES (33, NULL, 'odit', 'Et aut corporis quia laborum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL, 1);
INSERT INTO `products` VALUES (34, NULL, 'explicabo', 'Rerum dolores voluptatem pariatur facilis et aut.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL, 1);
INSERT INTO `products` VALUES (35, NULL, 'neque', 'Est repellendus voluptas ut dolor mollitia.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL, 1);
INSERT INTO `products` VALUES (36, NULL, 'eum', 'Ut blanditiis voluptatum rerum deleniti eum necessitatibus velit.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL, 1);
INSERT INTO `products` VALUES (37, NULL, 'voluptates', 'Qui iste doloremque dolore perferendis numquam vero sint.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL, 1);
INSERT INTO `products` VALUES (38, NULL, 'dolorum', 'Cum dolores quibusdam sed dolores.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL, 1);
INSERT INTO `products` VALUES (39, NULL, 'expedita', 'Similique consequuntur ut reprehenderit in.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL, 1);
INSERT INTO `products` VALUES (40, NULL, 'enim', 'Dignissimos earum nihil sit ea culpa ullam cum voluptate.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL, 1);
INSERT INTO `products` VALUES (41, NULL, 'qui', 'Tempore consequatur voluptate ex nemo.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (42, NULL, 'necessitatibus', 'Ullam asperiores beatae aliquam aspernatur.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (43, NULL, 'blanditiis', 'Et delectus rerum voluptates voluptatem eius nostrum dolorum laudantium.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (44, NULL, 'ullam', 'Nihil expedita ea rerum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (45, NULL, 'deserunt', 'Amet illum sit non ea deleniti aliquam.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (46, NULL, 'voluptates', 'Illum molestiae quia velit iure dolorum qui similique.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (47, NULL, 'ratione', 'Assumenda voluptatem voluptas quod temporibus.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (48, NULL, 'eos', 'Iste inventore eligendi dolorem aut.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (49, NULL, 'nisi', 'Officia id iure esse est ex non.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (50, NULL, 'odio', 'Ad est nisi qui dignissimos nemo aperiam.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (51, NULL, 'repellendus', 'Accusantium animi blanditiis voluptatem.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (52, NULL, 'vel', 'Voluptas eveniet vero est delectus qui in doloribus similique.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (53, NULL, 'excepturi', 'Amet quia architecto vel molestias iure.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (54, NULL, 'perspiciatis', 'Perspiciatis quas impedit nesciunt repellendus quo magni ducimus.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (55, NULL, 'blanditiis', 'Laborum et commodi officiis.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (56, NULL, 'aperiam', 'Amet optio doloremque molestias tempora blanditiis illum porro modi.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (57, NULL, 'aperiam', 'Illum harum dignissimos animi dicta laboriosam.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (58, NULL, 'placeat', 'Dicta minus blanditiis qui cumque nesciunt.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (59, NULL, 'fugiat', 'Saepe corporis neque dolor sed aspernatur ut.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (60, NULL, 'maiores', 'Ea quia illum dolores voluptatem expedita deserunt qui.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (61, NULL, 'quis', 'Voluptas culpa eaque aut quas illo tempora.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (62, NULL, 'blanditiis', 'Sed optio assumenda nam provident aliquid dolor.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (63, NULL, 'qui', 'Iure et et nulla nesciunt aut molestias.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (64, NULL, 'repellat', 'Aut odit accusantium omnis ut quasi.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (65, NULL, 'praesentium', 'Excepturi officiis perferendis et voluptate et adipisci magnam accusamus.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (66, NULL, 'nostrum', 'Consequatur rerum eius quidem et enim suscipit unde.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (67, NULL, 'quis', 'Ratione sunt dolorum nihil optio veritatis consequatur quia.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (68, NULL, 'recusandae', 'Deleniti corrupti sapiente quis voluptatem et eligendi dignissimos.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (69, NULL, 'corrupti', 'Vel hic cumque et eligendi ullam vel.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (70, NULL, 'eos', 'Ex voluptates tenetur explicabo nihil ratione.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (71, NULL, 'maiores', 'Sed accusantium ab quis iste aut.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (72, NULL, 'rerum', 'Et sint qui laborum optio accusamus quos dolore.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (73, NULL, 'fugiat', 'Dolores inventore incidunt doloribus qui repudiandae.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (74, NULL, 'distinctio', 'Qui explicabo non commodi expedita.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (75, NULL, 'illo', 'Magnam dolores velit maxime eum voluptatum perspiciatis fuga.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (76, NULL, 'repudiandae', 'Repellendus qui dolores officia optio quia a veniam.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (77, NULL, 'est', 'Hic soluta dicta aut delectus pariatur ullam voluptatibus nihil.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (78, NULL, 'corporis', 'Reprehenderit ut et quibusdam et totam quam hic.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (79, NULL, 'recusandae', 'Quis vitae cupiditate rerum quos eligendi eos eum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (80, NULL, 'vel', 'Et aut voluptas magnam rerum ea sint.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (81, NULL, 'aliquam', 'Autem aut enim sequi iste.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (82, NULL, 'quae', 'Sunt aut eius impedit.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (83, NULL, 'rerum', 'Optio aperiam fuga molestiae error.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (84, NULL, 'placeat', 'Ea aspernatur id quia dolores tempora fuga.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (85, NULL, 'eum', 'Distinctio velit ut porro.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (86, NULL, 'nisi', 'Similique inventore quia placeat qui iure illo voluptatem.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (87, NULL, 'quidem', 'Magnam iusto dicta laborum consequuntur quo voluptas expedita.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL, 1);
INSERT INTO `products` VALUES (88, NULL, 'soluta', 'Aperiam minima similique saepe impedit.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 1);
INSERT INTO `products` VALUES (89, NULL, 'est', 'Iusto repellat a sit et molestiae ex quidem.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 1);
INSERT INTO `products` VALUES (90, NULL, 'dignissimos', 'Velit quia laborum et voluptatem.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 1);
INSERT INTO `products` VALUES (91, NULL, 'libero', 'Eius itaque laboriosam quo voluptatem et aspernatur.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (92, NULL, 'magni', 'Quo dolorum unde modi natus quae nesciunt nulla.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (93, NULL, 'vel', 'Dolor facere eos neque veniam magnam odio.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (94, NULL, 'sunt', 'Iste tempore in molestiae.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (95, NULL, 'necessitatibus', 'Eum quae tenetur at sit sunt.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (96, NULL, 'impedit', 'Eum voluptatem rerum iste est facilis.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (97, NULL, 'omnis', 'Excepturi voluptatem et sit officia nisi.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (98, NULL, 'provident', 'Blanditiis quidem recusandae et qui sapiente.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (99, NULL, 'voluptates', 'Ut et in iure eum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (100, NULL, 'quaerat', 'Amet culpa quo vero delectus numquam perspiciatis eos.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (101, NULL, 'quo', 'Veniam cumque laudantium aut eum sit incidunt.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (102, NULL, 'quo', 'Sapiente iusto molestiae sint eaque quos enim.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:49:52', '2021-09-02 15:49:52', NULL, 2);
INSERT INTO `products` VALUES (103, 25, 'ullam', 'Illum laboriosam iure aut ad et cumque eligendi.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-10 14:54:54', NULL, 2);
INSERT INTO `products` VALUES (104, NULL, 'adipisci', 'Dignissimos quisquam sunt odio in eligendi.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (105, NULL, 'aut', 'Veritatis consequatur sit et quod sint sed quia.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (106, NULL, 'dolores', 'Ratione aspernatur suscipit esse et voluptatem ipsa.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (107, NULL, 'labore', 'Qui esse incidunt et ratione eius enim.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (108, NULL, 'illo', 'Sint et possimus exercitationem magnam laudantium rem qui.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (109, NULL, 'repellendus', 'Et molestiae unde laborum recusandae non minus maiores.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (110, NULL, 'consequuntur', 'Tenetur dolore eius dolorem culpa aperiam illo et.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (111, NULL, 'provident', 'Alias animi delectus commodi earum maiores voluptas.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (112, NULL, 'consequuntur', 'Modi molestias facilis consequatur.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (113, NULL, 'delectus', 'Aperiam deserunt aut dolores sint sit mollitia odio.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (114, NULL, 'voluptatem', 'Est soluta illum laudantium sit odit non qui voluptas.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (115, NULL, 'sapiente', 'Voluptas molestiae autem occaecati officia ipsa ipsam qui.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (116, NULL, 'rerum', 'Impedit numquam omnis velit qui est distinctio.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (117, NULL, 'consequuntur', 'Consequuntur ea quibusdam quas facere voluptas ut quaerat.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (118, NULL, 'corrupti', 'Eligendi repellat impedit corporis.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (119, NULL, 'qui', 'Asperiores unde sequi reprehenderit laudantium.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (120, NULL, 'rerum', 'Laboriosam repellat omnis atque accusamus laboriosam et.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (121, NULL, 'repudiandae', 'Non occaecati nihil et at saepe.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (122, NULL, 'atque', 'Aliquid dignissimos neque modi iste voluptates omnis.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (123, NULL, 'quia', 'Delectus rerum error illum qui corporis velit et doloribus.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (124, NULL, 'magni', 'Exercitationem optio molestiae blanditiis eveniet neque neque dolor.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (125, NULL, 'et', 'Et voluptate dolor molestiae eum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (126, NULL, 'quia', 'Similique qui fugit neque dolores nemo quod.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (127, NULL, 'quod', 'Rerum omnis quisquam dolorum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (128, NULL, 'deserunt', 'Explicabo voluptates occaecati et quia ad.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (129, NULL, 'esse', 'Consequatur impedit velit consequuntur.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (130, NULL, 'est', 'Assumenda illo soluta corporis ipsam est.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (131, NULL, 'reprehenderit', 'Aperiam architecto quae libero iusto.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (132, NULL, 'ipsum', 'Sed pariatur occaecati odit consequatur.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (133, NULL, 'est', 'Fugiat voluptatibus cum delectus atque possimus ipsa.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (134, NULL, 'in', 'Perferendis pariatur labore voluptatibus autem libero tempore aut.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (135, NULL, 'voluptatem', 'Porro libero facilis voluptatibus vero dolor.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (136, NULL, 'quibusdam', 'Provident quam provident repellendus tenetur expedita consequatur occaecati sit.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (137, NULL, 'voluptatem', 'Enim aut natus nostrum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (138, NULL, 'sit', 'Doloremque facere fugiat a et ipsa fugiat.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (139, NULL, 'dolore', 'Vel harum suscipit aliquid inventore.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (140, NULL, 'officiis', 'Praesentium cum aut sint beatae ea eaque consequatur.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (141, NULL, 'nesciunt', 'Accusantium minima sequi qui ducimus at.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (142, NULL, 'cum', 'Doloremque neque aut aut sunt accusamus sint consequatur.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (143, NULL, 'cupiditate', 'Qui quasi error ad.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (144, NULL, 'aut', 'Quibusdam nam quod eum ducimus ab omnis.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (145, NULL, 'odit', 'Repudiandae et nemo aut iusto.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/r3BNRe4zXG.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (146, NULL, 'ipsam', 'Recusandae magni et sit autem optio nostrum reiciendis.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (147, NULL, 'voluptatum', 'Natus culpa tempora est ut vel.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (148, NULL, 'atque', 'Ad eaque recusandae voluptates natus.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (149, NULL, 'cum', 'Natus beatae est consequatur voluptatum id minus cum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/XrtIwzrxj7.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (150, NULL, 'sit', 'Ut sed aliquam aut eaque dolores inventore laborum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/uYEHCJ1oRp.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (151, NULL, 'sunt', 'Omnis commodi recusandae quaerat consequatur iure qui ipsum impedit.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 5.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (152, NULL, 'culpa', 'Ut qui pariatur incidunt numquam.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (153, NULL, 'et', 'Dolor assumenda sequi asperiores illo eum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (154, NULL, 'enim', 'Pariatur veritatis et culpa aspernatur ex mollitia qui.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/2JMRaFwRpo.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (155, NULL, 'consequatur', 'Inventore eveniet facere ratione voluptatum id in.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (156, NULL, 'eos', 'Ut quia omnis laboriosam.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/C0bVuKB2nt.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (157, NULL, 'distinctio', 'Eaque dolorem eligendi esse officia ut.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (158, NULL, 'nulla', 'Mollitia pariatur aut consequatur quia.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (159, NULL, 'harum', 'Natus explicabo id molestias necessitatibus.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (160, NULL, 'soluta', 'Earum consequatur ipsa est laboriosam.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (161, NULL, 'aut', 'Voluptatem doloremque id voluptas dolore enim corporis.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/7kG1HekGK6.jpg', 1, 4.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (162, NULL, 'dolorum', 'Ut in totam nam repellat ipsam culpa nihil et.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/1B3n0ATKrn.jpg', 1, 1.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (163, NULL, 'dolorem', 'Ducimus unde voluptatem earum repellat voluptatum.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 0.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (164, NULL, 'qui', 'Ratione qui inventore laboriosam accusantium perspiciatis.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/82Wf2sg8gM.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (165, NULL, 'alias', 'Magnam pariatur laudantium ut iusto velit incidunt porro ea.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/pa7DrV43Mw.jpg', 1, 3.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
INSERT INTO `products` VALUES (166, NULL, 'ea', 'Voluptas laboriosam dolor et voluptatem fuga tenetur.', 'https://lccdn.phphub.org/uploads/images/201806/01/5320/nIvBAQO5Pj.jpg', 1, 2.00, 0, 0, 0.00, '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL, 2);
COMMIT;

-- ----------------------------
-- Table structure for user_addresses
-- ----------------------------
DROP TABLE IF EXISTS `user_addresses`;
CREATE TABLE `user_addresses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL COMMENT '??????ID',
  `province` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '???',
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '???',
  `district` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '???',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '????????????',
  `zip` int(10) unsigned NOT NULL COMMENT '??????',
  `contact_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '???????????????',
  `contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '???????????????',
  `last_used_at` datetime DEFAULT NULL COMMENT '????????????????????????',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of user_addresses
-- ----------------------------
BEGIN;
INSERT INTO `user_addresses` VALUES (1, 236522779443200, '?????????', '?????????', '?????????', '???2??????420???', 137300, '??????', '15039453001', NULL, '2021-09-01 16:58:01', '2021-09-02 10:34:08', '2021-09-02 10:34:08');
INSERT INTO `user_addresses` VALUES (2, 236522779443200, '?????????', '?????????', '?????????', '???26??????79???', 418400, '?????????', '17008646282', '2021-09-09 15:35:08', '2021-09-01 17:08:21', '2021-09-09 15:35:08', NULL);
INSERT INTO `user_addresses` VALUES (3, 236522779443200, '?????????', '?????????', '?????????', '???27??????743???', 504900, '?????????', '13162161533', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (4, 236522779443200, '?????????', '?????????', '?????????', '???37??????863???', 281600, '?????????', '17193066301', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (5, 253729546698752, '?????????', '?????????', '?????????', '???22??????386???', 706700, '?????????', '18293651212', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (6, 253729546698752, '?????????', '?????????', '?????????', '???61??????766???', 405400, '??????', '17866170508', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (7, 253729584447488, '?????????', '????????????', '?????????', '???47??????567???', 845300, '??????', '15898062181', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (8, 253729592836096, '?????????', '????????????', '?????????', '???49??????351???', 454700, '??????', '13672451440', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (9, 253729592836096, '?????????', '????????????', '?????????', '???90??????531???', 688800, '??????', '15941443054', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (10, 253729597030400, '?????????', '?????????', '?????????', '???69??????933???', 45800, '??????', '13718009171', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (11, 253729597030400, '?????????', '?????????', '?????????', '???58??????517???', 63700, '?????????', '17087844028', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (12, 253729597030402, '?????????', '?????????', '?????????', '???33??????791???', 631800, '?????????', '13539082696', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (13, 253729605419008, '?????????', '?????????', '?????????', '???18??????960???', 628800, '?????????', '13557522898', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (14, 253729605419008, '?????????', '?????????', '?????????', '???99??????100???', 416300, '??????', '15766846185', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (15, 253729609613312, '?????????', '?????????', '?????????', '???38??????472???', 216000, '??????', '15268578221', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (16, 253729609613312, '?????????', '?????????', '?????????', '???86??????760???', 634100, '??????', '18552396664', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (17, 253729609613312, '?????????', '?????????', '?????????', '???61??????819???', 423500, '??????', '15294488888', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (18, 253729613807616, '?????????', '?????????', '?????????', '???44??????788???', 812500, '??????', '18211166295', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (19, 253729613807616, '?????????', '?????????', '?????????', '???63??????840???', 596000, '?????????', '13112737213', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (20, 253729618001920, '?????????', '????????????', '?????????', '???70??????60???', 276900, '?????????', '13865487547', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (21, 253729618001920, '?????????', '?????????', '?????????', '???87??????432???', 432400, '??????', '17019641255', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (22, 253729622196224, '?????????', '?????????', '?????????', '???99??????311???', 626600, '??????', '15394337166', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (23, 253729622196224, '?????????', '?????????', '?????????', '???61??????825???', 495300, '??????', '13361046567', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (24, 253729622196224, '?????????', '?????????', '?????????', '???44??????992???', 131200, '??????', '13628271496', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (25, 253729626390528, '?????????', '?????????', '?????????', '???68??????136???', 302800, '??????', '15656643690', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (26, 253729630584832, '?????????', '?????????', '?????????', '???97??????633???', 281000, '?????????', '18138241864', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (27, 253729630584832, '?????????', '?????????', '?????????', '???0??????313???', 524800, '?????????', '13832365438', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (28, 253729634779136, '?????????', '?????????', '?????????', '???19??????577???', 744600, '?????????', '13918899670', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (29, 253729634779136, '?????????', '????????????', '?????????', '???15??????988???', 564300, '?????????', '13843345950', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (30, 253729634779136, '?????????', '?????????', '?????????', '???67??????591???', 565400, '?????????', '17003373118', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (31, 253729638973440, '?????????', '?????????', '?????????', '???65??????78???', 831900, '??????', '18005483373', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (32, 253729643167744, '?????????', '?????????', '?????????', '???92??????669???', 295000, '??????', '13249930620', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (33, 253729643167744, '?????????', '?????????', '?????????', '???40??????77???', 81400, '??????', '13924099711', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (34, 253729643167744, '?????????', '?????????', '?????????', '???10??????589???', 337000, '??????', '18090896649', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (35, 253729647362048, '?????????', '?????????', '?????????', '???23??????884???', 323300, '??????', '15668190904', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (36, 253729647362050, '?????????', '????????????', '?????????', '???91??????223???', 725300, '??????', '13767794760', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (37, 253729647362050, '?????????', '?????????', '?????????', '???22??????871???', 332500, '?????????', '15984235399', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (38, 253729647362050, '?????????', '?????????', '?????????', '???2??????293???', 725300, '??????', '15989706370', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (39, 253729655750656, '?????????', '?????????', '?????????', '???39??????641???', 787600, '??????', '17091176226', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (40, 253729655750656, '?????????', '?????????', '?????????', '???62??????785???', 766900, '?????????', '13295873031', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (41, 253729655750656, '?????????', '?????????', '?????????', '???89??????963???', 247500, '??????', '17695552459', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (42, 253729659944960, '?????????', '?????????', '?????????', '???55??????205???', 417100, '??????', '13612465255', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (43, 253729664139264, '?????????', '?????????', '?????????', '???84??????606???', 641600, '??????', '18338047178', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (44, 253729668333568, '?????????', '?????????', '?????????', '???7??????696???', 617400, '?????????', '17090168918', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (45, 253729668333568, '?????????', '????????????', '?????????', '???3??????950???', 392400, '??????', '13061039734', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (46, 253729668333570, '?????????', '?????????', '?????????', '???6??????686???', 736700, '??????', '17098358442', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (47, 253729668333570, '?????????', '?????????', '?????????', '???98??????969???', 691800, '?????????', '18318710166', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (48, 253729676722176, '?????????', '?????????', '?????????', '???76??????849???', 103300, '?????????', '14771485188', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (49, 253729676722176, '?????????', '?????????', '?????????', '???6??????751???', 655500, '?????????', '18701397662', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (50, 253729676722176, '?????????', '?????????', '?????????', '???75??????637???', 72000, '??????', '14574512134', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (51, 253729680916480, '?????????', '????????????', '?????????', '???98??????731???', 517800, '??????', '17030430578', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (52, 253729680916480, '?????????', '?????????', '?????????', '???78??????250???', 267300, '??????', '13087083253', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (53, 253729685110784, '?????????', '?????????', '?????????', '???5??????60???', 108000, '??????', '17027001900', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (54, 253729685110784, '?????????', '?????????', '?????????', '???80??????221???', 744600, '?????????', '13531817263', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (55, 253729685110784, '?????????', '?????????', '?????????', '???55??????725???', 185800, '??????', '13896502714', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (56, 253729689305088, '?????????', '?????????', '?????????', '???61??????883???', 214700, '??????', '15253124366', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (57, 253729693499392, '?????????', '????????????', '?????????', '???1??????99???', 857900, '??????', '13744161316', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (58, 253729693499392, '?????????', '?????????', '?????????', '???27??????924???', 36500, '??????', '18653913406', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (59, 253729697693696, '?????????', '????????????', '?????????', '???88??????74???', 474000, '??????', '15808832704', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (60, 253729697693696, '?????????', '?????????', '?????????', '???62??????483???', 181300, '??????', '14524101492', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (61, 253729697693698, '?????????', '?????????', '?????????', '???49??????898???', 852100, '??????', '17114168266', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (62, 253729697693698, '?????????', '?????????', '?????????', '???23??????824???', 226300, '?????????', '15882838332', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (63, 253729706082304, '?????????', '?????????', '?????????', '???94??????513???', 97200, '??????', '18528975929', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (64, 253729710276608, '?????????', '?????????', '?????????', '???81??????939???', 367900, '?????????', '15573842198', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (65, 253729714470912, '?????????', '?????????', '?????????', '???79??????23???', 97300, '??????', '15583444242', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (66, 253729714470912, '?????????', '?????????', '?????????', '???30??????38???', 234700, '??????', '17056372994', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (67, 253729718665216, '?????????', '?????????', '?????????', '???88??????394???', 843700, '??????', '15994957218', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (68, 253729718665216, '?????????', '?????????', '?????????', '???98??????750???', 85200, '??????', '15551173308', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (69, 253729718665218, '?????????', '?????????', '?????????', '???86??????180???', 646900, '??????', '13939625991', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (70, 253729718665218, '?????????', '?????????', '?????????', '???41??????266???', 637200, '?????????', '18709403935', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (71, 253729718665218, '?????????', '?????????', '?????????', '???71??????729???', 154800, '?????????', '13394447884', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (72, 253729727053824, '?????????', '????????????', '?????????', '???55??????715???', 585000, '??????', '13589641168', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (73, 253729727053824, '?????????', '?????????', '?????????', '???16??????965???', 81800, '??????', '15614273818', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (74, 253729731248128, '?????????', '?????????', '?????????', '???68??????272???', 341200, '??????', '18483338749', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (75, 253729731248128, '?????????', '?????????', '?????????', '???49??????981???', 556700, '??????', '17072300111', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (76, 253729731248128, '?????????', '?????????', '?????????', '???50??????718???', 78500, '??????', '17012411479', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (77, 253729735442432, '?????????', '?????????', '?????????', '???12??????918???', 218100, '??????', '18051976534', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (78, 253729735442432, '?????????', '?????????', '?????????', '???88??????184???', 184100, '??????', '13054514427', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (79, 253729739636736, '?????????', '?????????', '?????????', '???96??????79???', 653800, '??????', '17086424371', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (80, 253729743831040, '?????????', '?????????', '?????????', '???48??????77???', 416400, '??????', '18230473378', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (81, 253729743831042, '?????????', '?????????', '?????????', '???52??????489???', 483500, '?????????', '17011666808', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (82, 253729752219648, '?????????', '?????????', '?????????', '???91??????119???', 62600, '?????????', '15857344089', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (83, 253729756413952, '?????????', '?????????', '?????????', '???33??????782???', 402500, '??????', '15186586495', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (84, 253729760608256, '?????????', '?????????', '?????????', '???50??????851???', 814900, '?????????', '13960326218', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (85, 253729760608256, '?????????', '?????????', '?????????', '???53??????222???', 558700, '?????????', '17199709786', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (86, 253729760608256, '?????????', '?????????', '?????????', '???72??????543???', 273700, '?????????', '17083599454', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (87, 253729764802560, '?????????', '?????????', '?????????', '???17??????16???', 405900, '??????', '15690022954', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (88, 253729768996864, '?????????', '?????????', '?????????', '???36??????475???', 72500, '?????????', '15106128023', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (89, 253729768996864, '?????????', '?????????', '?????????', '???9??????967???', 496400, '?????????', '15146845387', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (90, 253729768996866, '?????????', '?????????', '?????????', '???99??????805???', 765800, '?????????', '15168365359', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (91, 253729768996866, '?????????', '?????????', '?????????', '???99??????761???', 628400, '??????', '18086181003', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (92, 253729777385472, '?????????', '?????????', '?????????', '???90??????244???', 286400, '??????', '18743182140', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (93, 253729777385472, '?????????', '?????????', '?????????', '???43??????830???', 737600, '??????', '13495130524', NULL, '2021-09-01 17:08:21', '2021-09-01 17:08:21', NULL);
INSERT INTO `user_addresses` VALUES (94, 253729777385472, '?????????', '?????????', '?????????', '???69??????934???', 362100, '??????', '17057631974', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (95, 253729781579776, '?????????', '?????????', '?????????', '???74??????72???', 194700, '??????', '13227334542', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (96, 253729785774080, '?????????', '?????????', '?????????', '???33??????605???', 765100, '??????', '18621637399', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (97, 253729785774080, '?????????', '?????????', '?????????', '???42??????263???', 851500, '??????', '18596152660', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (98, 253729789968384, '?????????', '?????????', '?????????', '???86??????955???', 416300, '??????', '17804163045', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (99, 253729794162688, '?????????', '?????????', '?????????', '???62??????808???', 822700, '??????', '15910896627', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (100, 253729794162688, '?????????', '????????????', '?????????', '???2??????91???', 55300, '??????', '13681509602', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (101, 253729794162688, '?????????', '?????????', '?????????', '???90??????407???', 452200, '?????????', '15623729719', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (102, 253729798356992, '?????????', '????????????', '?????????', '???89??????967???', 237900, '??????', '17094077047', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (103, 253729798356994, '?????????', '?????????', '?????????', '???22??????977???', 522700, '??????', '17088996165', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (104, 253729798356994, '?????????', '?????????', '?????????', '???39??????282???', 717400, '?????????', '17184380069', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (105, 253729806745600, '?????????', '?????????', '?????????', '???9??????25???', 91100, '??????', '17697965321', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (106, 253729806745600, '?????????', '?????????', '?????????', '???85??????831???', 727000, '??????', '17877706131', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (107, 253729806745600, '?????????', '?????????', '?????????', '???47??????561???', 415200, '??????', '15525077905', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (108, 253729810939904, '?????????', '????????????', '?????????', '???33??????318???', 47700, '?????????', '18988270675', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (109, 253729810939904, '?????????', '????????????', '?????????', '???33??????423???', 551800, '??????', '18069676849', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (110, 253729810939904, '?????????', '?????????', '?????????', '???32??????25???', 801600, '?????????', '18042743138', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (111, 253729815134208, '?????????', '?????????', '?????????', '???0??????744???', 182000, '??????', '15017213047', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (112, 253729815134210, '?????????', '?????????', '?????????', '???65??????197???', 16600, '?????????', '15203264785', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (113, 253729815134210, '?????????', '?????????', '?????????', '???41??????527???', 154000, '?????????', '18746927830', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (114, 253729823522816, '?????????', '?????????', '?????????', '???29??????176???', 94700, '??????', '18561157797', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (115, 253729823522816, '?????????', '?????????', '?????????', '???44??????718???', 725800, '??????', '17621108282', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (116, 253729827717120, '?????????', '?????????', '?????????', '???27??????203???', 513400, '?????????', '15575127668', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (117, 253729827717120, '?????????', '?????????', '?????????', '???72??????514???', 506800, '??????', '15810051838', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (118, 253729831911424, '?????????', '????????????', '?????????', '???58??????383???', 232700, '??????', '18268630295', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (119, 253729836105728, '?????????', '????????????', '?????????', '???19??????510???', 678300, '??????', '15719416920', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (120, 253729836105728, '?????????', '????????????', '?????????', '???19??????717???', 606700, '?????????', '18015515652', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (121, 253729840300032, '?????????', '????????????', '?????????', '???55??????403???', 856100, '??????', '18142773854', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (122, 253729840300032, '?????????', '?????????', '?????????', '???34??????557???', 426500, '??????', '18504850783', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (123, 253729840300032, '?????????', '?????????', '?????????', '???62??????611???', 673800, '?????????', '17098207178', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (124, 253729844494336, '?????????', '?????????', '?????????', '???1??????852???', 276800, '??????', '14738855844', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (125, 253729844494336, '?????????', '?????????', '?????????', '???88??????570???', 573300, '?????????', '17016592450', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (126, 253729844494336, '?????????', '?????????', '?????????', '???9??????404???', 551800, '??????', '17046520760', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (127, 253729844494338, '?????????', '?????????', '?????????', '???79??????482???', 761300, '??????', '18848857917', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (128, 253729844494338, '?????????', '?????????', '?????????', '???26??????14???', 855900, '??????', '13328918126', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (129, 253729852882944, '?????????', '?????????', '?????????', '???86??????822???', 791200, '??????', '18566384928', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (130, 253729852882944, '?????????', '?????????', '?????????', '???38??????24???', 618600, '??????', '18796780877', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (131, 253729857077248, '?????????', '?????????', '?????????', '???88??????177???', 97800, '?????????', '17078149587', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (132, 253729857077248, '?????????', '?????????', '?????????', '???91??????204???', 727100, '??????', '14787007463', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (133, 253729857077248, '?????????', '????????????', '?????????', '???38??????653???', 738100, '?????????', '13466179155', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (134, 253729861271552, '?????????', '?????????', '?????????', '???57??????237???', 373900, '??????', '15685020074', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (135, 253729861271552, '?????????', '?????????', '?????????', '???32??????24???', 712000, '??????', '18452816522', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (136, 253729861271552, '?????????', '?????????', '?????????', '???31??????232???', 838200, '?????????', '18223129777', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (137, 253729861271554, '?????????', '?????????', '?????????', '???39??????743???', 785800, '?????????', '15006816840', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (138, 253729869660160, '?????????', '?????????', '?????????', '???76??????465???', 136000, '??????', '13562602598', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (139, 253729869660160, '?????????', '?????????', '?????????', '???39??????725???', 737000, '?????????', '15354239225', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (140, 253729869660160, '?????????', '?????????', '?????????', '???48??????151???', 517700, '?????????', '15397142433', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (141, 253729873854464, '?????????', '?????????', '?????????', '???39??????385???', 331800, '?????????', '18496937184', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (142, 253729878048768, '?????????', '?????????', '?????????', '???57??????727???', 536600, '?????????', '18711483736', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (143, 253729878048768, '?????????', '????????????', '?????????', '???13??????507???', 587500, '?????????', '15258505241', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (144, 253729878048768, '?????????', '????????????', '?????????', '???19??????503???', 28800, '??????', '17056954447', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (145, 253729882243072, '?????????', '?????????', '?????????', '???52??????141???', 401100, '??????', '17778077424', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (146, 253729882243072, '?????????', '?????????', '?????????', '???41??????307???', 13200, '??????', '17015458458', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (147, 253729882243072, '?????????', '?????????', '?????????', '???38??????370???', 28500, '?????????', '18432762761', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (148, 253729882243074, '?????????', '?????????', '?????????', '???58??????402???', 782300, '??????', '18329882997', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (149, 253729890631680, '?????????', '?????????', '?????????', '???39??????763???', 635400, '??????', '17073696860', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (150, 253729894825984, '?????????', '?????????', '?????????', '???28??????897???', 348200, '??????', '17868434570', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (151, 253729894825984, '?????????', '?????????', '?????????', '???97??????895???', 834800, '??????', '15750472639', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (152, 253729894825986, '?????????', '?????????', '?????????', '???3??????143???', 755100, '??????', '17839660046', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (153, 253729894825986, '?????????', '?????????', '?????????', '???49??????101???', 192500, '??????', '17014571145', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (154, 253729894825986, '?????????', '?????????', '?????????', '???91??????825???', 284300, '??????', '17080732117', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (155, 253729903214592, '?????????', '?????????', '?????????', '???32??????459???', 244400, '?????????', '17169379474', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (156, 253729907408896, '?????????', '?????????', '?????????', '???3??????205???', 454900, '??????', '15912091143', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (157, 253729907408896, '?????????', '?????????', '?????????', '???59??????479???', 678600, '??????', '17071912021', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (158, 253729907408896, '?????????', '?????????', '?????????', '???16??????820???', 682000, '??????', '18644669421', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (159, 253729911603200, '?????????', '?????????', '?????????', '???85??????664???', 91100, '?????????', '15222028996', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (160, 253729915797504, '?????????', '?????????', '?????????', '???40??????575???', 766400, '?????????', '13653413870', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (161, 253729915797504, '?????????', '????????????', '?????????', '???79??????521???', 385700, '?????????', '15954184185', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (162, 253729915797504, '?????????', '?????????', '?????????', '???64??????128???', 801100, '??????', '18703349032', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (163, 253729915797506, '?????????', '?????????', '?????????', '???9??????925???', 242600, '?????????', '18731349336', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (164, 253729924186112, '?????????', '?????????', '?????????', '???60??????668???', 15500, '??????', '18183225192', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (165, 253729924186112, '?????????', '????????????', '?????????', '???22??????625???', 447600, '??????', '15250715612', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (166, 253729928380416, '?????????', '?????????', '?????????', '???42??????61???', 134200, '??????', '18032548316', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (167, 253729928380416, '?????????', '?????????', '?????????', '???78??????662???', 21600, '?????????', '15295731179', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (168, 253729932574720, '?????????', '?????????', '?????????', '???32??????33???', 358500, '?????????', '17182726207', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (169, 253729932574720, '?????????', '?????????', '?????????', '???22??????335???', 494400, '??????', '18236410001', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (170, 253729932574720, '?????????', '?????????', '?????????', '???6??????225???', 717700, '?????????', '18636409593', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (171, 253729932574722, '?????????', '?????????', '?????????', '???65??????738???', 555900, '??????', '13259892059', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (172, 253729940963328, '?????????', '?????????', '?????????', '???33??????727???', 197900, '??????', '13866693441', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (173, 253729940963328, '?????????', '????????????', '?????????', '???19??????797???', 322000, '??????', '18609714267', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (174, 253729945157632, '?????????', '?????????', '?????????', '???99??????46???', 755600, '?????????', '13757974388', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (175, 253729945157632, '?????????', '?????????', '?????????', '???68??????641???', 151100, '?????????', '17086113248', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (176, 253729945157634, '?????????', '?????????', '?????????', '???8??????364???', 582500, '?????????', '18836949925', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (177, 253729945157634, '?????????', '?????????', '?????????', '???31??????337???', 346100, '?????????', '17013275046', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (178, 253729953546240, '?????????', '?????????', '?????????', '???54??????271???', 752700, '?????????', '15981725433', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (179, 253729953546240, '?????????', '?????????', '?????????', '???89??????634???', 428000, '??????', '13880555855', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (180, 253729957740544, '?????????', '?????????', '?????????', '???8??????137???', 693100, '?????????', '15842849816', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (181, 253729957740544, '?????????', '?????????', '?????????', '???69??????225???', 355800, '?????????', '13997428610', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (182, 253729957740544, '?????????', '?????????', '?????????', '???8??????869???', 846600, '?????????', '17197421322', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (183, 253729961934848, '?????????', '?????????', '?????????', '???6??????740???', 228200, '??????', '13028236273', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (184, 253729961934848, '?????????', '????????????', '?????????', '???48??????423???', 141100, '??????', '15206039398', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (185, 253729961934848, '?????????', '?????????', '?????????', '???35??????902???', 645500, '??????', '17059351187', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (186, 253729961934850, '?????????', '?????????', '?????????', '???76??????231???', 816500, '??????', '18996045719', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (187, 253729961934850, '?????????', '?????????', '?????????', '???31??????212???', 535400, '??????', '18617774221', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (188, 253729961934850, '?????????', '?????????', '?????????', '???83??????464???', 246500, '??????', '17088738887', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (189, 253729970323456, '?????????', '?????????', '?????????', '???65??????968???', 416200, '?????????', '13353546440', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (190, 253729970323456, '?????????', '?????????', '?????????', '???14??????389???', 666900, '?????????', '17191047981', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (191, 253729974517760, '?????????', '?????????', '?????????', '???20??????987???', 546100, '??????', '17070469194', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (192, 253729978712064, '?????????', '?????????', '?????????', '???67??????494???', 847700, '?????????', '15359610084', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (193, 253729978712066, '?????????', '?????????', '?????????', '???77??????258???', 344500, '?????????', '18322965515', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (194, 253729978712066, '?????????', '?????????', '?????????', '???9??????655???', 511000, '??????', '17124122913', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (195, 253729987100672, '?????????', '?????????', '?????????', '???37??????634???', 476900, '?????????', '18816891130', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (196, 253729987100672, '?????????', '?????????', '?????????', '???7??????836???', 697400, '??????', '13874704896', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (197, 253729987100672, '?????????', '?????????', '?????????', '???80??????774???', 744300, '??????', '15041050447', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (198, 253729991294976, '?????????', '?????????', '?????????', '???34??????936???', 742800, '?????????', '15593860334', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (199, 253729991294976, '?????????', '?????????', '?????????', '???45??????705???', 381600, '??????', '17656233730', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (200, 253729991294978, '?????????', '????????????', '?????????', '???82??????122???', 105700, '?????????', '17092250565', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (201, 253729991294978, '?????????', '?????????', '?????????', '???16??????190???', 637000, '?????????', '15155084829', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
INSERT INTO `user_addresses` VALUES (202, 253729999683584, '?????????', '?????????', '?????????', '???95??????170???', 44700, '?????????', '15784280975', NULL, '2021-09-01 17:08:22', '2021-09-01 17:08:22', NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_favorite_products
-- ----------------------------
DROP TABLE IF EXISTS `user_favorite_products`;
CREATE TABLE `user_favorite_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_favorite_products_product_id_foreign` (`product_id`),
  CONSTRAINT `user_favorite_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of user_favorite_products
-- ----------------------------
BEGIN;
INSERT INTO `user_favorite_products` VALUES (1, 601534471602176, 103, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (2, 601534471602176, 104, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (3, 601534471602176, 105, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (4, 601534471602176, 106, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (5, 601534513545216, 107, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (6, 601534513545216, 108, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (7, 601534517739520, 109, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (8, 601534517739520, 110, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (9, 601534517739520, 111, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (10, 601534517739520, 112, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (11, 601534526128128, 113, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (12, 601534526128128, 114, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (13, 601534526128128, 115, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (14, 601534530322432, 116, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (15, 601534530322432, 117, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (16, 601534530322432, 118, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (17, 601534530322432, 119, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (18, 601534534516736, 120, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (19, 601534534516736, 121, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (20, 601534534516736, 122, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (21, 601534534516736, 123, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (22, 601534538711040, 124, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (23, 601534538711040, 125, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (24, 601534538711040, 126, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (25, 601534538711040, 127, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (26, 601534538711040, 128, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (27, 601534542905344, 129, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (28, 601534542905344, 130, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (29, 601534542905344, 131, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (30, 601534542905344, 132, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (31, 601534542905346, 133, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (32, 601534542905346, 134, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (33, 601534542905346, 135, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (34, 601534551293952, 136, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (35, 601534551293952, 137, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (36, 601534551293952, 138, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (37, 601534555488256, 139, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (38, 601534563876864, 140, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (39, 601534563876864, 141, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (40, 601534572265472, 142, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (41, 601534572265472, 143, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (42, 601534572265472, 144, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (43, 601534580654080, 145, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (44, 601534580654080, 146, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (45, 601534580654080, 147, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (46, 601534580654080, 148, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (47, 601534584848384, 149, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (48, 601534584848384, 150, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (49, 601534584848384, 151, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (50, 236522779443200, 152, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (51, 236522779443200, 153, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (52, 236522779443200, 154, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (53, 236522779443200, 155, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (54, 236522779443200, 156, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (55, 236522779443200, 157, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (56, 236522779443200, 158, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (57, 236522779443200, 159, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (58, 236522779443200, 160, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (59, 236522779443200, 161, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (60, 236522779443200, 162, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (61, 236522779443200, 163, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (62, 236522779443200, 164, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (63, 236522779443200, 165, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (64, 236522779443200, 166, '2021-09-02 15:50:17', '2021-09-02 15:50:17');
INSERT INTO `user_favorite_products` VALUES (65, 236522779443200, 7, '2021-09-08 12:35:19', '2021-09-08 12:35:19');
COMMIT;

-- ----------------------------
-- Table structure for user_has_coupons
-- ----------------------------
DROP TABLE IF EXISTS `user_has_coupons`;
CREATE TABLE `user_has_coupons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `coupon_id` bigint(20) unsigned NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0' COMMENT '?????????????????????????????????',
  `order_id` bigint(20) DEFAULT NULL COMMENT '???????????????',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_has_coupons_coupon_id_foreign` (`coupon_id`),
  CONSTRAINT `user_has_coupons_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of user_has_coupons
-- ----------------------------
BEGIN;
INSERT INTO `user_has_coupons` VALUES (1, 236522779443200, 1, 0, NULL, '2021-09-05 20:38:05', '2021-09-05 20:38:05');
INSERT INTO `user_has_coupons` VALUES (2, 236522779443200, 2, 0, NULL, '2021-09-05 20:38:15', '2021-09-05 20:38:15');
INSERT INTO `user_has_coupons` VALUES (3, 236522779443200, 3, 1, 2386304348192769, '2021-09-05 20:38:17', '2021-09-05 20:38:17');
INSERT INTO `user_has_coupons` VALUES (4, 236522779443200, 4, 1, 2396162871001088, '2021-09-05 20:38:21', '2021-09-05 20:38:21');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '??????ID',
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '?????????',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notification_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '???????????????',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_id_unique` (`user_id`),
  UNIQUE KEY `users_phone_unique` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (1, 236522779443200, '13566554897', 'boy_GwNyX', NULL, NULL, '$2y$10$5dFCPZUpp5awOa0AqDZhne7TjJ9dBZgg3tioeeWqToAZEzBC.Jniu', 2, NULL, '2021-09-01 15:39:51', '2021-09-09 15:05:23', NULL);
INSERT INTO `users` VALUES (2, 253729546698752, '17014416946', '??????', 'enim.sapiente@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'xFyvognCwE', '2021-09-01 16:48:13', '2021-09-01 16:48:13', NULL);
INSERT INTO `users` VALUES (3, 253729584447488, '18343775711', '??????', 'consectetur99@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'BB9zP3DFHt', '2021-09-01 16:48:13', '2021-09-01 16:48:13', NULL);
INSERT INTO `users` VALUES (4, 253729592836096, '17012597851', '?????????', 'dconsequatur@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'NhxxqhrXCV', '2021-09-01 16:48:13', '2021-09-01 16:48:13', NULL);
INSERT INTO `users` VALUES (5, 253729597030400, '15327973617', '?????????', 'ecorporis@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'RMAiJJM4tj', '2021-09-01 16:48:13', '2021-09-01 16:48:13', NULL);
INSERT INTO `users` VALUES (6, 253729597030402, '18751866203', '?????????', 'cprovident@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'v5Fewy56ZH', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (7, 253729605419008, '13082655855', '??????', 'est.vel@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'GW3h66wlT4', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (8, 253729609613312, '17195503011', '??????', 'quia.quae@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'cQobM1heZx', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (9, 253729613807616, '15737635011', '?????????', 'tdelectus@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'AQ7pxjiaRz', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (10, 253729618001920, '13135891028', '??????', 'ma@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'TDbS4DnqZF', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (11, 253729622196224, '17700293854', '?????????', 'dolorum99@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'mtJOL6etrZ', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (12, 253729626390528, '18675303941', '?????????', 'voluptatem.nihil@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'tlJbjWgh4s', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (13, 253729630584832, '14738855274', '?????????', 'saepe.ut@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '58P85BrYTq', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (14, 253729634779136, '17134847958', '??????', 'optio.nesciunt@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '0ZUsd68uek', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (15, 253729638973440, '13048681816', '??????', 'ut.consequatur@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'UL9YHbuPIb', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (16, 253729643167744, '18743086552', '?????????', 'nobis_omnis@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'S3hE6rt5Hi', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (17, 253729647362048, '13379538181', '??????', 'enim.ratione@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'aepN9wmuZ8', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (18, 253729647362050, '13117136504', '??????', 'nesciunt_suscipit@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'zsmxQ2DPNG', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (19, 253729655750656, '17097040659', '?????????', 'esse_ratione@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'Bn1vj7SyVG', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (20, 253729659944960, '13685255664', '??????', 'qui.accusantium@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'qDabbLL3Eh', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (21, 253729664139264, '17100221184', '?????????', 'aut25@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'I2C79vba1G', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (22, 253729668333568, '18539251154', '?????????', 'accusamus74@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'fJs2zAjOu2', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (23, 253729668333570, '15718630735', '??????', 'zrerum@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'zUtUhUxJh4', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (24, 253729676722176, '17175359727', '?????????', 'voluptatem_maiores@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'wA2lcnGdhc', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (25, 253729680916480, '17077393110', '??????', 'zincidunt@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'jSIuQOCXJe', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (26, 253729685110784, '13730201580', '?????????', 'iste.vero@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'vIHXEb8SJ7', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (27, 253729689305088, '13517091483', '??????', 'rerum_voluptate@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'Gi0WhgZ3YV', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (28, 253729693499392, '15255095213', '??????', 'bsaepe@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'oPtn0KrSxk', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (29, 253729697693696, '17878173330', '??????', 'officiis35@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'zmh0reDvoO', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (30, 253729697693698, '13841402925', '?????????', 'quidem13@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'j1lJVk6sAD', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (31, 253729706082304, '17099641662', '??????', 'perferendis_consequatur@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'TT8wnEwbyg', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (32, 253729710276608, '13102652809', '?????????', 'quas_exercitationem@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'm7h9Uoy9Iq', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (33, 253729714470912, '18854693515', '??????', 'sunt47@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'DxJl18NjSe', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (34, 253729718665216, '17099023912', '??????', 'labore.placeat@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'WPqNDJQwL6', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (35, 253729718665218, '18923678371', '??????', 'uesse@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'ZecezQn1G8', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (36, 253729727053824, '18792225825', '?????????', 'temporibus.id@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '0MZb55YzdQ', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (37, 253729731248128, '18517272688', '??????', 'ut92@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'Y3gCynv5LI', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (38, 253729735442432, '18356444122', '??????', 'est.omnis@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'l3M2xN4Mft', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (39, 253729739636736, '17188339548', '??????', 'pariatur93@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'Z6CzPHHr3V', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (40, 253729743831040, '18555348937', '??????', 'qui.sunt@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'u64ifbaf1m', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (41, 253729743831042, '17000373325', '??????', 'accusamus57@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'gunRKDENiH', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (42, 253729752219648, '17001479522', '?????????', 'consequatur_distinctio@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'W5Rw69lDpP', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (43, 253729756413952, '13365537450', '?????????', 'dolore01@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'BVsW6EJarT', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (44, 253729760608256, '13598360199', '?????????', 'omnis.iusto@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'tx0TqEIORw', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (45, 253729764802560, '18048781876', '?????????', 'ut_suscipit@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'k8E0UGrZGn', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (46, 253729768996864, '18110414972', '?????????', 'pariatur11@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'ndKANSSRRG', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (47, 253729768996866, '18183168449', '??????', 'autem11@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '0RQtNA2Y8L', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (48, 253729777385472, '17083429052', '?????????', 'enim78@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'Uj8veo9iL2', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (49, 253729781579776, '17000476417', '?????????', 'nostrum55@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'd5zpJSus5J', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (50, 253729785774080, '17882203648', '??????', 'ut.et@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'i3M1V0Mmdv', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (51, 253729789968384, '18832119695', '??????', 'mquos@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'CFlcAgdd0G', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (52, 253729794162688, '14583483169', '??????', 'voluptatum58@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'r7GIHwykZd', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (53, 253729798356992, '15707180444', '??????', 'hnon@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'BPPLsO3onb', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (54, 253729798356994, '17181491203', '??????', 'nihil.voluptas@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'kZa13KwtSA', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (55, 253729806745600, '13704611345', '??????', 'ab_qui@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'M8eNSTrbBn', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (56, 253729810939904, '13295728049', '??????', 'ea38@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'YmMB1ngr9C', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (57, 253729815134208, '13323303253', '?????????', 'dolor_qui@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'zFHI6jLajf', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (58, 253729815134210, '15210529541', '??????', 'est81@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '3C1tLl2ONk', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (59, 253729823522816, '17889148935', '??????', 'dut@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '2UAFZiSzPF', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (60, 253729827717120, '15346491013', '??????', 'sunt_quod@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'b0M0NUr8lK', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (61, 253729831911424, '15319180879', '??????', 'noptio@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'sSAf7OYuYK', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (62, 253729836105728, '18819419606', '?????????', 'qui_repellat@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'hA1CRcEf76', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (63, 253729840300032, '18459288222', '?????????', 'quam_dolor@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '1yZ9bmeGc4', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (64, 253729844494336, '18578472547', '?????????', 'qui84@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'sbggwEG8ip', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (65, 253729844494338, '13851116911', '??????', 'sit53@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'XC50uP2KoH', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (66, 253729852882944, '13092826591', '?????????', 'ut03@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'xhWJM8G9Gg', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (67, 253729857077248, '17092144959', '?????????', 'omnis.quod@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'FDkzPRofQB', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (68, 253729861271552, '13441302569', '?????????', 'sint96@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'KCmSpCJh5a', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (69, 253729861271554, '14516263968', '?????????', 'excepturi_omnis@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '9q7AdstArs', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (70, 253729869660160, '18364682014', '??????', 'unde_cumque@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'hLiV0UGXUm', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (71, 253729873854464, '18114918007', '?????????', 'at_et@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'JOTuODaotD', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (72, 253729878048768, '18013105663', '??????', 'but@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'iWC7rtueuk', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (73, 253729882243072, '17074239551', '??????', 'impedit14@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '1IpYLKdEc0', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (74, 253729882243074, '15622887628', '??????', 'omnis.alias@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'JKoBCH337R', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (75, 253729890631680, '13875816091', '?????????', 'zprovident@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'f43IuC3Yww', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (76, 253729894825984, '17871128753', '??????', 'accusamus.nesciunt@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '4XZf6eHxc8', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (77, 253729894825986, '15241102693', '??????', 'sed.aut@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'KZUygPzwhd', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (78, 253729903214592, '18789364521', '?????????', 'did@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'mqlrfdLVBT', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (79, 253729907408896, '14756254251', '?????????', 'accusantium_sequi@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '5f3b3qDPS2', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (80, 253729911603200, '13539110348', '?????????', 'eet@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'SlHjT4yK6d', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (81, 253729915797504, '15799267454', '??????', 'vsuscipit@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '9pIATpbf58', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (82, 253729915797506, '18085107782', '??????', 'veniam_nesciunt@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'b4sBOEcOFn', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (83, 253729924186112, '18367119114', '?????????', 'cquod@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'P7cN4PIemE', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (84, 253729928380416, '15226218229', '??????', 'ipsum.nihil@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'BRuhHT34k2', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (85, 253729932574720, '13442831945', '?????????', 'accusamus_rerum@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'Y7b1ktWjdp', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (86, 253729932574722, '15698881328', '?????????', 'voluptatem.ut@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'YuzuAXZO6a', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (87, 253729940963328, '13899668020', '??????', 'ivero@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '1KjVJOhhlW', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (88, 253729945157632, '18307320345', '??????', 'jvel@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'lA9uBuPMX2', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (89, 253729945157634, '18930769092', '?????????', 'nulla.quo@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'hCWl4GiePc', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (90, 253729953546240, '13913766309', '?????????', 'voluptatem_tempore@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '5nDnTnDjld', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (91, 253729957740544, '15683393331', '??????', 'similique37@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'ejvbYafJ8I', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (92, 253729961934848, '15523559760', '?????????', 'qui46@example.net', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'wPmiCVWFEQ', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (93, 253729961934850, '13243658828', '??????', 'delectus.voluptas@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'p7o2nme9by', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (94, 253729970323456, '13665025731', '?????????', 'optio85@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'kSV6iJJZ7h', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (95, 253729974517760, '17777710150', '??????', 'magnam.totam@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '8n4RisxjIQ', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (96, 253729978712064, '17190949182', '?????????', 'kassumenda@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '5ISVp2FA2q', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (97, 253729978712066, '15507596059', '??????', 'sunt.molestiae@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'QCzjkr5hCk', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (98, 253729987100672, '13416301081', '??????', 'fuga.animi@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'EqtVEr7KHT', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (99, 253729991294976, '15259114475', '?????????', 'et.id@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'PR5HeTy66w', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (100, 253729991294978, '13032527592', '??????', 'qui.voluptatem@example.com', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'bPNLIK0sbq', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (101, 253729999683584, '15299816720', '?????????', 'et70@example.org', '2021-09-01 16:48:13', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'srIYs4ZdMM', '2021-09-01 16:48:14', '2021-09-01 16:48:14', NULL);
INSERT INTO `users` VALUES (102, 600727604953088, '17675944635', '?????????', 'magni.pariatur@example.com', '2021-09-02 15:47:04', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'VlXrKQEGBK', '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL);
INSERT INTO `users` VALUES (103, 600727655284736, '18048631822', '?????????', 'aut32@example.com', '2021-09-02 15:47:04', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'hnXefXzX6n', '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL);
INSERT INTO `users` VALUES (104, 600727663673344, '14545278651', '??????', 'consequatur_odit@example.net', '2021-09-02 15:47:04', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'hqwXURXDbe', '2021-09-02 15:47:04', '2021-09-02 15:47:04', NULL);
INSERT INTO `users` VALUES (105, 600952377704448, '13360670711', '??????', 'error23@example.com', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '8wd1wKdylN', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (106, 600952419647488, '17814602296', '??????', 'accusamus_nam@example.org', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'o6ioQIvYao', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (107, 600952423841792, '15383913879', '??????', 'ipsum_repellendus@example.org', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'dbjRosAfNq', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (108, 600952432230400, '13282180632', '??????', 'et.qui@example.org', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'WP5T0Cqr6e', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (109, 600952436424704, '13575469649', '??????', 'fuga49@example.net', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'P8UqmqmclF', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (110, 600952440619008, '15296602133', '??????', 'kcorporis@example.org', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'dmSoJB2qtc', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (111, 600952444813312, '17897807361', '?????????', 'nam.vel@example.com', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'MZJLOiVgSf', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (112, 600952449007616, '15642056713', '?????????', 'labore02@example.net', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'AMxt6VGnLL', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (113, 600952453201920, '15743440364', '?????????', 'put@example.org', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'EMDw67Z9ju', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (114, 600952457396224, '15649545189', '?????????', 'magnam.laudantium@example.org', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'ghezAodKYD', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (115, 600952461590528, '17122126820', '??????', 'asperiores_veritatis@example.org', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'Vg8oJ5kJM3', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (116, 600952469979136, '13304909486', '??????', 'soluta.blanditiis@example.org', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'RdI3szGaTJ', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (117, 600952474173440, '15334099069', '??????', 'consequuntur.facere@example.org', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'kkldibGq3W', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (118, 600952478367744, '17016224053', '?????????', 'minima86@example.net', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'B48NtFgKt9', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (119, 600952482562048, '18342064598', '??????', 'kprovident@example.org', '2021-09-02 15:47:58', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '01Sh9024Ba', '2021-09-02 15:47:58', '2021-09-02 15:47:58', NULL);
INSERT INTO `users` VALUES (120, 601534471602176, '13440771795', '?????????', 'sofficiis@example.com', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'fpZoua769P', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (121, 601534513545216, '17013072882', '?????????', 'tempore_sint@example.net', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'pUJWoCeDm0', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (122, 601534517739520, '18321398055', '??????', 'dolorum_harum@example.com', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'ZVAzh2dlQo', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (123, 601534526128128, '18537033339', '?????????', 'qtempore@example.com', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'UitT8W0yGa', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (124, 601534530322432, '13409186069', '?????????', 'eos.quaerat@example.net', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'jWRMHStGvo', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (125, 601534534516736, '17193777884', '??????', 'reprehenderit_veritatis@example.net', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'ZCQbxpINF8', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (126, 601534538711040, '14587482490', '?????????', 'fomnis@example.org', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, '4zScfh5zDH', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (127, 601534542905344, '13781598957', '??????', 'fqui@example.com', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'S8DBiFHxs3', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (128, 601534542905346, '15517608509', '??????', 'rem.aperiam@example.com', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'woFxF2I7yW', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (129, 601534551293952, '13671342197', '??????', 'oexcepturi@example.com', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'I6VWvOZAlL', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (130, 601534555488256, '13090447369', '?????????', 'qaut@example.net', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'G0E38igDFF', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (131, 601534563876864, '15809254720', '?????????', 'kab@example.org', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'RJmSYmesfj', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (132, 601534572265472, '13353896509', '??????', 'dicta_impedit@example.net', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'WVRrCyCB0f', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (133, 601534580654080, '17096851297', '??????', 'mamet@example.net', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'yUF8XgPUeX', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
INSERT INTO `users` VALUES (134, 601534584848384, '18736423152', '??????', 'ieveniet@example.net', '2021-09-02 15:50:17', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 0, 'ZLO6fK0reY', '2021-09-02 15:50:17', '2021-09-02 15:50:17', NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
