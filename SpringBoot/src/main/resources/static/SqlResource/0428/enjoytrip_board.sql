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
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `no` int NOT NULL AUTO_INCREMENT,
  `type_no` int NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` varchar(4000) NOT NULL,
  `hit` int DEFAULT '0',
  `like_cnt` int DEFAULT '0',
  `created_at` timestamp NOT NULL default current_timestamp,
  `status` tinyint DEFAULT '0',
  PRIMARY KEY (`no`),
  KEY `board_fk_id` (`user_id`),
  KEY `type_no` (`type_no`),
  CONSTRAINT `board_fk_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `board_ibfk_1` FOREIGN KEY (`type_no`) REFERENCES `board_type` (`type_no`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(2,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(3,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(4,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(5,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(6,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(7,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(8,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(9,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(10,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(11,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(12,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(13,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(14,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(15,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(16,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(17,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(18,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(19,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(20,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(21,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(22,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(23,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(24,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(25,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(26,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(27,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(28,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(29,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(30,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(31,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(32,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(33,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(34,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(35,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-28 15:52:43
