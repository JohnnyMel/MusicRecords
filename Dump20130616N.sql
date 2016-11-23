CREATE DATABASE  IF NOT EXISTS `music` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `music`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: music
-- ------------------------------------------------------
-- Server version	5.5.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album` (
  `al_id` int(3) NOT NULL DEFAULT '0',
  `al_title` varchar(20) DEFAULT NULL,
  `al_date` date DEFAULT NULL,
  `format` varchar(20) DEFAULT NULL,
  `pid` int(3) DEFAULT NULL,
  `image` text,
  PRIMARY KEY (`al_id`),
  KEY `pid` (`pid`),
  CONSTRAINT `album_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `producer` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (1,'El Camino','2013-01-01','CD',1,'el_camino.jpg'),(2,'Blizzard of Ozz','1980-05-25','CD',2,'blizzard.jpg'),(3,'21','2012-04-02','CD',1,'21.png'),(4,'Enjoy The Silence','1995-03-08','CD',1,'silence.jpg');
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inst_song`
--

DROP TABLE IF EXISTS `inst_song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inst_song` (
  `inst_id` int(2) NOT NULL DEFAULT '0',
  `al_id` int(3) NOT NULL DEFAULT '0',
  `sid` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`inst_id`,`al_id`,`sid`),
  KEY `al_id` (`al_id`),
  KEY `sid` (`sid`),
  CONSTRAINT `inst_song_ibfk_1` FOREIGN KEY (`inst_id`) REFERENCES `instruments` (`inst_id`),
  CONSTRAINT `inst_song_ibfk_2` FOREIGN KEY (`al_id`) REFERENCES `album` (`al_id`),
  CONSTRAINT `inst_song_ibfk_3` FOREIGN KEY (`sid`) REFERENCES `song` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inst_song`
--

