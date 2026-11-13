CREATE DATABASE  IF NOT EXISTS `shopman` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shopman`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: shopman
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tblcart2`
--

DROP TABLE IF EXISTS `tblcart2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcart2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customerId` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customerId` (`customerId`),
  CONSTRAINT `fk_cart_customer` FOREIGN KEY (`customerId`) REFERENCES `tblcustomer2` (`tblUserId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcart2`
--

LOCK TABLES `tblcart2` WRITE;
/*!40000 ALTER TABLE `tblcart2` DISABLE KEYS */;
INSERT INTO `tblcart2` VALUES (1,3),(2,4),(8,10),(9,11),(12,14),(13,15),(14,16);
/*!40000 ALTER TABLE `tblcart2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcartdetail2`
--

DROP TABLE IF EXISTS `tblcartdetail2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcartdetail2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderQuantity` int DEFAULT '1',
  `cartId` int NOT NULL,
  `itemId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cartdetail_cart` (`cartId`),
  KEY `fk_cartdetail_item` (`itemId`),
  CONSTRAINT `fk_cartdetail_cart` FOREIGN KEY (`cartId`) REFERENCES `tblcart2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cartdetail_item` FOREIGN KEY (`itemId`) REFERENCES `tblitem2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcartdetail2`
--

LOCK TABLES `tblcartdetail2` WRITE;
/*!40000 ALTER TABLE `tblcartdetail2` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcartdetail2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcustomer2`
--

