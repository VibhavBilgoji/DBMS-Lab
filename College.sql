/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.20-13.0.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: College
-- ------------------------------------------------------
-- Server version	13.0.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `Dept`
--

DROP TABLE IF EXISTS `Dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Dept` (
  `deptno` tinyint(4) NOT NULL,
  `dname` varchar(25) NOT NULL,
  `location` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`deptno`),
  UNIQUE KEY `uk1` (`dname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dept`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Dept` WRITE;
/*!40000 ALTER TABLE `Dept` DISABLE KEYS */;
INSERT INTO `Dept` VALUES
(10,'Executive','Mapusa'),
(15,'Engineering','Panaji'),
(20,'Research','Vasco'),
(30,'Sales','Porvorim'),
(40,'Admin','Bengalore');
/*!40000 ALTER TABLE `Dept` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `DummyProject`
--

DROP TABLE IF EXISTS `DummyProject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `DummyProject` (
  `proj_num` tinyint(4) NOT NULL,
  `pname` varchar(25) NOT NULL,
  `location` varchar(25) DEFAULT NULL,
  `dnum` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DummyProject`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `DummyProject` WRITE;
/*!40000 ALTER TABLE `DummyProject` DISABLE KEYS */;
/*!40000 ALTER TABLE `DummyProject` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Emp_WorksOn_Project`
--

DROP TABLE IF EXISTS `Emp_WorksOn_Project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Emp_WorksOn_Project` (
  `eno` int(11) NOT NULL,
  `pno` tinyint(4) NOT NULL,
  `hours_per_week` float DEFAULT 20,
  PRIMARY KEY (`eno`,`pno`),
  KEY `2` (`pno`),
  CONSTRAINT `1` FOREIGN KEY (`eno`) REFERENCES `Employee` (`empno`),
  CONSTRAINT `2` FOREIGN KEY (`pno`) REFERENCES `Project` (`proj_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Emp_WorksOn_Project`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Emp_WorksOn_Project` WRITE;
/*!40000 ALTER TABLE `Emp_WorksOn_Project` DISABLE KEYS */;
INSERT INTO `Emp_WorksOn_Project` VALUES
(1,8,20),
(2,1,15),
(2,8,10),
(3,1,10),
(3,2,25),
(3,6,20),
(4,1,15),
(4,4,12),
(5,1,25),
(6,3,20),
(6,4,18),
(7,3,15),
(7,7,10),
(8,3,30),
(9,4,20),
(9,5,15),
(10,2,15),
(10,6,25),
(11,3,20),
(11,7,15),
(12,3,10),
(13,5,25),
(13,6,20),
(14,6,15);
/*!40000 ALTER TABLE `Emp_WorksOn_Project` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `empno` int(11) NOT NULL,
  `empname` varchar(25) NOT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `job` varchar(25) DEFAULT NULL,
  `managerno` int(11) DEFAULT NULL,
  `hiredate` date DEFAULT NULL,
  `salary` float DEFAULT NULL,
  `commission` float DEFAULT NULL,
  `dept` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`empno`),
  KEY `fk1` (`dept`),
  CONSTRAINT `fk1` FOREIGN KEY (`dept`) REFERENCES `Dept` (`deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES
(1,'Vibhav','M','President',NULL,'2024-01-15',95000,NULL,10),
(2,'Walsh','M','Analyst',1,'2025-03-10',45000,5000,10),
(3,'Faiz','M','Clerk',2,'2025-07-22',18000,NULL,20),
(4,'Shubham','M','Salesperson',1,'2026-02-01',22000,30000,10),
(5,'Sparsh','M','Clerk',2,'2026-04-11',21000,NULL,15),
(6,'Siya','F','Manager',1,'2024-11-05',60000,12000,30),
(7,'Ananya','F','Admin Officer',6,'2025-06-01',32000,3000,40),
(8,'Rohan','M','Manager',1,'2024-08-15',55000,5000,40),
(9,'Karan','M','Salesperson',1,'2025-09-01',26000,15000,30),
(10,'Pooja','F','Analyst',2,'2025-08-15',40000,NULL,20),
(11,'Riya','F','Admin Officer',8,'2025-10-01',38000,2500,40),
(12,'Sneha','F','HR Executive',8,'2025-11-15',42000,NULL,40),
(13,'Kavita','F','Scientist',2,'2024-05-10',65000,NULL,20),
(14,'Tanvi','F','Research Associate',2,'2025-01-20',35000,NULL,20);
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Project`
--

DROP TABLE IF EXISTS `Project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Project` (
  `proj_num` tinyint(4) NOT NULL,
  `pname` varchar(25) NOT NULL,
  `location` varchar(25) DEFAULT NULL,
  `dnum` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`proj_num`),
  UNIQUE KEY `pname` (`pname`),
  KEY `dnum` (`dnum`),
  CONSTRAINT `1` FOREIGN KEY (`dnum`) REFERENCES `Dept` (`deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Project`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Project` WRITE;
/*!40000 ALTER TABLE `Project` DISABLE KEYS */;
INSERT INTO `Project` VALUES
(1,'Cloud Computing','Panaji',15),
(2,'DBMS','Vasco',20),
(3,'Computerization','Bengalore',40),
(4,'E-Commerce','Mumbai',30),
(5,'AI System','Porvorim',30),
(6,'Research','Vasco',20),
(7,'Office Automation','Bengalore',40),
(8,'Corporate Strategy','Mapusa',10);
/*!40000 ALTER TABLE `Project` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student` (
  `rollno` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `dob` date DEFAULT NULL,
  `dept` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`rollno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES
(69,'Sparsh Pai Bir','2006-08-14','Computer'),
(76,'Vibhav Bilgoji','2006-02-20','ETC');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-09-28 10:46:35