LOCK TABLES `inst_song` WRITE;
/*!40000 ALTER TABLE `inst_song` DISABLE KEYS */;
INSERT INTO `inst_song` VALUES (1,1,1),(1,1,2),(1,1,6),(3,1,2),(5,1,1),(5,1,2),(5,1,6),(1,2,3),(1,2,5),(5,2,3),(5,2,5),(3,3,7),(3,3,8),(4,4,9),(4,4,10),(5,4,9),(5,4,10);
/*!40000 ALTER TABLE `inst_song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instruments`
--

DROP TABLE IF EXISTS `instruments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instruments` (
  `inst_id` int(2) NOT NULL DEFAULT '0',
  `inst_name` varchar(20) NOT NULL DEFAULT '',
  `inst_key` varchar(3) DEFAULT NULL,
  `inst_type` varchar(20) DEFAULT NULL,
  `image` text,
  PRIMARY KEY (`inst_id`,`inst_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instruments`
--

LOCK TABLES `instruments` WRITE;
/*!40000 ALTER TABLE `instruments` DISABLE KEYS */;
INSERT INTO `instruments` VALUES (1,'Guitar','E','Electric','guitar.png'),(2,'Violin','G','Acoustic','violin.png'),(3,'Piano','C','Acoustic','piano.jpg'),(4,'Synthesizer','C','Electronic','synthesizer.jpg'),(5,'Drums','A','Acoustic','drums.png');
/*!40000 ALTER TABLE `instruments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_inst`
--

DROP TABLE IF EXISTS `m_inst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_inst` (
  `afm` int(10) NOT NULL DEFAULT '0',
  `inst_id` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`afm`,`inst_id`),
  KEY `inst_id` (`inst_id`),
  CONSTRAINT `m_inst_ibfk_1` FOREIGN KEY (`afm`) REFERENCES `musician` (`afm`),
  CONSTRAINT `m_inst_ibfk_2` FOREIGN KEY (`inst_id`) REFERENCES `instruments` (`inst_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_inst`
--

LOCK TABLES `m_inst` WRITE;
/*!40000 ALTER TABLE `m_inst` DISABLE KEYS */;
INSERT INTO `m_inst` VALUES (1035489448,1);
/*!40000 ALTER TABLE `m_inst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician`
--

DROP TABLE IF EXISTS `musician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician` (
  `afm` int(10) NOT NULL DEFAULT '0',
  `m_name` varchar(20) DEFAULT NULL,
  `m_surname` varchar(20) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `tel` varchar(15) DEFAULT NULL,
  `user` varchar(20) NOT NULL DEFAULT '',
  `pass` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`afm`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician`
--

LOCK TABLES `musician` WRITE;
/*!40000 ALTER TABLE `musician` DISABLE KEYS */;
INSERT INTO `musician` VALUES (22222,'Dave','Gahan','London','5551348464','dave','1234'),(735489448,'Zakk','Wylde','Los Angeles','5255787964','zakk','123456'),(1035489448,'John','Meletiou','Athens','2105787964','john','1234'),(1111111111,'Adele','Adkins','London','4235464845','adele','1234');
/*!40000 ALTER TABLE `musician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producer`
--

DROP TABLE IF EXISTS `producer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producer` (
  `pid` int(3) NOT NULL DEFAULT '0',
  `afm` int(10) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `afm` (`afm`),
  CONSTRAINT `producer_ibfk_1` FOREIGN KEY (`afm`) REFERENCES `musician` (`afm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producer`
--

LOCK TABLES `producer` WRITE;
/*!40000 ALTER TABLE `producer` DISABLE KEYS */;
INSERT INTO `producer` VALUES (2,735489448),(1,1035489448);
/*!40000 ALTER TABLE `producer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `singer`
--

DROP TABLE IF EXISTS `singer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `singer` (
  `singer_id` int(2) NOT NULL DEFAULT '0',
  `sname` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`singer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `singer`
--

LOCK TABLES `singer` WRITE;
/*!40000 ALTER TABLE `singer` DISABLE KEYS */;
INSERT INTO `singer` VALUES (1,'Dan Auerbach'),(2,'Zakk Wylde'),(3,'Ozzy Osbourne'),(4,'Adele'),(5,'Dave Gahan');
/*!40000 ALTER TABLE `singer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `singer_musician`
--

DROP TABLE IF EXISTS `singer_musician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `singer_musician` (
  `singer_id` int(2) NOT NULL DEFAULT '0',
  `afm` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`singer_id`,`afm`),
  KEY `afm` (`afm`),
  CONSTRAINT `singer_musician_ibfk_1` FOREIGN KEY (`singer_id`) REFERENCES `singer` (`singer_id`),
  CONSTRAINT `singer_musician_ibfk_2` FOREIGN KEY (`afm`) REFERENCES `musician` (`afm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `singer_musician`
--

LOCK TABLES `singer_musician` WRITE;
/*!40000 ALTER TABLE `singer_musician` DISABLE KEYS */;
INSERT INTO `singer_musician` VALUES (2,735489448);
/*!40000 ALTER TABLE `singer_musician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song`
--

DROP TABLE IF EXISTS `song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `song` (
  `sid` int(2) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) DEFAULT NULL,
  `al_id` int(2) NOT NULL DEFAULT '0',
  `inst_id` int(2) DEFAULT NULL,
  `afm` int(10) DEFAULT NULL,
  `singer_id` int(2) NOT NULL DEFAULT '0',
  `media` text,
  PRIMARY KEY (`sid`,`al_id`,`singer_id`),
  KEY `al_id` (`al_id`),
  KEY `inst_id` (`inst_id`),
  KEY `afm` (`afm`),
  KEY `singer_id` (`singer_id`),
  CONSTRAINT `song_ibfk_1` FOREIGN KEY (`al_id`) REFERENCES `album` (`al_id`),
  CONSTRAINT `song_ibfk_2` FOREIGN KEY (`inst_id`) REFERENCES `instruments` (`inst_id`),
  CONSTRAINT `song_ibfk_3` FOREIGN KEY (`afm`) REFERENCES `musician` (`afm`),
  CONSTRAINT `song_ibfk_4` FOREIGN KEY (`singer_id`) REFERENCES `singer` (`singer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song`
--

LOCK TABLES `song` WRITE;
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
INSERT INTO `song` VALUES (1,'Lonely Boy',1,1,1035489448,1,'<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/No1_jBC4jHE\" frameborder=\"0\" allowfullscreen></iframe>'),(2,'Gold on The Ceiling',1,1,1035489448,1,'<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/6yCIDkFI7ew\" frameborder=\"0\" allowfullscreen></iframe>'),(3,'Crazy Train',2,1,735489448,3,'<iframe width=\"420\" height=\"315\" src=\"http://www.youtube.com/embed/pVThw0EE_Jo\" frameborder=\"0\" allowfullscreen></iframe>'),(5,'Mr. Crowley',2,1,735489448,3,'<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/5bbfGWGZ6NM\" frameborder=\"0\" allowfullscreen></iframe>'),(6,'Black Submarines',1,1,1035489448,1,'<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/6k8es2BNloE\" frameborder=\"0\" allowfullscreen></iframe>'),(7,'Someone Like You',3,3,1111111111,4,'<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/hLQl3WQQoQ0\" frameborder=\"0\" allowfullscreen></iframe>'),(8,'Rolling in the Deep',3,3,1111111111,4,'<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/rYEDA3JcQqw\" frameborder=\"0\" allowfullscreen></iframe>'),(9,'Enjoy The Silence',4,4,22222,5,'<iframe width=\"420\" height=\"315\" src=\"http://www.youtube.com/embed/aGSKrC7dGcY\" frameborder=\"0\" allowfullscreen></iframe>'),(10,'Its No Good',4,4,22222,5,'<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/_-QPvffO1gs\" frameborder=\"0\" allowfullscreen></iframe>');
/*!40000 ALTER TABLE `song` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger total
before insert on song
for each row
update total_songs set total_songs.total = (select count(sid) from song where afm = total_songs.afm) + 1
where afm = total_songs.afm */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger ins_inst
after insert on song
for each row
insert into inst_song values(new.inst_id,new.al_id,new.sid) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger del_inst
before delete on song
for each row
delete from inst_song where inst_song.sid = old.sid */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger total_after_del
after delete on song
for each row
update total_songs set total_songs.total = (select count(sid) from song where afm = total_songs.afm)
where afm = total_songs.afm */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `total_songs`
--

