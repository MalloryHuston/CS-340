-- MariaDB dump 10.19  Distrib 10.4.25-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_hustonm
-- ------------------------------------------------------
-- Server version	10.6.8-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Artists`
--

DROP TABLE IF EXISTS `Artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Artists` (
  `artistID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(145) NOT NULL,
  `bio` text DEFAULT NULL,
  PRIMARY KEY (`artistID`),
  UNIQUE KEY `artistID_UNIQUE` (`artistID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Artists`
--

LOCK TABLES `Artists` WRITE;
/*!40000 ALTER TABLE `Artists` DISABLE KEYS */;
INSERT INTO `Artists` VALUES (1,'Taylor Swift','American singer-songwriter of multiple genres who sold over 200 million records worldwide.'),(2,'Justin Bieber','Canadian pop singer discovered on YouTube with ten number #1 hits.'),(3,'BTS','A seven-member boy band formed in 2013 in Seoul, South Korea.'),(4,'Miley Cyrus','American singer and actress who began her career as Hannah Montana.');
/*!40000 ALTER TABLE `Artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Categories`
--

DROP TABLE IF EXISTS `Categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Categories` (
  `categoryID` varchar(45),
  PRIMARY KEY (`categoryID`),
  UNIQUE KEY `categoryID_UNIQUE` (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categories`
--

LOCK TABLES `Categories` WRITE;
/*!40000 ALTER TABLE `Categories` DISABLE KEYS */;
INSERT INTO `Categories` VALUES ('Early Bird'),('General Admission'),('Giveaway'),('Group Ticket'),('Reserved Seating'),('Themed Promo Code'),('VIP');
/*!40000 ALTER TABLE `Categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Concerts`
--

DROP TABLE IF EXISTS `Concerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Concerts` (
  `concertID` int(11) NOT NULL AUTO_INCREMENT,
  `concertDate` date NOT NULL,
  `numberOfTickets` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` text NOT NULL,
  `artistID` int(11) NOT NULL,
  PRIMARY KEY (`concertID`),
  UNIQUE KEY `concertID_UNIQUE` (`concertID`),
  KEY `fk_Concerts_Artists1_idx` (`artistID`),
  CONSTRAINT `fk_Concerts_Artists1` FOREIGN KEY (`artistID`) REFERENCES `Artists` (`artistID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Concerts`
--

LOCK TABLES `Concerts` WRITE;
/*!40000 ALTER TABLE `Concerts` DISABLE KEYS */;
INSERT INTO `Concerts` VALUES (1,'2022-07-01',5000,'Folklore: Live in Concert','A live performance of all tracks from the Folklore album.',1),(2,'2022-06-17',3891,'Where Are You Now','A live performance of all the greatest JB hits.',2),(3,'2022-05-13',4276,'BTS - Dynamite LIVE','The best k-pop concert in the world.',3),(4,'2022-04-29',4891,'Farewell Hannah Montana','Say hello to the new Miley Cyrus.',4);
/*!40000 ALTER TABLE `Concerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Concerts_Employees`
--

DROP TABLE IF EXISTS `Concerts_Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Concerts_Employees` (
  `concert_employeeID` int(11) NOT NULL AUTO_INCREMENT,
  `employeeID` int(11) NOT NULL,
  `concertID` int(11) NOT NULL,
  PRIMARY KEY (`concert_employeeID`),
  UNIQUE KEY `concert_employeeID_UNIQUE` (`concert_employeeID`),
  KEY `fk_Employees_has_Concerts_Concerts1_idx` (`concertID`),
  KEY `fk_Employees_has_Concerts_Employees1_idx` (`employeeID`),
  CONSTRAINT `fk_Employees_has_Concerts_Concerts1` FOREIGN KEY (`concertID`) REFERENCES `Concerts` (`concertID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Employees_has_Concerts_Employees1` FOREIGN KEY (`employeeID`) REFERENCES `Employees` (`employeeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Concerts_Employees`
--

LOCK TABLES `Concerts_Employees` WRITE;
/*!40000 ALTER TABLE `Concerts_Employees` DISABLE KEYS */;
INSERT INTO `Concerts_Employees` VALUES (1,4,1),(2,3,1),(3,1,2),(4,2,2),(5,3,3),(6,1,3),(7,4,4),(8,2,4);
/*!40000 ALTER TABLE `Concerts_Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employees` (
  `employeeID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phoneNumber` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeID`),
  UNIQUE KEY `employeeID_UNIQUE` (`employeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (1,'Mike','Bailey','Security Officer','mbailey475@gmail.com','(487)231-0842'),(2,'Wanda','Sykes','Sound Engineer','wsykes1964@hotmail.com','(333)377-5592'),(3,'Harry','Styles','Ticket Vendor','hstyles1d@yahoo.com','(774)002-0251'),(4,'Lisa','Kudrow','Event Planner','lkudrow1994@outlook.com','(251)812-8883');
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fans`
--

DROP TABLE IF EXISTS `Fans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Fans` (
  `fanID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `streetAddress` varchar(145) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zipCode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`fanID`),
  UNIQUE KEY `fanID_UNIQUE` (`fanID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fans`
--

LOCK TABLES `Fans` WRITE;
/*!40000 ALTER TABLE `Fans` DISABLE KEYS */;
INSERT INTO `Fans` VALUES (1,'Ryan','Reynolds','theryanreynolds@gmail.com','(553)167-4577','310 Gosling Way','Madison','WI','53558'),(2,'Vanessa','Hudgens','vhudgens2005@yahoo.com','(614)697-1403','80 Pomegranate Street','Madison','WI','53701'),(3,'Danny','DeVito','dannymyman@hotmail.com','(612)778-5977','2006 Sunshine Avenue','Green Bay','WI','54229'),(4,'Betty','White','goldengirl1922@outlook.com','(860)870-1880','12 Rodgers Road','Green Bay','WI','54301');
/*!40000 ALTER TABLE `Fans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tickets`
--

DROP TABLE IF EXISTS `Tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tickets` (
  `ticketID` int(11) NOT NULL AUTO_INCREMENT,
  `duration` int(11) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `concertID` int(11) NOT NULL,
  `fanID` int(11) NOT NULL,
  `categoryID` varchar(45),
  PRIMARY KEY (`ticketID`),
  UNIQUE KEY `ticketID_UNIQUE` (`ticketID`),
  KEY `fk_Tickets_Concerts1_idx` (`concertID`),
  KEY `fk_Tickets_Fans1_idx` (`fanID`),
  KEY `fk_Tickets_Categories1_idx` (`categoryID`),
  CONSTRAINT `fk_Tickets_Categories1` FOREIGN KEY (`categoryID`) REFERENCES `Categories` (`categoryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Tickets_Concerts1` FOREIGN KEY (`concertID`) REFERENCES `Concerts` (`concertID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Tickets_Fans1` FOREIGN KEY (`fanID`) REFERENCES `Fans` (`fanID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tickets`
--

LOCK TABLES `Tickets` WRITE;
/*!40000 ALTER TABLE `Tickets` DISABLE KEYS */;
INSERT INTO `Tickets` VALUES (1,120,750.20,2,1,'Reserved Seating'),(2,180,NULL,4,3,'Giveaway'),(3,200,999.00,1,4,'Group Ticket'),(4,150,400.30,3,2,'Themed Promo Code'),(5,150,250.00,3,3,'General Admission'),(6,230,NULL,1,1,'Giveaway'),(7,135,775.00,2,2,'Reserved Seating'),(8,170,500.50,2,3,'Early Bird'),(9,210,1500.00,1,2,'VIP'),(10,195,1250.00,3,4,'VIP');
/*!40000 ALTER TABLE `Tickets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-06 10:46:40