DROP TABLE IF EXISTS `tblcustomer2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcustomer2` (
  `tblUserId` int NOT NULL,
  PRIMARY KEY (`tblUserId`),
  CONSTRAINT `fk_customer_user` FOREIGN KEY (`tblUserId`) REFERENCES `tbluser2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcustomer2`
--

LOCK TABLES `tblcustomer2` WRITE;
/*!40000 ALTER TABLE `tblcustomer2` DISABLE KEYS */;
INSERT INTO `tblcustomer2` VALUES (3),(4),(10),(11),(14),(15),(16);
/*!40000 ALTER TABLE `tblcustomer2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldeliveryagent2`
--

DROP TABLE IF EXISTS `tbldeliveryagent2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldeliveryagent2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldeliveryagent2`
--

LOCK TABLES `tbldeliveryagent2` WRITE;
/*!40000 ALTER TABLE `tbldeliveryagent2` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbldeliveryagent2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblimportinvoice2`
--

DROP TABLE IF EXISTS `tblimportinvoice2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblimportinvoice2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `importDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `managerId` int NOT NULL,
  `supplierId` int NOT NULL,
  `paymentId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_import_manager` (`managerId`),
  KEY `fk_import_supplier` (`supplierId`),
  KEY `fk_import_payment` (`paymentId`),
  CONSTRAINT `fk_import_manager` FOREIGN KEY (`managerId`) REFERENCES `tblmanager2` (`tblUserId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_import_payment` FOREIGN KEY (`paymentId`) REFERENCES `tblpayment2` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_import_supplier` FOREIGN KEY (`supplierId`) REFERENCES `tblsupplier2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblimportinvoice2`
--

LOCK TABLES `tblimportinvoice2` WRITE;
/*!40000 ALTER TABLE `tblimportinvoice2` DISABLE KEYS */;
INSERT INTO `tblimportinvoice2` VALUES (4,'2026-11-12 09:18:30',1,1,4),(5,'2026-11-12 17:02:26',1,1,NULL),(6,'2026-11-12 17:20:22',1,2,6),(7,'2026-11-12 17:45:17',1,1,7),(8,'2026-11-12 18:27:00',1,1,8),(9,'2026-11-12 18:28:58',1,1,9),(10,'2026-11-12 18:31:49',1,1,10),(11,'2026-11-12 18:38:22',1,1,11),(12,'2026-11-12 20:50:06',1,1,12),(13,'2026-11-12 21:51:25',1,1,13),(14,'2026-11-12 22:30:31',1,1,14),(15,'2026-11-12 22:45:50',1,2,15),(16,'2026-11-12 23:26:38',1,1,16);
/*!40000 ALTER TABLE `tblimportinvoice2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblimportinvoicedetail2`
--

DROP TABLE IF EXISTS `tblimportinvoicedetail2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblimportinvoicedetail2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `importQuantity` int DEFAULT '1',
  `importInvoiceId` int NOT NULL,
  `itemId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_importdetail_invoice` (`importInvoiceId`),
  KEY `fk_importdetail_item` (`itemId`),
  CONSTRAINT `fk_importdetail_invoice` FOREIGN KEY (`importInvoiceId`) REFERENCES `tblimportinvoice2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_importdetail_item` FOREIGN KEY (`itemId`) REFERENCES `tblitem2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblimportinvoicedetail2`
--

LOCK TABLES `tblimportinvoicedetail2` WRITE;
/*!40000 ALTER TABLE `tblimportinvoicedetail2` DISABLE KEYS */;
INSERT INTO `tblimportinvoicedetail2` VALUES (5,10,4,1),(6,10,4,2),(7,10,5,2),(8,10,5,1),(9,10,6,3),(10,10,7,1),(11,10,8,1),(12,10,9,2),(13,10,10,2),(14,10,11,2),(15,19,11,1),(16,10,12,2),(17,10,13,1),(18,10,13,2),(19,10,13,3),(20,10,14,3),(21,10,15,2),(22,10,15,1),(23,10,16,1),(24,10,16,2);
/*!40000 ALTER TABLE `tblimportinvoicedetail2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblitem2`
--

DROP TABLE IF EXISTS `tblitem2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblitem2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int DEFAULT '0',
  `sellingPrice` int DEFAULT '0',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'default_item.jpg',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblitem2`
--

LOCK TABLES `tblitem2` WRITE;
/*!40000 ALTER TABLE `tblitem2` DISABLE KEYS */;
INSERT INTO `tblitem2` VALUES (1,'Áo thun A','Trang phục','Tay ngắn, chất liệu cotton','Cái',170,200000,'ao_thun_a.jpg'),(2,'Áo thun B','Trang phục','Tay ngắn, chất liệu polyester','Cái',160,150000,'ao_thun_b.jpg'),(3,'Áo thun C','Trang phục','Mát mẻ, mỏng','Cái',70,180000,'ao_thun_c.jpg');
/*!40000 ALTER TABLE `tblitem2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmanager2`
--

DROP TABLE IF EXISTS `tblmanager2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmanager2` (
  `tblUserId` int NOT NULL,
  PRIMARY KEY (`tblUserId`),
  CONSTRAINT `fk_manager_staff` FOREIGN KEY (`tblUserId`) REFERENCES `tblstaff2` (`tblUserId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmanager2`
--

LOCK TABLES `tblmanager2` WRITE;
/*!40000 ALTER TABLE `tblmanager2` DISABLE KEYS */;
INSERT INTO `tblmanager2` VALUES (1);
/*!40000 ALTER TABLE `tblmanager2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblorder2`
--

DROP TABLE IF EXISTS `tblorder2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblorder2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sellerId` int DEFAULT NULL,
  `customerId` int NOT NULL,
  `paymentId` int DEFAULT NULL,
  `deliveryAgentId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_seller` (`sellerId`),
  KEY `fk_order_customer` (`customerId`),
  KEY `fk_order_payment` (`paymentId`),
  KEY `fk_order_delivery` (`deliveryAgentId`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`customerId`) REFERENCES `tblcustomer2` (`tblUserId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_delivery` FOREIGN KEY (`deliveryAgentId`) REFERENCES `tbldeliveryagent2` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_order_payment` FOREIGN KEY (`paymentId`) REFERENCES `tblpayment2` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_order_seller` FOREIGN KEY (`sellerId`) REFERENCES `tblseller2` (`tblUserId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblorder2`
--

LOCK TABLES `tblorder2` WRITE;
/*!40000 ALTER TABLE `tblorder2` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblorder2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblorderdetail2`
--

DROP TABLE IF EXISTS `tblorderdetail2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblorderdetail2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderQuantity` int DEFAULT '1',
  `orderId` int NOT NULL,
  `itemId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orderdetail_order` (`orderId`),
  KEY `fk_orderdetail_item` (`itemId`),
  CONSTRAINT `fk_orderdetail_item` FOREIGN KEY (`itemId`) REFERENCES `tblitem2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orderdetail_order` FOREIGN KEY (`orderId`) REFERENCES `tblorder2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblorderdetail2`
--

LOCK TABLES `tblorderdetail2` WRITE;
/*!40000 ALTER TABLE `tblorderdetail2` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblorderdetail2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpayment2`
--

DROP TABLE IF EXISTS `tblpayment2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpayment2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `paymentDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `amount` int DEFAULT '0',
  `paymentMethod` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpayment2`
--

LOCK TABLES `tblpayment2` WRITE;
/*!40000 ALTER TABLE `tblpayment2` DISABLE KEYS */;
INSERT INTO `tblpayment2` VALUES (1,'2026-11-12 08:50:00',0,'Tiền mặt','Đã thanh toán'),(2,'2026-11-12 09:13:48',2650000,'Chuyển khoản','Đã thanh toán'),(3,'2026-11-12 09:16:48',6000000,'Chuyển khoản','Đã thanh toán'),(4,'2026-11-12 09:18:46',2500000,'Chuyển khoản','Đã thanh toán'),(6,'2026-11-12 17:28:09',1200000,'Chuyển khoản','Đã thanh toán'),(7,'2026-11-12 17:45:22',1500000,'Chuyển khoản','Đã thanh toán'),(8,'2026-11-12 18:27:03',1500000,'Chuyển khoản','Đã thanh toán'),(9,'2026-11-12 18:29:01',1000000,'Chuyển khoản','Đã thanh toán'),(10,'2026-11-12 18:31:51',1000000,'Chuyển khoản','Đã thanh toán'),(11,'2026-11-12 18:38:25',3850000,'Chuyển khoản','Đã thanh toán'),(12,'2026-11-12 20:50:08',1000000,'Chuyển khoản','Đã thanh toán'),(13,'2026-11-12 21:51:30',81405000,'Chuyển khoản','Đã thanh toán'),(14,'2026-11-12 22:30:34',78905000,'Chuyển khoản','Đã thanh toán'),(15,'2026-11-12 22:45:54',2500000,'Chuyển khoản','Đã thanh toán'),(16,'2026-11-12 23:27:22',2500000,'Chuyển khoản','Đã thanh toán');
/*!40000 ALTER TABLE `tblpayment2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblseller2`
--

DROP TABLE IF EXISTS `tblseller2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblseller2` (
  `tblUserId` int NOT NULL,
  PRIMARY KEY (`tblUserId`),
  CONSTRAINT `fk_seller_staff` FOREIGN KEY (`tblUserId`) REFERENCES `tblstaff2` (`tblUserId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblseller2`
--

LOCK TABLES `tblseller2` WRITE;
/*!40000 ALTER TABLE `tblseller2` DISABLE KEYS */;
INSERT INTO `tblseller2` VALUES (2);
/*!40000 ALTER TABLE `tblseller2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblstaff2`
--

DROP TABLE IF EXISTS `tblstaff2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblstaff2` (
  `tblUserId` int NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`tblUserId`),
  CONSTRAINT `fk_staff_user` FOREIGN KEY (`tblUserId`) REFERENCES `tbluser2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblstaff2`
--

LOCK TABLES `tblstaff2` WRITE;
/*!40000 ALTER TABLE `tblstaff2` DISABLE KEYS */;
INSERT INTO `tblstaff2` VALUES (1,'Manager'),(2,'Seller');
/*!40000 ALTER TABLE `tblstaff2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsupplier2`
--

DROP TABLE IF EXISTS `tblsupplier2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsupplier2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsupplier2`
--

LOCK TABLES `tblsupplier2` WRITE;
/*!40000 ALTER TABLE `tblsupplier2` DISABLE KEYS */;
INSERT INTO `tblsupplier2` VALUES (1,'Công ty quần áo Aristino','123 Giải Phóng, Hà Nội','0123456789','abc@gmail.com','Nhà cung cấp thời trang nam'),(2,'Công ty quần áo 160Store','345 Trần Phú, Hà Nội','0987654321','efg@gmail.com','Chuyên đồ nam trẻ trung'),(3,'ABC','egegeg','1234567890','levietkien2k5@gmail.com','gerh'),(4,'ABD','thttf','1234567444','levietkien2k4@gmail.com','gerh'),(5,'Lê Viết Kiên','thttf','1234567444','levietkien2k4@gmail.com','gerh');
/*!40000 ALTER TABLE `tblsupplier2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsupplieritem2`
--

DROP TABLE IF EXISTS `tblsupplieritem2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsupplieritem2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `importPrice` int DEFAULT '0',
  `minImportQuantity` int DEFAULT '1',
  `supplierId` int NOT NULL,
  `itemId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_supplieritem_supplier` (`supplierId`),
  KEY `fk_supplieritem_item` (`itemId`),
  CONSTRAINT `fk_supplieritem_item` FOREIGN KEY (`itemId`) REFERENCES `tblitem2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_supplieritem_supplier` FOREIGN KEY (`supplierId`) REFERENCES `tblsupplier2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsupplieritem2`
--

LOCK TABLES `tblsupplieritem2` WRITE;
/*!40000 ALTER TABLE `tblsupplieritem2` DISABLE KEYS */;
INSERT INTO `tblsupplieritem2` VALUES (1,150000,10,1,1),(2,100000,10,1,2),(3,120000,10,2,3),(6,100000,10,3,1),(7,150000,10,2,1),(8,7890500,10,1,3),(9,100000,10,2,2);
/*!40000 ALTER TABLE `tblsupplieritem2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbluser2`
--

DROP TABLE IF EXISTS `tbluser2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbluser2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateOfBirth` datetime DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userName` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbluser2`
--

LOCK TABLES `tbluser2` WRITE;
/*!40000 ALTER TABLE `tbluser2` DISABLE KEYS */;
INSERT INTO `tbluser2` VALUES (1,'Trần Quản Lý','1990-05-15 00:00:00','0912345678','manager@shopman.com','manager01','12345678'),(2,'Nguyễn Bán Hàng','1995-10-20 00:00:00','0987654321','seller@shopman.com','seller01','12345678'),(3,'Nguyễn Văn An','2005-01-01 00:00:00','0123456789','annv@gmail.com','NVA123','12345678'),(4,'Kiên Lê','2005-01-26 17:00:00','9876509876','levietkien2k5@gmail.com','levietkien','123456789'),(10,'ABC','2026-11-05 17:00:00','1234567890','levietkien2k5@gmail.com','nguyenvanc','123456789'),(11,'ABC','2026-11-05 17:00:00','1234567890','levietkien2k5@gmail.com','nguyenvana','123456789'),(14,'Lê Viết Kiên','2005-01-27 00:00:00','1234567890','levietkien2k5@gmail.com','kienlee','1234567890'),(15,'Lê Viết Kiên','2005-01-27 00:00:00','1234567890','levietkien2k5@gmail.com','kienle','123456789'),(16,'ABC','2004-03-31 00:00:00','1234567890','levietkien2k5@gmail.com','Kienn','12345678');
/*!40000 ALTER TABLE `tbluser2` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-13  8:21:36
