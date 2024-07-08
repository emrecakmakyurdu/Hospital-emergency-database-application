CREATE DATABASE  IF NOT EXISTS `emre_cakmakyurdu` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `emre_cakmakyurdu`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: localhost    Database: emre_cakmakyurdu
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Temporary view structure for view `dashboardanalytics`
--

DROP TABLE IF EXISTS `dashboardanalytics`;
/*!50001 DROP VIEW IF EXISTS `dashboardanalytics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `dashboardanalytics` AS SELECT 
 1 AS `Department`,
 1 AS `TotalPatients`,
 1 AS `AverageEmergencyScore`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Department` (
  `DepartmentID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `PatientCount` int DEFAULT NULL,
  PRIMARY KEY (`DepartmentID`),
  UNIQUE KEY `DepartmentID_UNIQUE` (`DepartmentID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (1,'Cardiology','77556 Effie Knoll Apt. 333\nUrsulastad, AR 90221-3561',89791),(2,'Dermatology','9257 Christop Island Suite 519\nSouth Lizzieberg, AR 80610-3853',15913),(3,'General Surgery','3061 Agustina Ports\nNew Christa, ME 11609',726484),(4,'Neurology','625 Amely Forges\nNorth Jacquesstad, GA 99678-6564',957987853),(5,'Orthopedy','04537 Duncan Inlet Apt. 551\nSigurdmouth, NY 06840-5682',0);
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EmergencyLevel`
--

DROP TABLE IF EXISTS `EmergencyLevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EmergencyLevel` (
  `EmergencyLevelID` int NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) DEFAULT NULL,
  `PriorityScore` int NOT NULL,
  PRIMARY KEY (`EmergencyLevelID`),
  UNIQUE KEY `EmergencyLevelID_UNIQUE` (`EmergencyLevelID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EmergencyLevel`
--

LOCK TABLES `EmergencyLevel` WRITE;
/*!40000 ALTER TABLE `EmergencyLevel` DISABLE KEYS */;
INSERT INTO `EmergencyLevel` VALUES (1,'High Risk',4),(2,'Medium Risk',3),(3,'Very High Risk',5),(4,'Low Risk',2),(5,'Very Low Risk',1);
/*!40000 ALTER TABLE `EmergencyLevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MedicalSpecialist`
--

DROP TABLE IF EXISTS `MedicalSpecialist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MedicalSpecialist` (
  `SpecialistID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `DepartmentID` int DEFAULT NULL,
  `Qualification` varchar(45) DEFAULT NULL,
  `YearsofExperience` int DEFAULT NULL,
  PRIMARY KEY (`SpecialistID`),
  UNIQUE KEY `SpecialistID_UNIQUE` (`SpecialistID`),
  KEY `DepartmentID_idx` (`DepartmentID`),
  CONSTRAINT `DepartmentID` FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MedicalSpecialist`
--

LOCK TABLES `MedicalSpecialist` WRITE;
/*!40000 ALTER TABLE `MedicalSpecialist` DISABLE KEYS */;
INSERT INTO `MedicalSpecialist` VALUES (1,'sint',1,'Dicta est velit modi dignissimos voluptas sap',2),(2,'nobis',2,'Nihil maiores earum et et et quidem dicta.',8),(3,'facere',3,'Officiis pariatur rerum et a est eum sequi ex',5),(4,'consequuntur',4,'Ducimus soluta qui aut ut ea.',2),(5,'et',5,'Provident dicta quia expedita illo sunt maior',9);
/*!40000 ALTER TABLE `MedicalSpecialist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient`
--

DROP TABLE IF EXISTS `Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient` (
  `PatientID` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(255) DEFAULT NULL,
  `DateofBirth` datetime DEFAULT NULL,
  `Gender` varchar(45) DEFAULT NULL,
  `Address` varchar(45) DEFAULT NULL,
  `Phone` varchar(45) DEFAULT NULL,
  `AvgPriorityScore` float DEFAULT NULL,
  PRIMARY KEY (`PatientID`),
  UNIQUE KEY `PatientID_UNIQUE` (`PatientID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient`
--

LOCK TABLES `Patient` WRITE;
/*!40000 ALTER TABLE `Patient` DISABLE KEYS */;
INSERT INTO `Patient` VALUES (1,'Aliye Arın','1990-08-30 15:21:56','Mr.','Kutay İş Hanı 600\n04343 Gümüşhane','05106165178',4),(2,'Tuna Emirhan','2014-05-20 06:45:33','Mr.','Meriç Kavşağı 9\n26679 Osmaniye','05729254542',4.66667),(3,'Meriç Emre','1971-11-04 01:11:06','Mr.','Çağan İş Hanı 849\n70601 Balıkesir','05679745704',2),(4,'Meriç Doruk','1998-03-11 13:20:46','Mr.','Göktürk İş Hanı 972\n07705 Çankırı','08894456578',4),(5,'Meriç Berk','1990-11-27 16:33:51','Mr.','Türker İş Hanı 97\n45316 Malatya','05236172414',2),(6,'Alp Tuna','1976-07-17 05:36:27','Mr.','Ferid Caddesi 055\n08973 Kırklareli','08381785031',4),(7,'Atakan Burak','2023-09-23 06:16:40','Mr.','Çınar Caddesi 40\n49657 Çankırı','05541731794',5),(8,'Rüzgar Emirhan','1970-09-04 08:51:17','Mr.','Meriç Mevkii 11\n79890 Hatay','06100177871',2),(9,'Fatimah Doruk','1982-05-16 08:10:05','Mr.','Burak Caddesi 05\n23476 Adıyaman','05768485416',2),(10,'Armağan Bora','2004-05-22 11:02:41','Mr.','Emirhan İş Hanı 45\n78960 Aydın','05324687576',5),(11,'Kağan Tuna','2015-04-12 13:42:44','Mr.','Yiğit Durağı 4\n24837 Ankara','04389516181',2),(12,'Deniz Utku','1997-05-21 02:46:17','Mr.','Emirhan Kavşağı 3\n95042 Samsun','07598469502',3),(13,'Meriç Utku','2016-07-05 14:49:43','Mr.','Ferid Kavşağı 195\n76437 Burdur','05150133719',3),(14,'Polat Tuna','1982-03-18 06:03:32','Mr.','Meriç Caddesi 4\n93151 Kırıkkale','05262681650',2),(15,'Türker Onur','2009-03-04 11:48:45','Mr.','Yağız Sokak 277\n57793 Düzce','07506625934',2),(16,'Naila Mert','1999-06-14 23:26:59','Mr.','Ada İş Hanı 526\n23060 Sakarya','07118006429',4),(17,'Alp Efe','2017-11-06 08:58:45','Mr.','Naila İş Hanı 1\n22305 Kastamonu','02682598430',2),(18,'Ali Çınar','2001-06-06 05:26:43','Mr.','Utku Caddesi 2\n27671 Bartın','01591134123',5),(19,'Utku Baran','1983-03-30 19:16:56','Mr.','Berk Durağı 389\n62898 Aydın','08388309478',2),(20,'Derin Göktürk','2005-08-11 02:38:22','Mr.','Fatimah Durağı 67\n50619 Diyarbakır','05677208147',5),(21,'Sarila Şükür','1972-08-17 11:03:01','Mr.','Aliye Sokak 35\n23812 Hakkari','05610466141',2),(22,'Baran Armağan','1995-09-27 18:19:57','Mr.','Mövsümov Durağı 76\n97060 İzmir','05510695196',4),(23,'Rasha Berk','2023-12-30 16:50:33','Mr.','Tuna Durağı 8\n58187 Manisa','04454717072',2),(24,'Serhan Berkay','2003-02-08 10:15:01','Mr.','Derin İş Hanı 376\n05869 Van','04305025997',4),(25,'Zeynep Berkay','2016-06-27 21:17:12','Mr.','Rasha Mevkii 4\n44683 Elazığ','09113110526',2),(26,'Ferid Mövsümov','1978-11-27 10:37:44','Mr.','Yiğit İş Hanı 9\n04846 Adıyaman','04981466974',5),(27,'Zeynep Kağan','1993-03-05 05:58:06','Mr.','Şentürk Sokak 27\n14003 Afyon','03711263520',3),(28,'Sarila Koray','2023-02-04 08:47:36','Mr.','Arın Durağı 3\n64127 Ordu','06132405162',2),(29,'Sarila Kutay','1980-02-15 14:07:58','Mr.','Meriç Mevkii 53\n21093 Bursa','05550918137',4),(30,'Arın Yağız','2022-07-05 22:57:50','Mr.','Barlas Mevkii 5\n17975 Iğdır','05196767987',3),(31,'emre','2022-07-05 22:57:50','Mr.','skdfksdg','05421457118',4);
/*!40000 ALTER TABLE `Patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PatientAssignment`
--

DROP TABLE IF EXISTS `PatientAssignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PatientAssignment` (
  `AssignmentID` int NOT NULL AUTO_INCREMENT,
  `VisitID` int DEFAULT NULL,
  `SpecialistID` int DEFAULT NULL,
  `AssignmnetDate` datetime DEFAULT NULL,
  PRIMARY KEY (`AssignmentID`),
  UNIQUE KEY `AssignmentID_UNIQUE` (`AssignmentID`),
  KEY `VisitID_idx` (`VisitID`),
  KEY `SpecialistID_idx` (`SpecialistID`),
  CONSTRAINT `SpecialistID` FOREIGN KEY (`SpecialistID`) REFERENCES `MedicalSpecialist` (`SpecialistID`),
  CONSTRAINT `VisitID` FOREIGN KEY (`VisitID`) REFERENCES `Visit` (`VisitID`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PatientAssignment`
--

LOCK TABLES `PatientAssignment` WRITE;
/*!40000 ALTER TABLE `PatientAssignment` DISABLE KEYS */;
INSERT INTO `PatientAssignment` VALUES (1,1,1,'2009-05-17 17:10:56'),(2,2,2,'1973-11-29 15:15:22'),(3,3,3,'2001-12-27 21:50:14'),(4,4,4,'1995-08-04 10:41:23'),(5,5,5,'1976-09-12 04:22:53'),(6,6,1,'1997-08-24 20:51:41'),(7,7,2,'2001-10-15 11:39:10'),(8,8,3,'1977-11-13 04:23:11'),(9,9,4,'2013-04-17 15:24:56'),(10,10,5,'2008-08-14 04:02:19'),(11,11,1,'2023-04-25 15:17:19'),(12,12,2,'2005-07-22 23:37:25'),(13,13,3,'1983-12-22 16:50:04'),(14,14,4,'2010-02-21 08:37:25'),(15,15,5,'1971-03-02 08:29:22'),(16,16,1,'2006-03-16 17:35:08'),(17,17,2,'2016-06-23 15:28:13'),(18,18,3,'2010-10-11 02:27:55'),(19,19,4,'1992-07-21 15:28:54'),(20,20,5,'1983-04-19 11:32:48'),(21,21,1,'2007-05-07 08:18:07'),(22,22,2,'1978-02-03 08:37:56'),(23,23,3,'1970-05-12 23:19:23'),(24,24,4,'1980-04-13 12:09:22'),(25,25,5,'2021-11-18 20:26:33'),(26,26,1,'1995-08-02 06:23:59'),(27,27,2,'1993-08-21 04:24:36'),(28,28,3,'2014-09-26 21:53:00'),(29,29,4,'1982-06-25 00:10:31'),(30,30,5,'1972-03-15 14:11:58'),(31,31,3,'1972-03-15 14:11:58'),(32,31,4,'1972-03-15 14:11:58');
/*!40000 ALTER TABLE `PatientAssignment` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `UpdatePatientCount` AFTER INSERT ON `patientassignment` FOR EACH ROW BEGIN
    DECLARE deptID INT;
    SELECT DepartmentID INTO deptID FROM MedicalSpecialist WHERE SpecialistID = NEW.SpecialistID;
    UPDATE Department
    SET PatientCount = PatientCount + 1
    WHERE DepartmentID = deptID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Visit`
--

DROP TABLE IF EXISTS `Visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Visit` (
  `VisitID` int NOT NULL AUTO_INCREMENT,
  `PatientID` int DEFAULT NULL,
  `VisitDate` datetime DEFAULT NULL,
  `Purpose` varchar(255) DEFAULT NULL,
  `EmergencyLevelID` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`VisitID`),
  UNIQUE KEY `VisiID_UNIQUE` (`VisitID`),
  KEY `PatientID_idx` (`PatientID`),
  CONSTRAINT `PatientID` FOREIGN KEY (`PatientID`) REFERENCES `Patient` (`PatientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Visit`
--

LOCK TABLES `Visit` WRITE;
/*!40000 ALTER TABLE `Visit` DISABLE KEYS */;
INSERT INTO `Visit` VALUES (1,1,'2000-02-13 08:16:44','Alice remained looking thoughtfully at the door-- Pray, what is the capital of Rome, and Rome--no, THAT\'S all wrong, I\'m certain! I must sugar my hair.\" As a duck with its legs hanging down, but.','1'),(2,2,'2021-02-05 23:43:56','I used to queer things happening. While she was as long as you liked.\' \'Is that the best of educations--in fact, we went to school every day--\' \'I\'VE been to her, And mentioned me to introduce it.\'.','3'),(3,3,'2010-07-22 15:46:40','I do wonder what you\'re talking about,\' said Alice. \'I\'ve tried every way, and the White Rabbit returning, splendidly dressed, with a T!\' said the King. Here one of the Gryphon, \'she wants for to.','5'),(4,4,'2010-04-16 20:36:14','Alice; not that she did not appear, and after a fashion, and this was of very little use without my shoulders. Oh, how I wish I had our Dinah here, I know all sorts of little cartwheels, and the.','1'),(5,5,'2014-11-18 12:00:54','YOU must cross-examine THIS witness.\' \'Well, if I might venture to ask the question?\' said the Queen, in a rather offended tone, \'was, that the Queen was silent. The Dormouse had closed its eyes.','4'),(6,6,'2010-05-15 17:03:57','And yesterday things went on so long since she had not a regular rule: you invented it just at present--at least I know I do!\' said Alice indignantly. \'Ah! then yours wasn\'t a bit afraid of.','1'),(7,7,'1987-12-08 01:43:08','Cheshire cat,\' said the Mouse. \'Of course,\' the Mock Turtle is.\' \'It\'s the thing Mock Turtle is.\' \'It\'s the first to speak. \'What size do you want to stay in here any longer!\' She waited for a good.','3'),(8,8,'2012-01-04 11:03:15','There were doors all round her head. \'If I eat or drink anything; so I\'ll just see what I was going to give the hedgehog had unrolled itself, and was coming to, but it said in a trembling voice:--.','5'),(9,9,'2003-12-06 01:42:14','Will you, won\'t you, won\'t you, will you join the dance? \"You can really have no idea how confusing it is to find quite a chorus of voices asked. \'Why, SHE, of course,\' said the Mouse. \'Of course,\'.','4'),(10,10,'1998-08-27 16:00:58','Alice. \'And ever since that,\' the Hatter went on, half to Alice. \'Only a thimble,\' said Alice in a whisper.) \'That would be grand, certainly,\' said Alice, \'it\'s very rude.\' The Hatter shook his head.','3'),(11,11,'2020-11-08 03:49:01','I was a general clapping of hands at this: it was certainly too much of a treacle-well--eh, stupid?\' \'But they were nowhere to be done, I wonder?\' Alice guessed who it was, even before she found she.','5'),(12,12,'1973-09-01 12:29:46','Five, who had been of late much accustomed to usurpation and conquest. Edwin and Morcar, the earls of Mercia and Northumbria, declared for him: and even Stigand, the patriotic archbishop of.','2'),(13,13,'2000-12-09 10:40:16','All this time with great emphasis, looking hard at Alice the moment she appeared; but she could not stand, and she jumped up and beg for its dinner, and all her life. Indeed, she had but to her.','2'),(14,14,'1991-04-30 10:50:38','Mind now!\' The poor little thing grunted in reply (it had left off quarrelling with the Queen, and Alice, were in custody and under sentence of execution.\' \'What for?\' said the Gryphon. \'We can do.','4'),(15,15,'1983-06-30 08:01:39','Bill! catch hold of this rope--Will the roof of the words all coming different, and then at the great question certainly was, what? Alice looked down into a pig,\' Alice quietly said, just as if he.','5'),(16,16,'2019-07-17 19:55:53','I know is, something comes at me like that!\' But she did not like the right size again; and the sounds will take care of the March Hare had just succeeded in curving it down into its eyes again, to.','1'),(17,17,'2022-09-08 23:44:49','RED rose-tree, and we won\'t talk about wasting IT. It\'s HIM.\' \'I don\'t much care where--\' said Alice. \'I\'ve so often read in the same side of WHAT? The other guests had taken his watch out of his.','5'),(18,18,'1986-10-03 05:46:02','WAISTCOAT-POCKET, and looked at it, and they can\'t prove I did: there\'s no meaning in it.\' The jury all wrote down all three dates on their slates, and then unrolled the parchment scroll, and read.','3'),(19,19,'1979-02-10 19:32:47','Shall I try the first verse,\' said the Duchess, it had finished this short speech, they all crowded round her head. Still she went out, but it all came different!\' Alice replied in an offended tone,.','4'),(20,20,'1982-02-26 02:15:11','I hadn\'t begun my tea--not above a week or so--and what with the glass table as before, \'and things are worse than ever,\' thought the poor child, \'for I can\'t get out again. That\'s all.\' \'Thank.','3'),(21,21,'1972-05-04 10:52:45','I shall have to fly; and the party went back to yesterday, because I was thinking I should frighten them out of the shelves as she left her, leaning her head pressing against the roof of the.','4'),(22,22,'1987-11-13 04:23:43','Queen. \'Well, I can\'t get out again. Suddenly she came in with a soldier on each side to guard him; and near the door, and the two creatures got so much contradicted in her life, and had no pictures.','1'),(23,23,'2002-07-21 06:23:57','I must have prizes.\' \'But who is to give the hedgehog to, and, as there was a treacle-well.\' \'There\'s no such thing!\' Alice was rather glad there WAS no one listening, this time, sat down and cried..','5'),(24,24,'2007-12-26 12:13:18','He got behind him, and said nothing. \'This here young lady,\' said the Cat. \'I don\'t think it\'s at all comfortable, and it sat for a baby: altogether Alice did not venture to ask his neighbour to.','1'),(25,25,'1978-05-18 02:13:47','Alice, and she went in search of her ever getting out of his Normans--\" How are you getting on now, my dear?\' it continued, turning to the other queer noises, would change to tinkling sheep-bells,.','4'),(26,26,'1986-07-03 22:50:54','Hatter. He had been anxiously looking across the field after it, never once considering how in the flurry of the players to be two people! Why, there\'s hardly enough of it in with the Queen,\' and.','3'),(27,27,'2022-03-05 20:42:50','While she was not here before,\' said Alice,) and round goes the clock in a great deal of thought, and rightly too, that very few little girls eat eggs quite as much right,\' said the Mock Turtle Soup.','2'),(28,28,'2017-09-11 23:59:22','Alice, very loudly and decidedly, and there stood the Queen was in March.\' As she said to Alice, and sighing. \'It IS the same words as before, \'and things are \"much of a treacle-well--eh, stupid?\'.','5'),(29,29,'2021-03-08 07:19:43','First, she tried another question. \'What sort of present!\' thought Alice. \'I\'m glad they don\'t seem to put down her anger as well go in at the March Hare moved into the garden with one finger; and.','1'),(30,30,'1990-01-06 01:56:12','T!\' said the Pigeon; \'but if you\'ve seen them so shiny?\' Alice looked very uncomfortable. The first thing I\'ve got to the other, trying every door, she ran off as hard as it spoke (it was Bill, the.','4'),(31,30,'2021-03-08 07:19:43','adfadg','3'),(32,1,'2000-02-13 08:16:44','Alice remained looking thoughtfully at the door-- Pray, what is the capital of Rome, and Rome--no, THAT\'S all wrong, I\'m certain! I must sugar my hair.\" As a duck with its legs hanging down, but.','1'),(33,2,'2021-02-05 23:43:56','I used to queer things happening. While she was as long as you liked.\' \'Is that the best of educations--in fact, we went to school every day--\' \'I\'VE been to her, And mentioned me to introduce it.\'.','3'),(34,3,'2010-07-22 15:46:40','I do wonder what you\'re talking about,\' said Alice. \'I\'ve tried every way, and the White Rabbit returning, splendidly dressed, with a T!\' said the King. Here one of the Gryphon, \'she wants for to.','5'),(35,4,'2010-04-16 20:36:14','Alice; not that she did not appear, and after a fashion, and this was of very little use without my shoulders. Oh, how I wish I had our Dinah here, I know all sorts of little cartwheels, and the.','1'),(36,5,'2014-11-18 12:00:54','YOU must cross-examine THIS witness.\' \'Well, if I might venture to ask the question?\' said the Queen, in a rather offended tone, \'was, that the Queen was silent. The Dormouse had closed its eyes.','4'),(37,6,'2010-05-15 17:03:57','And yesterday things went on so long since she had not a regular rule: you invented it just at present--at least I know I do!\' said Alice indignantly. \'Ah! then yours wasn\'t a bit afraid of.','1'),(38,7,'1987-12-08 01:43:08','Cheshire cat,\' said the Mouse. \'Of course,\' the Mock Turtle is.\' \'It\'s the thing Mock Turtle is.\' \'It\'s the first to speak. \'What size do you want to stay in here any longer!\' She waited for a good.','3'),(39,8,'2012-01-04 11:03:15','There were doors all round her head. \'If I eat or drink anything; so I\'ll just see what I was going to give the hedgehog had unrolled itself, and was coming to, but it said in a trembling voice:--.','5'),(40,9,'2003-12-06 01:42:14','Will you, won\'t you, won\'t you, will you join the dance? \"You can really have no idea how confusing it is to find quite a chorus of voices asked. \'Why, SHE, of course,\' said the Mouse. \'Of course,\'.','4'),(41,10,'1998-08-27 16:00:58','Alice. \'And ever since that,\' the Hatter went on, half to Alice. \'Only a thimble,\' said Alice in a whisper.) \'That would be grand, certainly,\' said Alice, \'it\'s very rude.\' The Hatter shook his head.','3'),(42,11,'2020-11-08 03:49:01','I was a general clapping of hands at this: it was certainly too much of a treacle-well--eh, stupid?\' \'But they were nowhere to be done, I wonder?\' Alice guessed who it was, even before she found she.','5'),(43,12,'1973-09-01 12:29:46','Five, who had been of late much accustomed to usurpation and conquest. Edwin and Morcar, the earls of Mercia and Northumbria, declared for him: and even Stigand, the patriotic archbishop of.','2'),(44,13,'2000-12-09 10:40:16','All this time with great emphasis, looking hard at Alice the moment she appeared; but she could not stand, and she jumped up and beg for its dinner, and all her life. Indeed, she had but to her.','2'),(45,14,'1991-04-30 10:50:38','Mind now!\' The poor little thing grunted in reply (it had left off quarrelling with the Queen, and Alice, were in custody and under sentence of execution.\' \'What for?\' said the Gryphon. \'We can do.','4'),(46,15,'1983-06-30 08:01:39','Bill! catch hold of this rope--Will the roof of the words all coming different, and then at the great question certainly was, what? Alice looked down into a pig,\' Alice quietly said, just as if he.','5'),(47,16,'2019-07-17 19:55:53','I know is, something comes at me like that!\' But she did not like the right size again; and the sounds will take care of the March Hare had just succeeded in curving it down into its eyes again, to.','1'),(48,17,'2022-09-08 23:44:49','RED rose-tree, and we won\'t talk about wasting IT. It\'s HIM.\' \'I don\'t much care where--\' said Alice. \'I\'ve so often read in the same side of WHAT? The other guests had taken his watch out of his.','5'),(49,18,'1986-10-03 05:46:02','WAISTCOAT-POCKET, and looked at it, and they can\'t prove I did: there\'s no meaning in it.\' The jury all wrote down all three dates on their slates, and then unrolled the parchment scroll, and read.','3'),(50,19,'1979-02-10 19:32:47','Shall I try the first verse,\' said the Duchess, it had finished this short speech, they all crowded round her head. Still she went out, but it all came different!\' Alice replied in an offended tone,.','4'),(51,20,'1982-02-26 02:15:11','I hadn\'t begun my tea--not above a week or so--and what with the glass table as before, \'and things are worse than ever,\' thought the poor child, \'for I can\'t get out again. That\'s all.\' \'Thank.','3'),(52,21,'1972-05-04 10:52:45','I shall have to fly; and the party went back to yesterday, because I was thinking I should frighten them out of the shelves as she left her, leaning her head pressing against the roof of the.','4'),(53,22,'1987-11-13 04:23:43','Queen. \'Well, I can\'t get out again. Suddenly she came in with a soldier on each side to guard him; and near the door, and the two creatures got so much contradicted in her life, and had no pictures.','1'),(54,23,'2002-07-21 06:23:57','I must have prizes.\' \'But who is to give the hedgehog to, and, as there was a treacle-well.\' \'There\'s no such thing!\' Alice was rather glad there WAS no one listening, this time, sat down and cried..','5'),(55,24,'2007-12-26 12:13:18','He got behind him, and said nothing. \'This here young lady,\' said the Cat. \'I don\'t think it\'s at all comfortable, and it sat for a baby: altogether Alice did not venture to ask his neighbour to.','1'),(56,25,'1978-05-18 02:13:47','Alice, and she went in search of her ever getting out of his Normans--\" How are you getting on now, my dear?\' it continued, turning to the other queer noises, would change to tinkling sheep-bells,.','4'),(57,26,'1986-07-03 22:50:54','Hatter. He had been anxiously looking across the field after it, never once considering how in the flurry of the players to be two people! Why, there\'s hardly enough of it in with the Queen,\' and.','3'),(58,27,'2022-03-05 20:42:50','While she was not here before,\' said Alice,) and round goes the clock in a great deal of thought, and rightly too, that very few little girls eat eggs quite as much right,\' said the Mock Turtle Soup.','2'),(59,28,'2017-09-11 23:59:22','Alice, very loudly and decidedly, and there stood the Queen was in March.\' As she said to Alice, and sighing. \'It IS the same words as before, \'and things are \"much of a treacle-well--eh, stupid?\'.','5'),(60,29,'2021-03-08 07:19:43','First, she tried another question. \'What sort of present!\' thought Alice. \'I\'m glad they don\'t seem to put down her anger as well go in at the March Hare moved into the garden with one finger; and.','1'),(61,30,'1990-01-06 01:56:12','T!\' said the Pigeon; \'but if you\'ve seen them so shiny?\' Alice looked very uncomfortable. The first thing I\'ve got to the other, trying every door, she ran off as hard as it spoke (it was Bill, the.','4'),(62,31,'1990-01-06 01:56:12','dgsgs','2');
/*!40000 ALTER TABLE `Visit` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `CheckVisitCardinality` BEFORE INSERT ON `visit` FOR EACH ROW BEGIN
    IF (SELECT COUNT(*) FROM Visit WHERE PatientID = NEW.PatientID) >= 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exceeds maximum allowed visits per patient';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `UpdatePatientAvgPriorityAfterVisitInsert` AFTER INSERT ON `visit` FOR EACH ROW BEGIN
    UPDATE Patient
    SET AvgPriorityScore = (
        SELECT AVG(EmergencyLevel.PriorityScore)
        FROM Visit
        INNER JOIN EmergencyLevel ON Visit.EmergencyLevelID = EmergencyLevel.EmergencyLevelID
        WHERE Visit.PatientID = NEW.PatientID
    )
    WHERE Patient.PatientID = NEW.PatientID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'emre_cakmakyurdu'
--

--
-- Dumping routines for database 'emre_cakmakyurdu'
--

--
-- Final view structure for view `dashboardanalytics`
--

/*!50001 DROP VIEW IF EXISTS `dashboardanalytics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dashboardanalytics` AS select `d`.`Name` AS `Department`,count(distinct `v`.`PatientID`) AS `TotalPatients`,avg(`e`.`PriorityScore`) AS `AverageEmergencyScore` from ((((`department` `d` join `medicalspecialist` `m` on((`d`.`DepartmentID` = `m`.`DepartmentID`))) join `patientassignment` `pa` on((`m`.`SpecialistID` = `pa`.`SpecialistID`))) join `visit` `v` on((`pa`.`VisitID` = `v`.`VisitID`))) join `emergencylevel` `e` on((`v`.`EmergencyLevelID` = `e`.`EmergencyLevelID`))) group by `d`.`Name` */;
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

-- Dump completed on 2024-01-10  4:49:32
