-- phpMyAdmin SQL Dump
-- version 5.2.0-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 11, 2022 at 11:36 PM
-- Server version: 10.6.8-MariaDB-log
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_hustonm`
--

-- --------------------------------------------------------

--
-- Table structure for table `Artists`
--

CREATE TABLE `Artists` (
  `name` varchar(145) NOT NULL,
  `artistID` int(11) NOT NULL,
  `phoneNumber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Artists`
--

INSERT INTO `Artists` (`name`, `artistID`, `phoneNumber`) VALUES
('Taylor Swift', 1, 2147483647),
('Justin Bieber', 3, 2147483647),
('BTS', 7, 2147483647);

-- --------------------------------------------------------

--
-- Table structure for table `Concerts`
--

CREATE TABLE `Concerts` (
  `concertID` int(11) NOT NULL,
  `concertDate` date DEFAULT NULL,
  `numberOfTickets` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Concerts`
--

INSERT INTO `Concerts` (`concertID`, `concertDate`, `numberOfTickets`) VALUES
(1, '2022-07-01', 5000),
(3, '2022-06-17', 3891),
(6, '2022-05-13', 4276);

-- --------------------------------------------------------

--
-- Table structure for table `Concerts_has_Artists`
--

CREATE TABLE `Concerts_has_Artists` (
  `Concerts_concertID` int(11) NOT NULL,
  `Artists_artistID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Concerts_has_Artists`
--

INSERT INTO `Concerts_has_Artists` (`Concerts_concertID`, `Artists_artistID`) VALUES
(1, 3),
(3, 7),
(6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Concerts_has_Employees`
--

CREATE TABLE `Concerts_has_Employees` (
  `Concerts_concertID` int(11) NOT NULL,
  `Employees_employeeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Concerts_has_Employees`
--

INSERT INTO `Concerts_has_Employees` (`Concerts_concertID`, `Employees_employeeID`) VALUES
(1, 6),
(1, 9),
(3, 1),
(3, 6),
(6, 1),
(6, 4);

-- --------------------------------------------------------

--
-- Table structure for table `Employees`
--

CREATE TABLE `Employees` (
  `employeeID` int(11) NOT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phoneNumber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Employees`
--

INSERT INTO `Employees` (`employeeID`, `firstName`, `lastName`, `role`, `email`, `phoneNumber`) VALUES
(1, 'Mike', 'Bailey', 'Security Officer', 'mbailey475@gmail.com', 2147483647),
(4, 'Wanda', 'Sykes', 'Sound Engineer', 'wsykes1964@hotmail.com', 2104920033),
(6, 'Harry', 'Styles', 'Ticket Vendor', 'hstyles1d@yahoo.com', 2147483647),
(9, 'Lisa', 'Kudrow', 'Event Planner', 'lkudrow1994@outlook.com', 2147483647);

-- --------------------------------------------------------

--
-- Table structure for table `Fans`
--

CREATE TABLE `Fans` (
  `fanID` int(11) NOT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phoneNumber` int(11) DEFAULT NULL,
  `address` varchar(145) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zipCode` varchar(45) DEFAULT NULL,
  `Concerts_concertID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Fans`
--

INSERT INTO `Fans` (`fanID`, `firstName`, `lastName`, `email`, `phoneNumber`, `address`, `city`, `state`, `zipCode`, `Concerts_concertID`) VALUES
(1, 'Ryan', 'Reynolds', 'theryanreynolds@gmail.com', 2147483647, '310 Gosling Way', 'Madison', 'WI', '53558', 1),
(2, 'Vanessa', 'Hudgens', 'vhudgens2005@yahoo.com', 2147483647, '80 Pomegranate Street', 'Madison', 'WI', '53701', 3),
(3, 'Danny', 'DeVito', 'dannymyman@hotmail.com', 2147483647, '2006 Sunshine Avenue', 'Green Bay', 'WI', '54229', 3),
(4, 'Betty', 'White', 'goldengirl1922@outlook.com', 2147483647, '12 Rodgers Road', 'Green Bay', 'WI', '54229', 6);

-- --------------------------------------------------------

--
-- Table structure for table `Tickets`
--

CREATE TABLE `Tickets` (
  `ticketID` int(11) NOT NULL,
  `Concerts_concertID` int(11) NOT NULL,
  `Fans_fanID` int(11) NOT NULL,
  `Fans_Concerts_concertID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `Tickets`
--

INSERT INTO `Tickets` (`ticketID`, `Concerts_concertID`, `Fans_fanID`, `Fans_Concerts_concertID`) VALUES
(1, 6, 4, 4),
(2, 6, 1, 5),
(3, 3, 3, 3),
(4, 3, 4, 7),
(5, 1, 1, 1),
(6, 1, 3, 9),
(7, 1, 2, 2),
(8, 3, 1, 8),
(9, 6, 2, 6),
(10, 1, 4, 10),
(11, 1, 1, 11);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Artists`
--
ALTER TABLE `Artists`
  ADD PRIMARY KEY (`artistID`);

--
-- Indexes for table `Concerts`
--
ALTER TABLE `Concerts`
  ADD PRIMARY KEY (`concertID`);

--
-- Indexes for table `Concerts_has_Artists`
--
ALTER TABLE `Concerts_has_Artists`
  ADD PRIMARY KEY (`Concerts_concertID`,`Artists_artistID`),
  ADD KEY `fk_Concerts_has_Artists_Artists1_idx` (`Artists_artistID`),
  ADD KEY `fk_Concerts_has_Artists_Concerts1_idx` (`Concerts_concertID`);

--
-- Indexes for table `Concerts_has_Employees`
--
ALTER TABLE `Concerts_has_Employees`
  ADD PRIMARY KEY (`Concerts_concertID`,`Employees_employeeID`),
  ADD KEY `fk_Concerts_has_Employees_Employees1_idx` (`Employees_employeeID`),
  ADD KEY `fk_Concerts_has_Employees_Concerts1_idx` (`Concerts_concertID`);

--
-- Indexes for table `Employees`
--
ALTER TABLE `Employees`
  ADD PRIMARY KEY (`employeeID`);

--
-- Indexes for table `Fans`
--
ALTER TABLE `Fans`
  ADD PRIMARY KEY (`fanID`,`Concerts_concertID`),
  ADD KEY `fk_Fans_Concerts1_idx` (`Concerts_concertID`);

--
-- Indexes for table `Tickets`
--
ALTER TABLE `Tickets`
  ADD PRIMARY KEY (`ticketID`,`Concerts_concertID`,`Fans_fanID`,`Fans_Concerts_concertID`),
  ADD KEY `fk_Tickets_Concerts1_idx` (`Concerts_concertID`),
  ADD KEY `fk_Tickets_Fans1_idx` (`Fans_fanID`,`Fans_Concerts_concertID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Artists`
--
ALTER TABLE `Artists`
  MODIFY `artistID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Concerts`
--
ALTER TABLE `Concerts`
  MODIFY `concertID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Employees`
--
ALTER TABLE `Employees`
  MODIFY `employeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Fans`
--
ALTER TABLE `Fans`
  MODIFY `fanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Tickets`
--
ALTER TABLE `Tickets`
  MODIFY `ticketID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Concerts_has_Artists`
--
ALTER TABLE `Concerts_has_Artists`
  ADD CONSTRAINT `fk_Concerts_has_Artists_Artists1` FOREIGN KEY (`Artists_artistID`) REFERENCES `Artists` (`artistID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Concerts_has_Artists_Concerts1` FOREIGN KEY (`Concerts_concertID`) REFERENCES `Concerts` (`concertID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Concerts_has_Employees`
--
ALTER TABLE `Concerts_has_Employees`
  ADD CONSTRAINT `fk_Concerts_has_Employees_Concerts1` FOREIGN KEY (`Concerts_concertID`) REFERENCES `Concerts` (`concertID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Concerts_has_Employees_Employees1` FOREIGN KEY (`Employees_employeeID`) REFERENCES `Employees` (`employeeID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Fans`
--
ALTER TABLE `Fans`
  ADD CONSTRAINT `fk_Fans_Concerts1` FOREIGN KEY (`Concerts_concertID`) REFERENCES `Concerts` (`concertID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Tickets`
--
ALTER TABLE `Tickets`
  ADD CONSTRAINT `fk_Tickets_Concerts1` FOREIGN KEY (`Concerts_concertID`) REFERENCES `Concerts` (`concertID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Tickets_Fans1` FOREIGN KEY (`Fans_fanID`) REFERENCES `Fans` (`fanID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- Dump completed on 2022-07-10 16:43:00
