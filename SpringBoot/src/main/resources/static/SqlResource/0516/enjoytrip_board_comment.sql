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
-- Table structure for table `board_comment`
--

DROP TABLE IF EXISTS `board_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_comment` (
  `no` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL,
  `content` varchar(200) NOT NULL,
  `like` int DEFAULT '0',
  `board_no` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint DEFAULT '0',
  `board_type` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`no`),
  KEY `comment_fk_id` (`board_no`),
  KEY `board_comment_ibfk_1` (`user_id`),
  CONSTRAINT `board_comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `comment_fk_id` FOREIGN KEY (`board_no`) REFERENCES `board` (`no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_comment`
--

LOCK TABLES `board_comment` WRITE;
/*!40000 ALTER TABLE `board_comment` DISABLE KEYS */;
INSERT INTO `board_comment` VALUES (1,'admin','뿌끼루루룹뿌',0,34,'2023-05-06 02:15:30',0,2),(2,'ssafy','댓글댓글',0,34,'2023-05-11 03:47:08',0,2),(3,'admin','뿌끼루루룹뿌',0,34,'2023-05-06 02:15:30',0,2),(4,'ssafy','댓구르르르르',0,34,'2023-05-11 03:47:08',0,2),(20,'ssafy','댓글작성이 왜 안될까',0,1,'2023-05-06 02:15:30',0,1),(21,'ssafy','댓글작성이 왜 안될까',0,1,'2023-05-06 07:08:59',0,1),(22,'ssafy','댓글작성이 왜 안될까',0,1,'2023-05-06 07:26:37',0,1),(23,'ssafy','댓글작성',0,3,'2023-05-06 07:30:43',0,1),(24,'ssafy','ㅁㄴㄻㄹ',0,34,'2023-05-11 08:25:54',0,2),(25,'ssafy','ㅁㄴㄻㄹㅁㄴㄻㄴㄻㄴㄹ',0,34,'2023-05-11 08:25:56',0,2),(26,'ssafy','ㅁㄴㄻㄹㅁㄴㄻㅁㄴㄻㄴㄻㄴㄻㄴㄻㄴㄴㄻㄴㄹ',0,34,'2023-05-11 08:25:57',0,2),(27,'ssafy','히히힣ㅎ히',0,34,'2023-05-11 08:26:01',0,2),(28,'ssafy','ㅁㄴㄻㄴㄻㄹㄴ',0,34,'2023-05-11 08:26:14',0,2),(29,'ssafy','ㅁㄴㄻㄴㄻㄴㄻㄴㄹㄻㄴ',0,34,'2023-05-11 08:26:16',0,2),(30,'ssafy','동민이형 이것봐',0,34,'2023-05-11 08:26:21',0,2),(31,'ssafy','된다',0,34,'2023-05-11 08:26:24',0,2),(32,'ssafy','ㅁㄴㄻㄴㄻㄴ',0,35,'2023-05-11 08:32:47',0,2),(33,'ssafy','ㅇㅇㅎㅇㄶ',0,52,'2023-05-12 04:46:59',0,2),(34,'ssafy','ㄴㅇㅎㄴㅇㅎㄴㅇ',0,52,'2023-05-12 04:47:00',0,2),(35,'ssafy','ㄴㅇㅎㄴㅇㅎ',0,52,'2023-05-12 04:47:01',0,2),(36,'ssafy','ㅁㄴㄻㄴㄹ',0,54,'2023-05-12 08:48:42',0,2),(37,'ssafy','ㄴㄻㄴㄻ',0,54,'2023-05-12 08:48:43',0,2),(38,'ssafy','sㄻㄴㄻㄴ',0,54,'2023-05-12 08:48:44',0,2),(39,'ssafy','ㄻㄴㄻㄴㄻㄴ',0,54,'2023-05-12 08:48:45',1,2),(40,'ssafy','ㅁㄴㄻㄹ',0,54,'2023-05-15 01:33:09',1,2),(41,'ssafy','ㅁㄴㄻㄴㄻㄴㄹ',0,54,'2023-05-15 01:33:12',1,2),(42,'ssafy','ㅁㄴㅁㄴㄹ',0,69,'2023-05-16 01:12:16',0,2),(43,'ssafy','ㅁㄴㄻㄴㄻㄴ',0,69,'2023-05-16 01:12:17',1,2),(44,'ssafy','ㅁㄴㄻㄴㄻ',0,69,'2023-05-16 01:12:19',0,2);
/*!40000 ALTER TABLE `board_comment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-16 13:33:29
