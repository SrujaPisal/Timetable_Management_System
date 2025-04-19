-- MySQL dump 10.13  Distrib 9.1.0, for macos14 (arm64)
--
-- Host: localhost    Database: Timetable_Management_System
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Assigned`
--

DROP TABLE IF EXISTS `Assigned`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Assigned` (
  `assigned_id` int NOT NULL AUTO_INCREMENT,
  `prof_id` int NOT NULL,
  `course_code` varchar(10) NOT NULL,
  PRIMARY KEY (`assigned_id`),
  KEY `prof_id` (`prof_id`),
  KEY `course_code` (`course_code`),
  CONSTRAINT `assigned_ibfk_1` FOREIGN KEY (`prof_id`) REFERENCES `Professor` (`prof_id`) ON DELETE CASCADE,
  CONSTRAINT `assigned_ibfk_2` FOREIGN KEY (`course_code`) REFERENCES `Course` (`course_code`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assigned`
--

LOCK TABLES `Assigned` WRITE;
/*!40000 ALTER TABLE `Assigned` DISABLE KEYS */;
INSERT INTO `Assigned` VALUES (1,1,'CS103'),(2,1,'CS104'),(3,2,'CS109'),(4,2,'CSBS105'),(5,3,'CS106'),(6,3,'CS107'),(7,4,'CS101'),(8,4,'CS110'),(9,5,'AIDS101'),(10,5,'AIDS102'),(11,6,'CSF101'),(12,6,'CSF102'),(13,7,'AIDS103'),(14,7,'AIDS104'),(15,8,'CSBS101'),(16,8,'CSBS102'),(17,9,'CS108'),(18,9,'CSL102'),(19,10,'CSL101'),(20,1,'AIDS105'),(21,2,'AIDSL101'),(22,3,'CS102'),(23,4,'CS105'),(24,5,'CSBS103'),(25,6,'CSBS104'),(26,7,'CSBS106'),(27,8,'CSBSL101'),(28,9,'CSFL101');
/*!40000 ALTER TABLE `Assigned` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Batch`
--

DROP TABLE IF EXISTS `Batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Batch` (
  `batch_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `program_id` int NOT NULL,
  PRIMARY KEY (`batch_id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `batch_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `Program` (`program_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Batch`
--

LOCK TABLES `Batch` WRITE;
/*!40000 ALTER TABLE `Batch` DISABLE KEYS */;
INSERT INTO `Batch` VALUES (1,'A1',1),(2,'A2',1),(3,'A1',2),(4,'A2',2),(5,'A1',3),(6,'A2',3),(7,'A1',4),(8,'A2',4);
/*!40000 ALTER TABLE `Batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Course`
--

DROP TABLE IF EXISTS `Course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Course` (
  `course_code` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `credits` int NOT NULL,
  `weekly_hrs` int NOT NULL,
  `evaluation_scheme` varchar(255) NOT NULL,
  `program_id` int NOT NULL,
  `is_lab` tinyint(1) NOT NULL DEFAULT '0',
  `batch_division` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`course_code`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `Program` (`program_id`) ON DELETE CASCADE,
  CONSTRAINT `course_chk_1` CHECK ((`credits` > 0)),
  CONSTRAINT `course_chk_2` CHECK ((`weekly_hrs` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course`
--

LOCK TABLES `Course` WRITE;
/*!40000 ALTER TABLE `Course` DISABLE KEYS */;
INSERT INTO `Course` VALUES ('AIDS101','Deep Learning',3,4,'TT1',4,0,0),('AIDS102','Natural Language Processing',3,4,'TT1',4,0,0),('AIDS103','Big Data Analytics',3,4,'TT1',4,0,0),('AIDS104','Reinforcement Learning',3,4,'TT1',4,0,0),('AIDS105','AI Ethics & Bias',3,4,'TT1',4,0,0),('AIDSL101','Machine Learning Lab',2,3,'TT2',4,1,1),('CS101','Data Structures',3,4,'TT1',2,0,0),('CS102','Algorithms',3,4,'TT1',2,0,0),('CS103','Database Systems',3,4,'TT1',2,0,0),('CS104','Operating Systems',4,5,'TT1',2,0,0),('CS105','Computer Networks',3,4,'TT1',2,0,0),('CS106','Machine Learning',3,4,'TT1',2,0,0),('CS107','Artificial Intelligence',3,4,'TT1',2,0,0),('CS108','Cyber Security',3,4,'TT1',2,0,0),('CS109','Software Engineering',3,4,'TT1',2,0,0),('CS110','Cloud Computing',3,4,'TT1',2,0,0),('CSBS101','Business Analytics',3,4,'TT1',1,0,0),('CSBS102','Financial Computing',3,4,'TT1',1,0,0),('CSBS103','Marketing & IT',3,4,'TT1',1,0,0),('CSBS104','Database Management Systems',3,4,'TT1',1,0,0),('CSBS105','Automata Theory',3,4,'TT1',1,0,0),('CSBS106','Computer Networks',3,4,'TT1',1,0,0),('CSBSL101','Database Management Systems Lab',2,3,'TT2',1,1,1),('CSF101','Cryptography',3,4,'TT1',3,0,0),('CSF102','Blockchain Technology',3,4,'TT1',3,0,0),('CSFL101','Blockchain Security Lab',2,3,'TT2',3,1,1),('CSL101','Database Systems Lab',2,3,'TT2',2,1,1),('CSL102','Operating Systems Lab',2,3,'TT2',2,1,1);
/*!40000 ALTER TABLE `Course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Expertise`
--

DROP TABLE IF EXISTS `Expertise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Expertise` (
  `prof_id` int NOT NULL,
  `subject_id` varchar(50) NOT NULL,
  `experience` int DEFAULT NULL,
  PRIMARY KEY (`prof_id`,`subject_id`),
  KEY `fk_subject` (`subject_id`),
  CONSTRAINT `expertise_ibfk_1` FOREIGN KEY (`prof_id`) REFERENCES `Professor` (`prof_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_subject` FOREIGN KEY (`subject_id`) REFERENCES `Course` (`course_code`) ON DELETE CASCADE,
  CONSTRAINT `expertise_chk_1` CHECK ((`experience` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Expertise`
--

LOCK TABLES `Expertise` WRITE;
/*!40000 ALTER TABLE `Expertise` DISABLE KEYS */;
INSERT INTO `Expertise` VALUES (1,'CS103',10),(1,'CS104',8),(1,'CS105',6),(2,'CS109',7),(2,'CSBS105',9),(3,'CS106',12),(3,'CS107',8),(4,'CS101',11),(4,'CS110',10),(5,'AIDS101',6),(5,'AIDS102',9),(6,'CSF101',7),(6,'CSF102',8),(7,'AIDS103',5),(7,'AIDS104',7),(8,'CSBS101',6),(8,'CSBS102',7),(9,'CS108',9),(9,'CSL102',8),(10,'CSL101',5);
/*!40000 ALTER TABLE `Expertise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Professor`
--

DROP TABLE IF EXISTS `Professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Professor` (
  `prof_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_no` varchar(15) NOT NULL,
  `working_hrs` int DEFAULT NULL,
  PRIMARY KEY (`prof_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `contact_no` (`contact_no`),
  CONSTRAINT `professor_chk_1` CHECK ((`working_hrs` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Professor`
--

LOCK TABLES `Professor` WRITE;
/*!40000 ALTER TABLE `Professor` DISABLE KEYS */;
INSERT INTO `Professor` VALUES (1,'Dr. Rajesh Kumar','rajesh.kumar@university.edu','9876543210',40),(2,'Dr. Anjali Sharma','anjali.sharma@university.edu','9876543211',40),(3,'Dr. Amit Verma','amit.verma@university.edu','9876543212',40),(4,'Dr. Pooja Mehta','pooja.mehta@university.edu','9876543213',40),(5,'Dr. Suresh Rao','suresh.rao@university.edu','9876543214',40),(6,'Dr. Neha Gupta','neha.gupta@university.edu','9876543215',40),(7,'Dr. Ramesh Iyer','ramesh.iyer@university.edu','9876543216',40),(8,'Dr. Priya Deshmukh','priya.deshmukh@university.edu','9876543217',40),(9,'Dr. Vishal Patil','vishal.patil@university.edu','9876543218',40),(10,'Dr. Kavita Joshi','kavita.joshi@university.edu','9876543219',40),(11,'Dr. Manish Kulkarni','manish.kulkarni@university.edu','9876543220',40),(12,'Dr. Swati Bansal','swati.bansal@university.edu','9876543221',40),(13,'Dr. Arvind Menon','arvind.menon@university.edu','9876543222',40),(14,'Dr. Sunita Nair','sunita.nair@university.edu','9876543223',40),(15,'Dr. Rohit Saxena','rohit.saxena@university.edu','9876543224',40),(16,'Dr. Meenal Jain','meenal.jain@university.edu','9876543225',40),(17,'Dr. Sameer Reddy','sameer.reddy@university.edu','9876543226',40),(18,'Dr. Vandana Kapoor','vandana.kapoor@university.edu','9876543227',40),(19,'Dr. Mohit Chandra','mohit.chandra@university.edu','9876543228',40),(20,'Dr. Sneha Iyer','sneha.iyer@university.edu','9876543229',40);
/*!40000 ALTER TABLE `Professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `professortimetable`
--

DROP TABLE IF EXISTS `professortimetable`;
/*!50001 DROP VIEW IF EXISTS `professortimetable`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `professortimetable` AS SELECT 
 1 AS `professor`,
 1 AS `day`,
 1 AS `timeslot`,
 1 AS `course`,
 1 AS `room_no`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `professortimetableview`
--

DROP TABLE IF EXISTS `professortimetableview`;
/*!50001 DROP VIEW IF EXISTS `professortimetableview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `professortimetableview` AS SELECT 
 1 AS `day`,
 1 AS `timeslot`,
 1 AS `prof_id`,
 1 AS `professor_name`,
 1 AS `course_name`,
 1 AS `room_no`,
 1 AS `program_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Program`
--

DROP TABLE IF EXISTS `Program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Program` (
  `program_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `duration` int NOT NULL,
  `capacity` int NOT NULL,
  PRIMARY KEY (`program_id`),
  CONSTRAINT `program_chk_1` CHECK ((`duration` > 0)),
  CONSTRAINT `program_chk_2` CHECK ((`capacity` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Program`
--

LOCK TABLES `Program` WRITE;
/*!40000 ALTER TABLE `Program` DISABLE KEYS */;
INSERT INTO `Program` VALUES (1,'BTech CSBS',4,60),(2,'Btech CSE',4,60),(3,'BTech CSF',4,60),(4,'BTech AIDS',4,60);
/*!40000 ALTER TABLE `Program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Room`
--

DROP TABLE IF EXISTS `Room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Room` (
  `room_no` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `capacity` int NOT NULL,
  `type` enum('lecture','lab') NOT NULL,
  PRIMARY KEY (`room_no`),
  CONSTRAINT `room_chk_1` CHECK ((`capacity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Room`
--

LOCK TABLES `Room` WRITE;
/*!40000 ALTER TABLE `Room` DISABLE KEYS */;
INSERT INTO `Room` VALUES ('L201','Computer Lab 1',30,'lab'),('L202','Computer Lab 2',30,'lab'),('L203','Computer Lab 3',30,'lab'),('L204','Computer Lab 4',30,'lab'),('R101','Classroom 1',60,'lecture'),('R102','Classroom 2',60,'lecture'),('R103','Classroom 3',60,'lecture'),('R104','Classroom 4',60,'lecture');
/*!40000 ALTER TABLE `Room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_for`
--

DROP TABLE IF EXISTS `scheduled_for`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduled_for` (
  `scheduled_id` int NOT NULL AUTO_INCREMENT,
  `program_id` int NOT NULL,
  PRIMARY KEY (`scheduled_id`),
  KEY `program_id` (`program_id`),
  CONSTRAINT `scheduled_for_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `Program` (`program_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_for`
--

LOCK TABLES `scheduled_for` WRITE;
/*!40000 ALTER TABLE `scheduled_for` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduled_for` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Timetable`
--

DROP TABLE IF EXISTS `Timetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Timetable` (
  `timetable_id` int NOT NULL AUTO_INCREMENT,
  `course_code` varchar(10) NOT NULL,
  `prof_id` int NOT NULL,
  `room_no` varchar(10) NOT NULL,
  `day` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,
  `timeslot` varchar(20) NOT NULL,
  `program_id` int NOT NULL,
  `is_lab` tinyint(1) NOT NULL,
  `batch_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`timetable_id`),
  KEY `course_code` (`course_code`),
  KEY `prof_id` (`prof_id`),
  KEY `room_no` (`room_no`),
  KEY `fk_program` (`program_id`),
  CONSTRAINT `fk_program` FOREIGN KEY (`program_id`) REFERENCES `Program` (`program_id`) ON DELETE CASCADE,
  CONSTRAINT `timetable_ibfk_1` FOREIGN KEY (`course_code`) REFERENCES `Course` (`course_code`) ON DELETE CASCADE,
  CONSTRAINT `timetable_ibfk_2` FOREIGN KEY (`prof_id`) REFERENCES `Professor` (`prof_id`) ON DELETE CASCADE,
  CONSTRAINT `timetable_ibfk_3` FOREIGN KEY (`room_no`) REFERENCES `Room` (`room_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11559 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Timetable`
--

LOCK TABLES `Timetable` WRITE;
/*!40000 ALTER TABLE `Timetable` DISABLE KEYS */;
INSERT INTO `Timetable` VALUES (11239,'AIDS101',5,'R103','Monday','6',1,0,NULL),(11240,'AIDS101',5,'R103','Tuesday','7',1,0,NULL),(11241,'AIDS101',5,'R103','Wednesday','3',1,0,NULL),(11242,'AIDS102',5,'R101','Tuesday','4',1,0,NULL),(11243,'AIDS102',5,'R101','Saturday','4',1,0,NULL),(11244,'AIDS102',5,'R101','Saturday','7',1,0,NULL),(11245,'AIDS103',7,'R101','Tuesday','7',1,0,NULL),(11246,'AIDS103',7,'R101','Thursday','5',1,0,NULL),(11247,'AIDS103',7,'R101','Saturday','4',1,0,NULL),(11248,'AIDS104',7,'R101','Monday','3',1,0,NULL),(11249,'AIDS104',7,'R101','Thursday','8',1,0,NULL),(11250,'AIDS104',7,'R101','Friday','2',1,0,NULL),(11251,'AIDS105',1,'R102','Wednesday','7',1,0,NULL),(11252,'AIDS105',1,'R102','Thursday','5',1,0,NULL),(11253,'AIDS105',1,'R102','Friday','1',1,0,NULL),(11254,'AIDSL101',2,'L201','Tuesday','2',1,1,NULL),(11255,'AIDSL101',2,'L201','Tuesday','7',1,1,NULL),(11256,'CS101',4,'R103','Monday','5',1,0,NULL),(11257,'CS101',4,'R103','Tuesday','5',1,0,NULL),(11258,'CS101',4,'R103','Saturday','2',1,0,NULL),(11259,'CS102',3,'R101','Thursday','8',1,0,NULL),(11260,'CS102',3,'R101','Saturday','1',1,0,NULL),(11261,'CS102',3,'R101','Saturday','5',1,0,NULL),(11262,'CS103',1,'R101','Wednesday','3',1,0,NULL),(11263,'CS103',1,'R101','Wednesday','4',1,0,NULL),(11264,'CS103',1,'R101','Friday','2',1,0,NULL),(11265,'CS104',1,'R104','Wednesday','1',1,0,NULL),(11266,'CS104',1,'R104','Friday','8',1,0,NULL),(11267,'CS104',1,'R104','Saturday','3',1,0,NULL),(11268,'CS104',1,'R104','Saturday','4',1,0,NULL),(11269,'CS105',4,'R101','Friday','2',1,0,NULL),(11270,'CS105',4,'R101','Friday','8',1,0,NULL),(11271,'CS105',4,'R101','Saturday','7',1,0,NULL),(11272,'CS106',3,'R101','Monday','1',1,0,NULL),(11273,'CS106',3,'R101','Monday','5',1,0,NULL),(11274,'CS106',3,'R101','Friday','4',1,0,NULL),(11275,'CS107',3,'R101','Tuesday','2',1,0,NULL),(11276,'CS107',3,'R101','Thursday','4',1,0,NULL),(11277,'CS107',3,'R101','Saturday','8',1,0,NULL),(11278,'CS108',9,'R102','Monday','5',1,0,NULL),(11279,'CS108',9,'R102','Friday','8',1,0,NULL),(11280,'CS108',9,'R102','Saturday','1',1,0,NULL),(11281,'CS109',2,'R101','Thursday','4',1,0,NULL),(11282,'CS109',2,'R101','Saturday','4',1,0,NULL),(11283,'CS109',2,'R101','Saturday','6',1,0,NULL),(11284,'CS110',4,'R101','Wednesday','6',1,0,NULL),(11285,'CS110',4,'R101','Friday','2',1,0,NULL),(11286,'CS110',4,'R101','Saturday','7',1,0,NULL),(11287,'CSBS101',8,'R101','Tuesday','8',1,0,NULL),(11288,'CSBS101',8,'R101','Wednesday','3',1,0,NULL),(11289,'CSBS101',8,'R101','Saturday','4',1,0,NULL),(11290,'CSBS102',8,'R101','Tuesday','5',1,0,NULL),(11291,'CSBS102',8,'R101','Wednesday','3',1,0,NULL),(11292,'CSBS102',8,'R101','Wednesday','5',1,0,NULL),(11293,'CSBS103',5,'R104','Tuesday','5',1,0,NULL),(11294,'CSBS103',5,'R104','Thursday','8',1,0,NULL),(11295,'CSBS103',5,'R104','Friday','8',1,0,NULL),(11296,'CSBS104',6,'R101','Wednesday','4',1,0,NULL),(11297,'CSBS104',6,'R101','Thursday','1',1,0,NULL),(11298,'CSBS104',6,'R101','Friday','8',1,0,NULL),(11299,'CSBS105',2,'R101','Tuesday','2',1,0,NULL),(11300,'CSBS105',2,'R101','Tuesday','4',1,0,NULL),(11301,'CSBS105',2,'R101','Friday','3',1,0,NULL),(11302,'CSBS106',7,'R101','Monday','5',1,0,NULL),(11303,'CSBS106',7,'R101','Tuesday','3',1,0,NULL),(11304,'CSBS106',7,'R101','Friday','6',1,0,NULL),(11305,'CSBSL101',8,'L201','Monday','3',1,1,NULL),(11306,'CSBSL101',8,'L201','Thursday','8',1,1,NULL),(11307,'CSF101',6,'R101','Wednesday','7',1,0,NULL),(11308,'CSF101',6,'R101','Saturday','5',1,0,NULL),(11309,'CSF101',6,'R101','Saturday','8',1,0,NULL),(11310,'CSF102',6,'R102','Tuesday','7',1,0,NULL),(11311,'CSF102',6,'R102','Wednesday','1',1,0,NULL),(11312,'CSF102',6,'R102','Saturday','2',1,0,NULL),(11313,'CSFL101',9,'L201','Tuesday','4',1,1,NULL),(11314,'CSFL101',9,'L201','Thursday','8',1,1,NULL),(11315,'CSL101',10,'L201','Tuesday','7',1,1,NULL),(11316,'CSL101',10,'L201','Wednesday','7',1,1,NULL),(11317,'CSL102',9,'L201','Thursday','4',1,1,NULL),(11318,'CSL102',9,'L201','Friday','6',1,1,NULL),(11319,'AIDS101',5,'R103','Wednesday','7',2,0,NULL),(11320,'AIDS101',5,'R103','Wednesday','8',2,0,NULL),(11321,'AIDS101',5,'R103','Saturday','4',2,0,NULL),(11322,'AIDS102',5,'R101','Monday','4',2,0,NULL),(11323,'AIDS102',5,'R101','Thursday','5',2,0,NULL),(11324,'AIDS102',5,'R101','Saturday','6',2,0,NULL),(11325,'AIDS103',7,'R101','Monday','6',2,0,NULL),(11326,'AIDS103',7,'R101','Saturday','5',2,0,NULL),(11327,'AIDS103',7,'R101','Saturday','8',2,0,NULL),(11328,'AIDS104',7,'R101','Monday','2',2,0,NULL),(11329,'AIDS104',7,'R101','Tuesday','7',2,0,NULL),(11330,'AIDS104',7,'R101','Friday','8',2,0,NULL),(11331,'AIDS105',1,'R102','Monday','5',2,0,NULL),(11332,'AIDS105',1,'R102','Monday','6',2,0,NULL),(11333,'AIDS105',1,'R102','Friday','5',2,0,NULL),(11334,'AIDSL101',2,'L201','Thursday','6',2,1,NULL),(11335,'AIDSL101',2,'L201','Friday','6',2,1,NULL),(11336,'CS101',4,'R103','Tuesday','6',2,0,NULL),(11337,'CS101',4,'R103','Thursday','2',2,0,NULL),(11338,'CS101',4,'R103','Saturday','5',2,0,NULL),(11339,'CS102',3,'R101','Monday','3',2,0,NULL),(11340,'CS102',3,'R101','Friday','7',2,0,NULL),(11341,'CS102',3,'R101','Saturday','8',2,0,NULL),(11342,'CS103',1,'R101','Wednesday','2',2,0,NULL),(11343,'CS103',1,'R101','Thursday','1',2,0,NULL),(11344,'CS103',1,'R101','Saturday','3',2,0,NULL),(11345,'CS104',1,'R104','Monday','1',2,0,NULL),(11346,'CS104',1,'R104','Monday','2',2,0,NULL),(11347,'CS104',1,'R104','Wednesday','7',2,0,NULL),(11348,'CS104',1,'R104','Friday','5',2,0,NULL),(11349,'CS105',4,'R101','Monday','5',2,0,NULL),(11350,'CS105',4,'R101','Tuesday','6',2,0,NULL),(11351,'CS105',4,'R101','Thursday','2',2,0,NULL),(11352,'CS106',3,'R101','Monday','2',2,0,NULL),(11353,'CS106',3,'R101','Wednesday','4',2,0,NULL),(11354,'CS106',3,'R101','Saturday','2',2,0,NULL),(11355,'CS107',3,'R101','Tuesday','4',2,0,NULL),(11356,'CS107',3,'R101','Friday','7',2,0,NULL),(11357,'CS107',3,'R101','Saturday','7',2,0,NULL),(11358,'CS108',9,'R102','Monday','3',2,0,NULL),(11359,'CS108',9,'R102','Thursday','3',2,0,NULL),(11360,'CS108',9,'R102','Friday','4',2,0,NULL),(11361,'CS109',2,'R101','Thursday','3',2,0,NULL),(11362,'CS109',2,'R101','Friday','6',2,0,NULL),(11363,'CS109',2,'R101','Saturday','3',2,0,NULL),(11364,'CS110',4,'R101','Wednesday','7',2,0,NULL),(11365,'CS110',4,'R101','Saturday','2',2,0,NULL),(11366,'CS110',4,'R101','Saturday','3',2,0,NULL),(11367,'CSBS101',8,'R101','Tuesday','2',2,0,NULL),(11368,'CSBS101',8,'R101','Tuesday','7',2,0,NULL),(11369,'CSBS101',8,'R101','Friday','8',2,0,NULL),(11370,'CSBS102',8,'R101','Thursday','8',2,0,NULL),(11371,'CSBS102',8,'R101','Friday','7',2,0,NULL),(11372,'CSBS102',8,'R101','Saturday','4',2,0,NULL),(11373,'CSBS103',5,'R104','Tuesday','1',2,0,NULL),(11374,'CSBS103',5,'R104','Tuesday','6',2,0,NULL),(11375,'CSBS103',5,'R104','Tuesday','8',2,0,NULL),(11376,'CSBS104',6,'R101','Monday','1',2,0,NULL),(11377,'CSBS104',6,'R101','Friday','2',2,0,NULL),(11378,'CSBS104',6,'R101','Saturday','2',2,0,NULL),(11379,'CSBS105',2,'R101','Monday','3',2,0,NULL),(11380,'CSBS105',2,'R101','Saturday','4',2,0,NULL),(11381,'CSBS105',2,'R101','Saturday','5',2,0,NULL),(11382,'CSBS106',7,'R101','Wednesday','8',2,0,NULL),(11383,'CSBS106',7,'R101','Friday','4',2,0,NULL),(11384,'CSBS106',7,'R101','Saturday','6',2,0,NULL),(11385,'CSBSL101',8,'L201','Monday','1',2,1,NULL),(11386,'CSBSL101',8,'L201','Monday','4',2,1,NULL),(11387,'CSF101',6,'R101','Monday','8',2,0,NULL),(11388,'CSF101',6,'R101','Wednesday','6',2,0,NULL),(11389,'CSF101',6,'R101','Saturday','7',2,0,NULL),(11390,'CSF102',6,'R102','Tuesday','4',2,0,NULL),(11391,'CSF102',6,'R102','Thursday','1',2,0,NULL),(11392,'CSF102',6,'R102','Thursday','4',2,0,NULL),(11393,'CSFL101',9,'L201','Thursday','2',2,1,NULL),(11394,'CSFL101',9,'L201','Thursday','4',2,1,NULL),(11395,'CSL101',10,'L201','Thursday','2',2,1,NULL),(11396,'CSL101',10,'L201','Saturday','3',2,1,NULL),(11397,'CSL102',9,'L201','Thursday','6',2,1,NULL),(11398,'CSL102',9,'L201','Thursday','7',2,1,NULL),(11399,'AIDS101',5,'R103','Wednesday','1',3,0,NULL),(11400,'AIDS101',5,'R103','Thursday','8',3,0,NULL),(11401,'AIDS101',5,'R103','Friday','4',3,0,NULL),(11402,'AIDS102',5,'R101','Friday','4',3,0,NULL),(11403,'AIDS102',5,'R101','Friday','6',3,0,NULL),(11404,'AIDS102',5,'R101','Saturday','3',3,0,NULL),(11405,'AIDS103',7,'R101','Tuesday','2',3,0,NULL),(11406,'AIDS103',7,'R101','Tuesday','4',3,0,NULL),(11407,'AIDS103',7,'R101','Saturday','1',3,0,NULL),(11408,'AIDS104',7,'R101','Wednesday','3',3,0,NULL),(11409,'AIDS104',7,'R101','Friday','7',3,0,NULL),(11410,'AIDS104',7,'R101','Saturday','7',3,0,NULL),(11411,'AIDS105',1,'R102','Thursday','1',3,0,NULL),(11412,'AIDS105',1,'R102','Thursday','3',3,0,NULL),(11413,'AIDS105',1,'R102','Friday','6',3,0,NULL),(11414,'AIDSL101',2,'L201','Monday','1',3,1,NULL),(11415,'AIDSL101',2,'L201','Monday','8',3,1,NULL),(11416,'CS101',4,'R103','Monday','4',3,0,NULL),(11417,'CS101',4,'R103','Wednesday','2',3,0,NULL),(11418,'CS101',4,'R103','Saturday','1',3,0,NULL),(11419,'CS102',3,'R101','Monday','4',3,0,NULL),(11420,'CS102',3,'R101','Thursday','2',3,0,NULL),(11421,'CS102',3,'R101','Friday','8',3,0,NULL),(11422,'CS103',1,'R101','Tuesday','2',3,0,NULL),(11423,'CS103',1,'R101','Friday','8',3,0,NULL),(11424,'CS103',1,'R101','Saturday','4',3,0,NULL),(11425,'CS104',1,'R104','Monday','6',3,0,NULL),(11426,'CS104',1,'R104','Friday','1',3,0,NULL),(11427,'CS104',1,'R104','Friday','2',3,0,NULL),(11428,'CS104',1,'R104','Friday','6',3,0,NULL),(11429,'CS105',4,'R101','Tuesday','4',3,0,NULL),(11430,'CS105',4,'R101','Wednesday','7',3,0,NULL),(11431,'CS105',4,'R101','Friday','5',3,0,NULL),(11432,'CS106',3,'R101','Wednesday','7',3,0,NULL),(11433,'CS106',3,'R101','Thursday','5',3,0,NULL),(11434,'CS106',3,'R101','Saturday','1',3,0,NULL),(11435,'CS107',3,'R101','Monday','5',3,0,NULL),(11436,'CS107',3,'R101','Wednesday','1',3,0,NULL),(11437,'CS107',3,'R101','Friday','1',3,0,NULL),(11438,'CS108',9,'R102','Tuesday','1',3,0,NULL),(11439,'CS108',9,'R102','Saturday','2',3,0,NULL),(11440,'CS108',9,'R102','Saturday','6',3,0,NULL),(11441,'CS109',2,'R101','Monday','1',3,0,NULL),(11442,'CS109',2,'R101','Wednesday','7',3,0,NULL),(11443,'CS109',2,'R101','Friday','1',3,0,NULL),(11444,'CS110',4,'R101','Tuesday','6',3,0,NULL),(11445,'CS110',4,'R101','Tuesday','8',3,0,NULL),(11446,'CS110',4,'R101','Saturday','8',3,0,NULL),(11447,'CSBS101',8,'R101','Monday','7',3,0,NULL),(11448,'CSBS101',8,'R101','Thursday','4',3,0,NULL),(11449,'CSBS101',8,'R101','Friday','6',3,0,NULL),(11450,'CSBS102',8,'R101','Monday','1',3,0,NULL),(11451,'CSBS102',8,'R101','Wednesday','1',3,0,NULL),(11452,'CSBS102',8,'R101','Wednesday','6',3,0,NULL),(11453,'CSBS103',5,'R104','Thursday','5',3,0,NULL),(11454,'CSBS103',5,'R104','Saturday','2',3,0,NULL),(11455,'CSBS103',5,'R104','Saturday','6',3,0,NULL),(11456,'CSBS104',6,'R101','Thursday','3',3,0,NULL),(11457,'CSBS104',6,'R101','Thursday','8',3,0,NULL),(11458,'CSBS104',6,'R101','Friday','4',3,0,NULL),(11459,'CSBS105',2,'R101','Thursday','3',3,0,NULL),(11460,'CSBS105',2,'R101','Thursday','5',3,0,NULL),(11461,'CSBS105',2,'R101','Thursday','6',3,0,NULL),(11462,'CSBS106',7,'R101','Monday','3',3,0,NULL),(11463,'CSBS106',7,'R101','Monday','4',3,0,NULL),(11464,'CSBS106',7,'R101','Friday','3',3,0,NULL),(11465,'CSBSL101',8,'L201','Wednesday','8',3,1,NULL),(11466,'CSBSL101',8,'L201','Thursday','1',3,1,NULL),(11467,'CSF101',6,'R101','Wednesday','2',3,0,NULL),(11468,'CSF101',6,'R101','Thursday','3',3,0,NULL),(11469,'CSF101',6,'R101','Saturday','3',3,0,NULL),(11470,'CSF102',6,'R102','Monday','3',3,0,NULL),(11471,'CSF102',6,'R102','Wednesday','8',3,0,NULL),(11472,'CSF102',6,'R102','Saturday','7',3,0,NULL),(11473,'CSFL101',9,'L201','Monday','1',3,1,NULL),(11474,'CSFL101',9,'L201','Thursday','6',3,1,NULL),(11475,'CSL101',10,'L201','Thursday','3',3,1,NULL),(11476,'CSL101',10,'L201','Saturday','1',3,1,NULL),(11477,'CSL102',9,'L201','Wednesday','2',3,1,NULL),(11478,'CSL102',9,'L201','Saturday','3',3,1,NULL),(11479,'AIDS101',5,'R103','Monday','3',4,0,NULL),(11480,'AIDS101',5,'R103','Thursday','2',4,0,NULL),(11481,'AIDS101',5,'R103','Saturday','2',4,0,NULL),(11482,'AIDS102',5,'R101','Monday','8',4,0,NULL),(11483,'AIDS102',5,'R101','Friday','3',4,0,NULL),(11484,'AIDS102',5,'R101','Friday','8',4,0,NULL),(11485,'AIDS103',7,'R101','Wednesday','2',4,0,NULL),(11486,'AIDS103',7,'R101','Wednesday','6',4,0,NULL),(11487,'AIDS103',7,'R101','Thursday','4',4,0,NULL),(11488,'AIDS104',7,'R101','Monday','6',4,0,NULL),(11489,'AIDS104',7,'R101','Tuesday','6',4,0,NULL),(11490,'AIDS104',7,'R101','Saturday','8',4,0,NULL),(11491,'AIDS105',1,'R102','Monday','4',4,0,NULL),(11492,'AIDS105',1,'R102','Thursday','6',4,0,NULL),(11493,'AIDS105',1,'R102','Friday','7',4,0,NULL),(11494,'AIDSL101',2,'L201','Monday','7',4,1,NULL),(11495,'AIDSL101',2,'L201','Wednesday','8',4,1,NULL),(11496,'CS101',4,'R103','Wednesday','6',4,0,NULL),(11497,'CS101',4,'R103','Thursday','1',4,0,NULL),(11498,'CS101',4,'R103','Thursday','5',4,0,NULL),(11499,'CS102',3,'R101','Thursday','4',4,0,NULL),(11500,'CS102',3,'R101','Friday','4',4,0,NULL),(11501,'CS102',3,'R101','Saturday','4',4,0,NULL),(11502,'CS103',1,'R101','Monday','7',4,0,NULL),(11503,'CS103',1,'R101','Thursday','2',4,0,NULL),(11504,'CS103',1,'R101','Saturday','1',4,0,NULL),(11505,'CS104',1,'R104','Thursday','2',4,0,NULL),(11506,'CS104',1,'R104','Thursday','6',4,0,NULL),(11507,'CS104',1,'R104','Thursday','8',4,0,NULL),(11508,'CS104',1,'R104','Friday','3',4,0,NULL),(11509,'CS105',4,'R101','Monday','6',4,0,NULL),(11510,'CS105',4,'R101','Thursday','1',4,0,NULL),(11511,'CS105',4,'R101','Friday','6',4,0,NULL),(11512,'CS106',3,'R101','Tuesday','3',4,0,NULL),(11513,'CS106',3,'R101','Tuesday','8',4,0,NULL),(11514,'CS106',3,'R101','Saturday','6',4,0,NULL),(11515,'CS107',3,'R101','Tuesday','5',4,0,NULL),(11516,'CS107',3,'R101','Wednesday','8',4,0,NULL),(11517,'CS107',3,'R101','Thursday','2',4,0,NULL),(11518,'CS108',9,'R102','Monday','7',4,0,NULL),(11519,'CS108',9,'R102','Thursday','7',4,0,NULL),(11520,'CS108',9,'R102','Saturday','8',4,0,NULL),(11521,'CS109',2,'R101','Tuesday','2',4,0,NULL),(11522,'CS109',2,'R101','Thursday','5',4,0,NULL),(11523,'CS109',2,'R101','Friday','3',4,0,NULL),(11524,'CS110',4,'R101','Wednesday','8',4,0,NULL),(11525,'CS110',4,'R101','Thursday','4',4,0,NULL),(11526,'CS110',4,'R101','Thursday','6',4,0,NULL),(11527,'CSBS101',8,'R101','Monday','3',4,0,NULL),(11528,'CSBS101',8,'R101','Saturday','1',4,0,NULL),(11529,'CSBS101',8,'R101','Saturday','7',4,0,NULL),(11530,'CSBS102',8,'R101','Wednesday','7',4,0,NULL),(11531,'CSBS102',8,'R101','Saturday','7',4,0,NULL),(11532,'CSBS102',8,'R101','Saturday','8',4,0,NULL),(11533,'CSBS103',5,'R104','Tuesday','3',4,0,NULL),(11534,'CSBS103',5,'R104','Saturday','3',4,0,NULL),(11535,'CSBS103',5,'R104','Saturday','8',4,0,NULL),(11536,'CSBS104',6,'R101','Monday','5',4,0,NULL),(11537,'CSBS104',6,'R101','Thursday','7',4,0,NULL),(11538,'CSBS104',6,'R101','Saturday','8',4,0,NULL),(11539,'CSBS105',2,'R101','Wednesday','5',4,0,NULL),(11540,'CSBS105',2,'R101','Wednesday','7',4,0,NULL),(11541,'CSBS105',2,'R101','Friday','2',4,0,NULL),(11542,'CSBS106',7,'R101','Tuesday','4',4,0,NULL),(11543,'CSBS106',7,'R101','Thursday','6',4,0,NULL),(11544,'CSBS106',7,'R101','Friday','2',4,0,NULL),(11545,'CSBSL101',8,'L201','Tuesday','5',4,1,NULL),(11546,'CSBSL101',8,'L201','Thursday','7',4,1,NULL),(11547,'CSF101',6,'R101','Tuesday','7',4,0,NULL),(11548,'CSF101',6,'R101','Wednesday','4',4,0,NULL),(11549,'CSF101',6,'R101','Friday','6',4,0,NULL),(11550,'CSF102',6,'R102','Wednesday','6',4,0,NULL),(11551,'CSF102',6,'R102','Friday','7',4,0,NULL),(11552,'CSF102',6,'R102','Saturday','8',4,0,NULL),(11553,'CSFL101',9,'L201','Friday','8',4,1,NULL),(11554,'CSFL101',9,'L201','Saturday','1',4,1,NULL),(11555,'CSL101',10,'L201','Thursday','1',4,1,NULL),(11556,'CSL101',10,'L201','Saturday','8',4,1,NULL),(11557,'CSL102',9,'L201','Monday','2',4,1,NULL),(11558,'CSL102',9,'L201','Tuesday','7',4,1,NULL);
/*!40000 ALTER TABLE `Timetable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('admin','professor','student') NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'amit_admin','952a94b4344b12bd58372052115bfbb2678dbd09f6ef121df859099cecd5c201','amit.admin@university.edu','admin'),(2,'dr_sharma','4ac35643fa7c7d6a0ec426b4c64465943c3bc1111aeaf4f38f9b8328c763168d','sharma@university.edu','professor'),(3,'dr_patel','2b7a7b9b260f63f36afff2ca544cbad38b9975d7619298fa3a7fbebda8ab8026','patel@university.edu','professor'),(4,'dr_verma','5a5fd29783f14054e8661b45386ecbfcb33df72e22a2240a1d5d2444616a496f','verma@university.edu','professor'),(5,'cr_cse2025','d9efad221ecccf49042ce6b86f1ad5a06b4cd371ed9db227f52c068188906371','cr_cse2025@university.edu','student'),(6,'lr_csbs2025','b4990aa86396e17fe07f43dc078aaff50c451c3fe5e6bc728ddb675d2d66c036','lr_csbs2025@university.edu','student'),(7,'Sruja','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','sruja@university.edu','admin'),(8,'Sruja1','c775e7b757ede630cd0aa1113bd102661ab38829ca52a6422ab782862f268646','SRUJA.PISAL@UNIVERSITY.EDU','admin');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `hash_password_before_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    SET NEW.password = SHA2(NEW.password, 256);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `professortimetable`
--

/*!50001 DROP VIEW IF EXISTS `professortimetable`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `professortimetable` AS select `p`.`name` AS `professor`,`t`.`day` AS `day`,`t`.`timeslot` AS `timeslot`,`c`.`name` AS `course`,`r`.`room_no` AS `room_no` from (((`timetable` `t` join `professor` `p` on((`t`.`prof_id` = `p`.`prof_id`))) join `course` `c` on((`t`.`course_code` = `c`.`course_code`))) join `room` `r` on((`t`.`room_no` = `r`.`room_no`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `professortimetableview`
--

/*!50001 DROP VIEW IF EXISTS `professortimetableview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `professortimetableview` AS select `t`.`day` AS `day`,`t`.`timeslot` AS `timeslot`,`p`.`prof_id` AS `prof_id`,`p`.`name` AS `professor_name`,`c`.`name` AS `course_name`,`r`.`room_no` AS `room_no`,`pr`.`name` AS `program_name` from ((((`timetable` `t` join `professor` `p` on((`t`.`prof_id` = `p`.`prof_id`))) join `course` `c` on((`t`.`course_code` = `c`.`course_code`))) join `room` `r` on((`t`.`room_no` = `r`.`room_no`))) join `program` `pr` on((`t`.`program_id` = `pr`.`program_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-19 12:20:06
