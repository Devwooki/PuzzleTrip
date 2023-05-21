-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
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
  `board_type` int NOT NULL,
  PRIMARY KEY (`no`),
  KEY `comment_fk_id` (`board_no`),
  KEY `board_comment_ibfk_1` (`user_id`),
  CONSTRAINT `board_comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `comment_fk_id` FOREIGN KEY (`board_no`) REFERENCES `board` (`no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_comment`
--

LOCK TABLES `board_comment` WRITE;
/*!40000 ALTER TABLE `board_comment` DISABLE KEYS */;
INSERT INTO `board_comment` VALUES (20,'ssafy','댓글작성이 왜 안될까',0,1,'2023-05-06 11:15:30',NULL,1),(21,'ssafy','댓글작성이 왜 안될까',0,1,'2023-05-06 16:08:59',0,1),(22,'ssafy','댓글작성이 왜 안될까',0,1,'2023-05-06 16:26:37',0,1),(23,'ssafy','댓글작성',0,3,'2023-05-06 16:30:43',0,1),(24,'ssafy','히히힣 댓글\n',0,390,'2023-05-11 10:37:16',0,2),(25,'ssafy','ㅎㅅㅎ',0,390,'2023-05-11 10:37:56',0,2),(26,'ssafy','허허 뭐지\n',0,390,'2023-05-11 11:32:56',0,2),(27,'ssafy','ㅇㅎㅁ',0,381,'2023-05-11 11:33:14',0,2),(28,'ssafy','kjkljk',0,381,'2023-05-11 11:34:10',0,2),(29,'ssafy','ㄴㄹㅁㄴㄹ',0,381,'2023-05-11 11:35:05',0,2),(30,'ssafy','',0,381,'2023-05-11 11:35:05',0,2),(31,'ssafy','ㅁㄴㅎㅁ',0,378,'2023-05-11 11:35:14',0,2),(32,'ssafy','ㅇㅇㅎㅁ',0,386,'2023-05-11 11:35:35',0,2),(33,'ssafy','ㅁㅇㅎㅁㅇㅎ',0,386,'2023-05-11 11:35:37',0,2),(34,'ssafy','ㅁㅇㅎㅁㅇ',0,386,'2023-05-11 11:35:38',0,2),(35,'ssafy','aasfsfaf',0,399,'2023-05-14 14:53:35',1,2),(36,'ssafy','댓글 싀빠~~',0,399,'2023-05-14 14:53:45',1,2),(37,'ssafy','ㄹㅁㄴㄹ',0,399,'2023-05-14 14:54:19',1,2),(38,'ssafy','ㅁㄴㅁㄴㄹ',0,395,'2023-05-14 15:54:11',0,2),(39,'ssafy','ㅁㄴㅁㄴㄹㄴㅁㄹㅁㄹㄴ',0,395,'2023-05-14 15:54:13',1,2),(40,'ssafy','ㅁㄴㅁㄴㄹㄴㅁㄹㅁㄹㄴ',0,395,'2023-05-14 15:54:13',1,2),(41,'ssafy','ㅁㄴㅁㄴㄹㄴㅁㄹㅁㄹㄴ',0,395,'2023-05-14 15:54:14',1,2),(42,'ssafy','ㅁㄴㄹㅁㄴㄹㅁ',0,395,'2023-05-14 16:00:54',1,2),(43,'ssafy','asafas',0,399,'2023-05-14 16:06:43',1,2),(44,'ssafy','asfasfas',0,399,'2023-05-14 16:06:45',1,2),(45,'ssafy','safa',0,399,'2023-05-14 16:06:46',1,2),(46,'ssafy','asfsafaf',0,399,'2023-05-14 16:06:48',1,2),(47,'ssafy','asfafsa',0,399,'2023-05-14 16:06:49',1,2),(48,'ssafy','sasfafa',0,399,'2023-05-14 16:08:08',1,2),(49,'ssafy','asfas',0,399,'2023-05-14 16:08:09',1,2),(50,'ssafy','asfasfa',0,399,'2023-05-14 16:08:10',1,2),(51,'ssafy','safasfaf',0,398,'2023-05-14 16:09:33',0,2),(52,'ssafy','assfa',0,398,'2023-05-14 16:09:34',0,2),(53,'ssafy','safasfasf',0,398,'2023-05-14 16:09:35',0,2),(54,'ssafy','sf',0,398,'2023-05-14 16:09:36',0,2),(55,'ssafy','afasf\n',0,398,'2023-05-14 16:09:39',1,2),(56,'ssafy','ㅁㄹ\n\nㅁㄴ\nㅁㄴㄹㅁㄹㅁㄹㅁ',0,392,'2023-05-14 16:11:05',0,2),(57,'ssafy','ㄴㄹㄹㅁㄴㄹㅁ',0,392,'2023-05-14 16:11:07',0,2),(58,'ssafy','ㅁㄴㄹㅁㄴㄹ',0,392,'2023-05-14 16:11:09',1,2),(59,'ssafy','cc\nc\ndd',0,388,'2023-05-14 16:42:10',0,1),(60,'ssafy','d',0,388,'2023-05-14 16:42:11',0,1),(61,'ssafy','d\nd\nd',0,388,'2023-05-14 16:42:14',1,1),(62,'ssafy','dd',0,388,'2023-05-14 16:42:16',1,1),(63,'ssafy','ㄴㄹㄹㅁㅁ',0,399,'2023-05-14 16:47:53',1,2),(64,'ssafy','ㅁㄴㄹㅁㄹ',0,399,'2023-05-14 16:47:55',1,2),(65,'ssafy','ㅁㄴㄹㅁㄴ',0,399,'2023-05-14 16:47:56',1,2),(66,'ssafy','ㅁㄴㄹㅁ',0,399,'2023-05-14 16:47:57',1,2),(67,'ssafy','xx',0,388,'2023-05-14 16:52:32',0,1),(68,'ssafy','',0,388,'2023-05-14 16:52:32',0,1),(69,'ssafy','fafa',0,388,'2023-05-14 16:52:35',1,1),(70,'ssafy','asfs',0,399,'2023-05-14 16:58:36',0,2),(71,'ssafy','ssss',0,401,'2023-05-14 17:16:24',0,2),(72,'ssafy','',0,401,'2023-05-14 17:16:25',0,2),(73,'ssafy','ssss',0,401,'2023-05-14 17:16:27',1,2),(74,'ssafy','ccc',0,401,'2023-05-14 17:16:51',1,2),(75,'ssafy','kkddk',0,402,'2023-05-14 17:18:19',0,2),(76,'ssafy','asfasfa',0,402,'2023-05-14 17:18:42',0,2),(77,'ssafy','asfasf',0,402,'2023-05-14 17:19:17',0,2),(78,'ssafy','asfa',0,402,'2023-05-14 17:19:52',0,2),(79,'ssafy','xsss',0,400,'2023-05-16 12:38:52',1,2),(80,'ssafy','ssss',0,400,'2023-05-16 12:38:54',1,2),(81,'ssafy','ssss',0,400,'2023-05-16 12:38:56',1,2),(82,'ssafy','gggg',0,407,'2023-05-18 16:58:27',0,2);
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

-- Dump completed on 2023-05-19  2:00:34
