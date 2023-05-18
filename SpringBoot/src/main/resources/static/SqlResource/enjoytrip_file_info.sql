-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: enjoytrip
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `file_info`
--

DROP TABLE IF EXISTS `file_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file_info` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `board_no` int DEFAULT NULL,
  `save_folder` varchar(45) DEFAULT NULL,
  `original_file` varchar(50) DEFAULT NULL,
  `save_file` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `board_no` (`board_no`),
  CONSTRAINT `file_info_ibfk_1` FOREIGN KEY (`board_no`) REFERENCES `board` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_info`
--

LOCK TABLES `file_info` WRITE;
/*!40000 ALTER TABLE `file_info` DISABLE KEYS */;
INSERT INTO `file_info` VALUES (2,44,'230512','AppUser.vue','078eead8-aece-4f2d-8cbd-e39a8aa55a57.vue'),(3,45,'230512','캡처.PNG','65a5f003-bb32-4150-b998-2df4b2d7d98c.PNG'),(4,47,'230512','캡처.PNG','f2813e2d-83e1-4dda-b083-eb9ef50f240e.PNG'),(5,54,'230512','chrome.exe','56ce3bd4-501b-4841-bcf0-a3667151d31e.exe'),(6,54,'230512','캡처.PNG','8a7adec4-bbce-4bba-bb81-c4d5c21f5f2a.PNG'),(7,56,'230512','chrome.exe','1537a4cf-9da3-45a0-bf04-bc0549facb48.exe'),(8,56,'230512','캡처.PNG','ac57708f-1a50-49e9-bd79-fae7d66eb704.PNG'),(9,57,'230515','board-vue(김동민, 이현욱).zip','b49d653a-3b42-43da-a567-3c2ee8fb8ac3.zip'),(12,66,'230515','(입사지원서) 23년도 상반기 SSAFY 채용박람회.docx','7996b588-60bc-4588-8de1-85db2a15cbdd.docx'),(13,66,'230515','(상담신청서) 23년도 상반기 SSAFY 채용박람회.docx','b34236f3-cea6-472d-a7e6-ffad137cbf11.docx'),(22,67,'230515','vue-board-bootstrap.zip','ba9a3fa4-72ec-43fa-8ccf-5a7c88a660e2.zip'),(23,67,'230515','vuex-test.zip','700abb88-e5a0-40a9-9be0-c6d8ff2604c0.zip'),(24,67,'230515','electric-charging-station_live.zip','f848f4c7-7b6c-4a19-8948-381db3c25e3d.zip'),(26,69,'230515','vuex-test.zip','7797ac22-5349-4d79-afef-5c35baa0359c.zip'),(27,69,'230515','electric-charging-station_live.zip','4a720a2e-0220-42d8-8b7b-47add03d89dd.zip');
/*!40000 ALTER TABLE `file_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-18 17:59:16
