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
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint DEFAULT '0',
  PRIMARY KEY (`no`),
  KEY `board_fk_id` (`user_id`),
  KEY `type_no` (`type_no`),
  CONSTRAINT `board_fk_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `board_ibfk_1` FOREIGN KEY (`type_no`) REFERENCES `board_type` (`type_no`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(2,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(3,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(4,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',1,0,'2023-04-28 08:39:56',0),(5,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(6,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(7,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(8,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(9,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',1,0,'2023-04-28 08:39:56',0),(10,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(11,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(12,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',1,0,'2023-04-28 08:39:56',0),(13,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(14,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(15,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(16,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(17,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-28 08:39:56',0),(18,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',12,0,'2023-04-28 08:39:56',0),(19,2,'ssafy','this is free board','THX XD',6,0,'2023-04-28 08:39:56',0),(20,2,'ssafy','this is free board','THX XD',3,0,'2023-04-28 08:39:56',0),(21,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(22,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(23,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(24,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(25,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(26,2,'ssafy','this is free board','THX XD',2,0,'2023-04-28 08:39:56',0),(27,2,'ssafy','this is free board','THX XD',1,0,'2023-04-28 08:39:56',0),(28,2,'ssafy','this is free board','THX XD',0,0,'2023-04-28 08:39:56',0),(29,2,'ssafy','this is free board','THX XD',1,0,'2023-04-28 08:39:56',0),(30,2,'ssafy','this is free board','THX XD',1,0,'2023-04-28 08:39:56',0),(31,2,'ssafy','this is free board','THX XD',2,0,'2023-04-28 08:39:56',0),(32,2,'ssafy','this is free board','THX XD',1,0,'2023-04-28 08:39:56',0),(33,2,'ssafy','this is free board','THX XD',3,0,'2023-04-28 08:39:56',0),(34,2,'ssafy','this is free board','THX XD',17,0,'2023-04-28 08:39:56',0),(35,2,'ssafy','this is free board','THX XD',12,0,'2023-04-28 08:39:56',0),(36,2,'ssafy','파일 업로드 테스트','ㅁㄴㄻ',2,0,'2023-05-12 02:48:41',0),(37,2,'ssafy','ㅁㄴㅁㄶ','ㅁㄶㅁㄶ',0,0,'2023-05-12 02:50:46',0),(38,1,'ssafy','ㅇㅅㅇ','ㅇㅅㅇㅅ',0,0,'2023-05-12 02:56:42',0),(39,1,'ssafy','ㅇㅅㅇ21241','ㅇㅅㅇㅅ',0,0,'2023-05-12 02:58:21',0),(40,1,'ssafy','ㅇㅅㅇ21241','ㅇㅅㅇㅅ',1,0,'2023-05-12 02:58:40',0),(41,1,'ssafy','작성하면 본문으로 이동?','이동하냐!!!',0,0,'2023-05-12 03:01:32',0),(42,1,'ssafy','뾰뿌삐빰','모르게쒀',0,0,'2023-05-12 03:02:25',0),(43,1,'ssafy','ㅁㄴㅁㄹ','ㅁㄴㄻㄴㄹ',0,0,'2023-05-12 03:07:55',0),(44,2,'ssafy','ㅅㄷㄴㅅ','ㅁㄴㄻㄹ',1,0,'2023-05-12 04:41:21',0),(45,2,'ssafy','1234','123',0,0,'2023-05-12 04:43:04',0),(46,2,'ssafy','ㅁㄴㅁㄹ','ㅁㄴㄻㄴㄹ',0,0,'2023-05-12 04:43:23',0),(47,2,'ssafy','ㅁㄴㄻㄴㄹ','ㅁㄴㄻㄻㄴㄹ',1,0,'2023-05-12 04:43:55',0),(48,2,'ssafy','허제발','제발베잘',0,0,'2023-05-12 04:45:28',0),(49,2,'ssafy','ㅁㄴㅁㄴㄻ','ㅁㄴㄻㄴㄹ',1,0,'2023-05-12 04:45:45',0),(50,2,'ssafy','ㄴㅁㄻㄴㅁㄴㄻ','ㅁㄴㄻㄴㄻ',1,0,'2023-05-12 04:46:23',0),(51,2,'ssafy','ㅁㄴㄻㄴㅁㄻ','ㅁㄻㄴㅁ',2,0,'2023-05-12 04:46:44',0),(52,2,'ssafy','1234','141241241',1,0,'2023-05-12 04:46:53',0),(53,2,'ssafy','ㅁㄴㄻㄻ','ㅁㄴㄻㄴㄻ',1,0,'2023-05-12 05:24:13',0),(54,2,'ssafy','파일있음 ','ㅎㅎㅎ',57,0,'2023-05-12 05:24:29',0),(55,2,'ssafy','ㅁㄴㄻㄴㄹ','ㅁㄴㄻㄴㄹ',6,0,'2023-05-12 05:55:57',0),(56,2,'ssafy','파일 조회가 왜 안대 ','살려줘',72,0,'2023-05-12 05:56:25',0),(57,2,'ssafy','동민','동민동민',6,0,'2023-05-15 06:52:46',0),(58,2,'ssafy','ㅁㄴㄻㄴㄹ','ㅁㄴㄻㄴㄹ',0,0,'2023-05-15 07:07:49',0),(59,2,'ssafy','아니 왜 게시판 안돼','ㅁㄴㄻㄴㄹ',0,0,'2023-05-15 07:09:17',0),(60,2,'ssafy','ㅁㄴㄻㄹㄴ','ㅁㄴㄻㄴ',0,0,'2023-05-15 07:14:38',0),(61,2,'ssafy','내배카 내놔','내배카',1,0,'2023-05-15 07:20:06',0),(62,2,'ssafy','게시글 작성후 본문으로?','ㅁㄴㄻㄴㄻㄴㄹㄴㅁ',1,0,'2023-05-15 07:20:18',0),(63,2,'ssafy','작성후 본문으로 가야지 어디가','어디가냐구',0,0,'2023-05-15 07:20:33',0),(64,2,'ssafy','어디가냐니까??',';;;',0,0,'2023-05-15 07:20:50',0),(65,2,'ssafy','골아프게하네','진짜',12,0,'2023-05-15 07:21:22',0),(66,2,'ssafy','ㅁㄴㄴㅁ','ㅁㄴㄻㄴㄹ',7,0,'2023-05-15 08:25:20',0),(67,2,'ssafy','이제는 안뜨겠ㅈ디','ㅁㄻㄴㄹ본문은 안바뀌나ㅇ',41,0,'2023-05-15 08:27:43',0),(68,2,'ssafy','근데 수정은 문제가 있다','그치?',13,0,'2023-05-15 08:50:08',0),(69,2,'ssafy','파일을 추가해도 마찬가지','본문제거',60,1,'2023-05-15 08:50:24',0),(70,2,'ssafy','글작성 삐융삐융','테스트입니다',14,0,'2023-05-16 01:13:29',1);
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

-- Dump completed on 2023-05-18 17:59:16
