CREATE DATABASE  IF NOT EXISTS `develop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `develop`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: develop
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipCode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `street` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `complement` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `neighborhood` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Customer_email_key` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1,'Alana Renata Marlene da Cunha','alanare@tglaw.com.br','31996543973','06133318694','32071152','Rua Alexandrita','274','','Sapucaia II','Contagem','MG','2023-07-20 15:17:07.456','2023-07-20 15:17:07.456'),(2,'Usuário 1','usuario1@example.com','111111111','11111111111','12345678','Rua A','123','','Bairro 1','Cidade 1','UF','2023-07-20 22:39:38.000','2023-07-20 22:39:38.000'),(3,'Usuário 2','usuario2@example.com','222222222','22222222222','87654321','Rua B','456','','Bairro 2','Cidade 2','UF','2023-07-20 22:39:38.000','2023-07-20 22:39:38.000');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order`
--

DROP TABLE IF EXISTS `Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` enum('PENDING','PAID','CANCELED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `total` decimal(10,2) NOT NULL,
  `transactionId` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `customerId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Order_customerId_fkey` (`customerId`),
  CONSTRAINT `Order_customerId_fkey` FOREIGN KEY (`customerId`) REFERENCES `Customer` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order`
--

LOCK TABLES `Order` WRITE;
/*!40000 ALTER TABLE `Order` DISABLE KEYS */;
INSERT INTO `Order` VALUES (1,'PAID',108.00,'pay_0585217298235874','2023-07-20 15:17:07.472','2023-07-20 15:17:08.762',1),(2,'PAID',25.50,'pay_123456789','2023-07-19 15:17:07.472','2023-07-20 22:40:14.000',1),(3,'PAID',47.00,'pay_987654321','2023-07-18 15:17:07.472','2023-07-20 22:40:14.000',1),(4,'PAID',12.00,'pay_111111111','2023-06-20 15:17:07.472','2023-07-20 22:40:14.000',1),(5,'PAID',60.00,'pay_222222222','2023-06-19 15:17:07.472','2023-07-20 22:40:14.000',2),(6,'PAID',30.00,'pay_333333333','2023-06-18 15:17:07.472','2023-07-20 22:40:14.000',2),(7,'PAID',26.00,'pay_444444444','2023-05-20 15:17:07.472','2023-07-20 22:40:14.000',2),(8,'PAID',8.00,'pay_555555555','2023-05-19 15:17:07.472','2023-07-20 22:40:14.000',1),(9,'PAID',24.00,'pay_666666666','2023-05-18 15:17:07.472','2023-07-20 22:40:14.000',2),(10,'PAID',12.00,'pay_777777777','2023-04-20 15:17:07.472','2023-07-20 22:40:14.000',1);
/*!40000 ALTER TABLE `Order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrderItem`
--

DROP TABLE IF EXISTS `OrderItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OrderItem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL DEFAULT '0',
  `subTotal` decimal(10,2) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `orderId` int NOT NULL,
  `snackId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `OrderItem_orderId_fkey` (`orderId`),
  KEY `OrderItem_snackId_fkey` (`snackId`),
  CONSTRAINT `OrderItem_orderId_fkey` FOREIGN KEY (`orderId`) REFERENCES `Order` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `OrderItem_snackId_fkey` FOREIGN KEY (`snackId`) REFERENCES `Snack` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderItem`
--

LOCK TABLES `OrderItem` WRITE;
/*!40000 ALTER TABLE `OrderItem` DISABLE KEYS */;
INSERT INTO `OrderItem` VALUES (1,1,25.50,'2023-07-20 15:17:07.472','2023-07-20 15:17:07.472',1,1),(2,3,70.50,'2023-07-20 15:17:07.472','2023-07-20 15:17:07.472',1,2),(3,1,12.00,'2023-07-20 15:17:07.472','2023-07-20 15:17:07.472',1,3),(4,1,25.50,'2023-07-19 15:17:07.472','2023-07-20 22:48:04.000',1,1),(5,2,47.00,'2023-07-18 15:17:07.472','2023-07-20 22:48:04.000',2,3),(6,1,12.00,'2023-06-20 15:17:07.472','2023-07-20 22:48:04.000',3,5),(7,3,60.00,'2023-06-19 15:17:07.472','2023-07-20 22:48:04.000',4,6),(8,1,30.00,'2023-06-18 15:17:07.472','2023-07-20 22:48:04.000',5,8),(9,2,26.00,'2023-05-20 15:17:07.472','2023-07-20 22:48:04.000',6,10),(10,1,8.00,'2023-05-19 15:17:07.472','2023-07-20 22:48:04.000',7,12),(11,3,24.00,'2023-05-18 15:17:07.472','2023-07-20 22:48:04.000',8,14),(12,1,12.00,'2023-04-20 15:17:07.472','2023-07-20 22:48:04.000',9,15);
/*!40000 ALTER TABLE `OrderItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Snack`
--

DROP TABLE IF EXISTS `Snack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Snack` (
  `id` int NOT NULL AUTO_INCREMENT,
  `snack` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Snack`
--

LOCK TABLES `Snack` WRITE;
/*!40000 ALTER TABLE `Snack` DISABLE KEYS */;
INSERT INTO `Snack` VALUES (1,'burger','Mega','O artesanal tamanho família recheado com três carnes suculentas, queijo e bacon.',25.50,'https://i.imgur.com/upjIUnG.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(2,'burger','Extra Bacon','Criado para os amantes de bacon, possui em todas as suas camadas bacon bem assado e ainda queijo e carne.',23.50,'https://i.imgur.com/B4J04AJ.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(3,'burger','Tradicional','O simples também é delicioso, principalmente se envolver nossa carne artesanal e queijo.',12.00,'https://i.imgur.com/Jz506jB.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(4,'burger','Big Carne','Uma carne artesanal de primeira qualidade com 4cm de altura e uma salada completa com alface, cebola, tomate e outros.',18.00,'https://i.imgur.com/bF8EdBb.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(5,'burger','Carne dupla','Já pensou em comer aquele sanduíche com carne dupla e saborosa, recheada com queijo, molho e salada? Então você pensou exatamente nesse hambúrguer.',20.00,'https://i.imgur.com/fdEY2kY.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(6,'pizza','Calabresa','Pizza recheada com calabresa, cebola, mussarela, orégano e azeitona, tendo uma borda recheada com catupiry.',25.00,'https://i.imgur.com/5rjJGkV.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(7,'pizza','Portuguesa','Pizza recheada com presunto, mussarela, ovo, cebola, azeitona, orégano, tomate e molho de tomate, tendo uma borda recheada com catupiry.',28.50,'https://i.imgur.com/WCoyGoI.png','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(8,'pizza','Frango com Catupiry','Pizza recheada com frango, catupiry e brócolis, tendo uma borda recheada com catupiry.',24.00,'https://i.imgur.com/BuXrO8d.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(9,'pizza','Napolitana','Pizza recheada com queijo, mussarela, tomate e couve, tendo uma borda recheada com catupiry.',30.00,'https://i.imgur.com/u3DfvCE.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(10,'pizza','Mussarela','Pizza recheada com mussarela, tendo uma borda recheada com catupiry. ',20.50,'https://i.imgur.com/kPNXpa0.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(11,'pizza','Marguerita','Pizza recheada com calabresa, mussarela, cebola, azeitona e orégano, tendo uma borda recheada com catupiry.',25.50,'https://i.imgur.com/AsEfsZN.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(12,'pizza','Brigadeiro com Morango','Pizza doce recheada com brigadeiro e morango.',35.00,'https://i.imgur.com/43yC2Ap.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(13,'pizza','Banana','Pizza doce recheada com banana e leite condensado.',33.50,'https://i.imgur.com/Pcrgg1P.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(14,'pizza','Chocolate','Pizza doce recheada com chocolate e bolinhas de chocolate.',30.00,'https://i.imgur.com/RahAKkH.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(15,'drink','Coca-Cola 2L','A tradicional Coca-Cola que a família brasileira adora.',12.00,'https://i.imgur.com/Lg3aKhf.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(16,'drink','Guaraná Antarctica','O irresistível e saboroso Guaraná Antarctica em sua versão de latinha.',6.50,'https://i.imgur.com/hOBrOIm.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(17,'drink','Suco de Abacaxi','Suco natural de abacaxi com leves incrementos de algumas hortaliças para fortificar sua saúde.',8.00,'https://i.imgur.com/VV9qTMh.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(18,'drink','Suco de Laranja','Suco natural de laranja para você que é amante dessa fruta.',8.00,'https://i.imgur.com/2Lf2gHy.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(19,'ice-cream','Casquinha','A casquinha crocante e saborosa que nossos clientes amam.',4.50,'https://i.imgur.com/YGmeoCm.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(20,'ice-cream','Chocolate com granulado','Sorvete de chocolate com granulados em chocolate para você se deliciar.',6.00,'https://i.imgur.com/osAHOLe.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(21,'ice-cream','Flocos','O tradicional flocos vem com cobertura em chocolate para adocicar seu dia.',7.00,'https://i.imgur.com/qgnFLiy.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(22,'ice-cream','Creme','O simples sorvete de creme com um gosto irresistível.',6.50,'https://i.imgur.com/dFLysrT.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(23,'ice-cream','Morango','O clássico sorvete de morango que deixe tudo mais leve.',10.00,'https://i.imgur.com/0TWnEI7.jpg','2023-07-20 22:28:46.614','2023-07-20 22:28:46.614'),(24,'burger','Mega','O artesanal tamanho família recheado com três carnes suculentas, queijo e bacon.',25.50,'https://i.imgur.com/upjIUnG.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(25,'burger','Extra Bacon','Criado para os amantes de bacon, possui em todas as suas camadas bacon bem assado e ainda queijo e carne.',23.50,'https://i.imgur.com/B4J04AJ.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(26,'burger','Tradicional','O simples também é delicioso, principalmente se envolver nossa carne artesanal e queijo.',12.00,'https://i.imgur.com/Jz506jB.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(27,'burger','Big Carne','Uma carne artesanal de primeira qualidade com 4cm de altura e uma salada completa com alface, cebola, tomate e outros.',18.00,'https://i.imgur.com/bF8EdBb.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(28,'burger','Carne dupla','Já pensou em comer aquele sanduíche com carne dupla e saborosa, recheada com queijo, molho e salada? Então você pensou exatamente nesse hambúrguer.',20.00,'https://i.imgur.com/fdEY2kY.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(29,'pizza','Calabresa','Pizza recheada com calabresa, cebola, mussarela, orégano e azeitona, tendo uma borda recheada com catupiry.',25.00,'https://i.imgur.com/5rjJGkV.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(30,'pizza','Portuguesa','Pizza recheada com presunto, mussarela, ovo, cebola, azeitona, orégano, tomate e molho de tomate, tendo uma borda recheada com catupiry.',28.50,'https://i.imgur.com/WCoyGoI.png','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(31,'pizza','Frango com Catupiry','Pizza recheada com frango, catupiry e brócolis, tendo uma borda recheada com catupiry.',24.00,'https://i.imgur.com/BuXrO8d.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(32,'pizza','Napolitana','Pizza recheada com queijo, mussarela, tomate e couve, tendo uma borda recheada com catupiry.',30.00,'https://i.imgur.com/u3DfvCE.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(33,'pizza','Mussarela','Pizza recheada com mussarela, tendo uma borda recheada com catupiry. ',20.50,'https://i.imgur.com/kPNXpa0.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(34,'pizza','Marguerita','Pizza recheada com calabresa, mussarela, cebola, azeitona e orégano, tendo uma borda recheada com catupiry.',25.50,'https://i.imgur.com/AsEfsZN.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(35,'pizza','Brigadeiro com Morango','Pizza doce recheada com brigadeiro e morango.',35.00,'https://i.imgur.com/43yC2Ap.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(36,'pizza','Banana','Pizza doce recheada com banana e leite condensado.',33.50,'https://i.imgur.com/Pcrgg1P.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(37,'pizza','Chocolate','Pizza doce recheada com chocolate e bolinhas de chocolate.',30.00,'https://i.imgur.com/RahAKkH.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(38,'drink','Coca-Cola 2L','A tradicional Coca-Cola que a família brasileira adora.',12.00,'https://i.imgur.com/Lg3aKhf.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(39,'drink','Guaraná Antarctica','O irresistível e saboroso Guaraná Antarctica em sua versão de latinha.',6.50,'https://i.imgur.com/hOBrOIm.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(40,'drink','Suco de Abacaxi','Suco natural de abacaxi com leves incrementos de algumas hortaliças para fortificar sua saúde.',8.00,'https://i.imgur.com/VV9qTMh.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(41,'drink','Suco de Laranja','Suco natural de laranja para você que é amante dessa fruta.',8.00,'https://i.imgur.com/2Lf2gHy.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(42,'ice-cream','Casquinha','A casquinha crocante e saborosa que nossos clientes amam.',4.50,'https://i.imgur.com/YGmeoCm.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(43,'ice-cream','Chocolate com granulado','Sorvete de chocolate com granulados em chocolate para você se deliciar.',6.00,'https://i.imgur.com/osAHOLe.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(44,'ice-cream','Flocos','O tradicional flocos vem com cobertura em chocolate para adocicar seu dia.',7.00,'https://i.imgur.com/qgnFLiy.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(45,'ice-cream','Creme','O simples sorvete de creme com um gosto irresistível.',6.50,'https://i.imgur.com/dFLysrT.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298'),(46,'ice-cream','Morango','O clássico sorvete de morango que deixe tudo mais leve.',10.00,'https://i.imgur.com/0TWnEI7.jpg','2023-07-20 22:29:29.298','2023-07-20 22:29:29.298');
/*!40000 ALTER TABLE `Snack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_prisma_migrations`
--

LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
INSERT INTO `_prisma_migrations` VALUES ('ee2b01c5-5566-43b2-a132-bf25cfe47cf2','8bc5a88fa19b2f220a194fa1bebe5a559277acaa4e5a677ff56315c711cfb2e4','2023-07-20 22:28:41.514','20230720222840_novo',NULL,NULL,'2023-07-20 22:28:40.493',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-26 12:59:45
