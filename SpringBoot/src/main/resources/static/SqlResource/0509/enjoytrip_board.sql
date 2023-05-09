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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-22 15:00:00',0),(2,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-22 15:00:00',0),(3,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-22 15:00:00',0),(4,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-22 15:00:00',0),(5,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-22 15:00:00',0),(6,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-22 15:00:00',0),(7,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-22 15:00:00',0),(8,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-22 15:00:00',0),(9,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-22 15:00:00',0),(10,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',0,0,'2023-04-22 15:00:00',0),(11,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',6,0,'2023-04-22 15:00:00',0),(12,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',3,0,'2023-04-22 15:00:00',0),(13,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',3,0,'2023-04-22 15:00:00',0),(14,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',3,0,'2023-04-22 15:00:00',0),(15,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',5,0,'2023-04-22 15:00:00',0),(16,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',4,0,'2023-04-22 15:00:00',1),(17,1,'admin','enjoytriasjsnknk라람닐p을 사용해주셔서 감사합니다.','감사하다고요',10,0,'2023-04-22 15:00:00',0),(18,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',19,0,'2023-04-22 15:00:00',0),(19,1,'admin','enjoytrip을 사용해주셔서 감사합니다.','감사하다고요',21,0,'2023-04-22 15:00:00',0),(20,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',0,0,'2023-04-27 15:00:00',0),(21,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',0,0,'2023-04-27 15:00:00',0),(22,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',0,0,'2023-04-27 15:00:00',0),(23,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',0,0,'2023-04-27 15:00:00',0),(24,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',0,0,'2023-04-27 15:00:00',1),(25,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',0,0,'2023-04-27 15:00:00',1),(26,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',1,0,'2023-04-27 15:00:00',0),(27,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',0,0,'2023-04-27 15:00:00',0),(28,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',1,0,'2023-04-27 15:00:00',0),(29,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',0,0,'2023-04-27 15:00:00',0),(30,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',1,0,'2023-04-27 15:00:00',0),(31,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',1,0,'2023-04-27 15:00:00',0),(32,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!ㄴㅁㄴㄴㅁㄹㅁㄹㄴ',1,0,'2023-04-27 15:00:00',0),(33,2,'ssafy','일반 게시글 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',3,0,'2023-04-27 15:00:00',0),(34,2,'admin','ㅎㅎㅎㅎ구분했 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',9,0,'2023-04-27 15:00:00',0),(35,2,'admin','ㅎㅎㅎㅎ구분했 주르륵','본문 내용입니다 아무것도 없는데 속앗지!',7,0,'2023-04-27 15:00:00',0),(53,1,'ssafy','이제 좀 정상으로 들어가나','본분 내용은 이것',5,0,'2023-04-30 07:40:45',0),(54,1,'ssafy','글작성테스트','ㄴ러마니러미',0,0,'2023-05-02 16:52:10',0),(55,1,'ssafy','공지사항 글 작성','ㅎㅎㅎㅎㅎ',0,0,'2023-05-02 16:52:47',0),(56,1,'ssafy','어라 이상한데','엥',0,0,'2023-05-02 16:53:12',0),(57,1,'ssafy','일반게시판 글 적는데','왜 안올라오지',0,0,'2023-05-02 16:54:02',0),(58,1,'ssafy','일반게시판!!','업로드 되라!!',0,0,'2023-05-02 16:54:20',0),(59,1,'ssafy','어 반대로 했나,,?','1번이 공지시항?',0,0,'2023-05-02 16:54:44',0),(60,1,'ssafy','1번이 공지사항이라니가','어허 엄한 곳에 글 적지 말고',0,0,'2023-05-02 16:55:58',0),(61,1,'ssafy','반대로아님','ㅣ제 좀 제대로 나오겠군',0,0,'2023-05-02 16:59:21',0);
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

-- Dump completed on 2023-05-09 21:29:40