DROP TABLE IF EXISTS `total_songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `total_songs` (
  `afm` int(10) NOT NULL DEFAULT '0',
  `total` int(3) DEFAULT NULL,
  PRIMARY KEY (`afm`),
  CONSTRAINT `total_songs_ibfk_1` FOREIGN KEY (`afm`) REFERENCES `musician` (`afm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `total_songs`
--

LOCK TABLES `total_songs` WRITE;
/*!40000 ALTER TABLE `total_songs` DISABLE KEYS */;
INSERT INTO `total_songs` VALUES (22222,2),(735489448,2),(1035489448,3),(1111111111,2);
/*!40000 ALTER TABLE `total_songs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'music'
--

--
-- Dumping routines for database 'music'
--
/*!50003 DROP PROCEDURE IF EXISTS `counter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `counter`()
begin
declare i int default 0; 
declare j int default 0;
declare k int default 0;
declare o varchar(100);
declare done int default 0;
declare cur cursor for select sid from song;
declare cur2 cursor for select al_id from album;
declare cur3 cursor for select afm from musician;
declare CONTINUE HANDLER FOR NOT FOUND set done = 1;
open cur;
fetch cur into o;
repeat 
set i = i + 1;
fetch cur into o;
until done = 1
end repeat;
close cur;

set done = 0;

open cur2;
fetch cur2 into o;
repeat 
set j = j + 1;
fetch cur2 into o;
until done = 1
end repeat;
close cur2;

set done = 0;

open cur3;
fetch cur3 into o;
repeat 
set k = k + 1;
fetch cur3 into o;
until done = 1
end repeat;
close cur3;


select i,j,k;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `scounter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `scounter`()
begin
declare i int default 0; 
declare j int default 0;
declare k int default 0;
declare o varchar(100);
declare done int default 0;
declare cur cursor for select sid from song;
declare cur2 cursor for select al_id from album;
declare cur3 cursor for select afm from musician;
declare CONTINUE HANDLER FOR NOT FOUND set done = 1;
open cur;
fetch cur into o;
repeat 
set i = i + 1;
fetch cur into o;
until done = 1
end repeat;
close cur;

set done = 0;

open cur2;
fetch cur2 into o;
repeat 
set j = j + 1;
fetch cur2 into o;
until done = 1
end repeat;
close cur2;

set done = 0;

open cur3;
fetch cur3 into o;
repeat 
set k = k + 1;
fetch cur3 into o;
until done = 1
end repeat;
close cur3;


select i,j,k;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `sel`(in isid int)
begin
select inst_name from instruments, inst_song
where instruments.inst_id = inst_song.inst_id and inst_song.sid = isid;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sel_song_from_inst` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `sel_song_from_inst`(in inst int)
begin
select title from song, inst_song 
where song.sid = inst_song.sid and inst_song.inst_id = inst;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-06-16  0:56:08
