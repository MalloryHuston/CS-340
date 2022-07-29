-- MariaDB dump 10.19  Distrib 10.4.25-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_diagours
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
  `phoneNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`artistID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Artists`
--

LOCK TABLES `Artists` WRITE;
/*!40000 ALTER TABLE `Artists` DISABLE KEYS */;
INSERT INTO `Artists` VALUES (1,'Taylor Swift',2147483647),(3,'Justin Bieber',2147483647),(7,'BTS',2147483647);
/*!40000 ALTER TABLE `Artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Concerts`
--

DROP TABLE IF EXISTS `Concerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Concerts` (
  `concertID` int(11) NOT NULL AUTO_INCREMENT,
  `concertDate` date DEFAULT NULL,
  `numberOfTickets` int(11) DEFAULT NULL,
  PRIMARY KEY (`concertID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Concerts`
--

LOCK TABLES `Concerts` WRITE;
/*!40000 ALTER TABLE `Concerts` DISABLE KEYS */;
INSERT INTO `Concerts` VALUES (1,'2022-07-01',5000),(3,'2022-06-17',3891),(6,'2022-05-13',4276);
/*!40000 ALTER TABLE `Concerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Concerts_has_Artists`
--

DROP TABLE IF EXISTS `Concerts_has_Artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Concerts_has_Artists` (
  `concertID` int(11) NOT NULL,
  `artistID` int(11) NOT NULL,
  KEY `fk_Concerts_has_Artists_Concerts1_idx` (`concertID`),
  KEY `fk_Concerts_has_Artists_Artists1_idx` (`artistID`,`concertID`),
  CONSTRAINT `fk_Concerts_has_Artists_artistID` FOREIGN KEY (`artistID`) REFERENCES `Artists` (`artistID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Concerts_has_Artists_concertID` FOREIGN KEY (`concertID`) REFERENCES `Concerts` (`concertID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Concerts_has_Artists`
--

LOCK TABLES `Concerts_has_Artists` WRITE;
/*!40000 ALTER TABLE `Concerts_has_Artists` DISABLE KEYS */;
INSERT INTO `Concerts_has_Artists` VALUES (6,1),(1,3),(3,7);
/*!40000 ALTER TABLE `Concerts_has_Artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Concerts_has_Employees`
--

DROP TABLE IF EXISTS `Concerts_has_Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Concerts_has_Employees` (
  `concertID` int(11) NOT NULL AUTO_INCREMENT,
  `employeeID` int(11) NOT NULL,
  KEY `fk_Concerts_has_Employees_Employees1_idx` (`employeeID`),
  KEY `fk_Concerts_has_Employees_Concerts1_idx` (`concertID`),
  CONSTRAINT `fk_Concerts_has_Employees_Concerts1` FOREIGN KEY (`concertID`) REFERENCES `Concerts` (`concertID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Concerts_has_Employees_Employees1` FOREIGN KEY (`employeeID`) REFERENCES `Employees` (`employeeID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Concerts_has_Employees`
--

LOCK TABLES `Concerts_has_Employees` WRITE;
/*!40000 ALTER TABLE `Concerts_has_Employees` DISABLE KEYS */;
INSERT INTO `Concerts_has_Employees` VALUES (1,6),(1,9),(3,1),(3,6),(6,1),(6,4);
/*!40000 ALTER TABLE `Concerts_has_Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employees` (
  `employeeID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phoneNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`employeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (1,'Mike','Bailey','Security Officer','mbailey475@gmail.com',2147483647),(4,'Wanda','Sykes','Sound Engineer','wsykes1964@hotmail.com',2104920033),(6,'Harry','Styles','Ticket Vendor','hstyles1d@yahoo.com',2147483647),(9,'Lisa','Kudrow','Event Planner','lkudrow1994@outlook.com',2147483647);
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
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phoneNumber` int(11) DEFAULT NULL,
  `streetAddress` varchar(145) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zipCode` int(11) DEFAULT NULL,
  PRIMARY KEY (`fanID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fans`
--

LOCK TABLES `Fans` WRITE;
/*!40000 ALTER TABLE `Fans` DISABLE KEYS */;
INSERT INTO `Fans` VALUES (1,'Ryan','Reynolds','theryanreynolds@gmail.com',2147483647,'310 Gosling Way','Madison','WI',53558),(2,'Vanessa','Hudgens','vhudgens2005@yahoo.com',2147483647,'80 Pomegranate Street','Madison','WI',53701),(3,'Danny','DeVito','dannymyman@hotmail.com',2147483647,'2006 Sunshine Avenue','Green Bay','WI',54229),(4,'Betty','White','goldengirl1922@outlook.com',2147483647,'12 Rodgers Road','Green Bay','WI',54229);
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
  `concertID` int(11) NOT NULL,
  `fanID` int(11) NOT NULL,
  PRIMARY KEY (`ticketID`),
  KEY `fk_Tickets_Concerts1_idx` (`concertID`),
  KEY `fk_Tickets_Fans1_idx` (`fanID`),
  CONSTRAINT `fk_Tickets_Concerts1` FOREIGN KEY (`concertID`) REFERENCES `Concerts` (`concertID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tickets_Fans1` FOREIGN KEY (`fanID`) REFERENCES `Fans` (`fanID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tickets`
--

LOCK TABLES `Tickets` WRITE;
/*!40000 ALTER TABLE `Tickets` DISABLE KEYS */;
INSERT INTO `Tickets` VALUES (1,6,4),(2,6,1),(3,3,3),(4,3,4),(5,1,1),(6,1,3),(7,1,2),(8,3,1),(9,6,2),(10,1,4),(11,1,1);
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

-- Dump completed on 2022-07-26 19:33:52
