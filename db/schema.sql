/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.5.28-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: openfilmproject
-- ------------------------------------------------------
-- Server version	10.5.28-MariaDB-0+deb11u1

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
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openlib_id` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `authors` text DEFAULT NULL,
  `publish_year` int(11) DEFAULT NULL,
  `cover_url` text DEFAULT NULL,
  `link_url` text DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `festivals`
--

DROP TABLE IF EXISTS `festivals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `festivals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `film_festivals`
--

DROP TABLE IF EXISTS `film_festivals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `film_festivals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `film_id` int(11) NOT NULL,
  `festival_id` int(11) NOT NULL,
  `year` int(11) DEFAULT NULL,
  `section` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `film_id` (`film_id`),
  KEY `festival_id` (`festival_id`),
  CONSTRAINT `film_festivals_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `films` (`tmdb_id`) ON DELETE CASCADE,
  CONSTRAINT `film_festivals_ibfk_2` FOREIGN KEY (`festival_id`) REFERENCES `festivals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filmmaker_books`
--

DROP TABLE IF EXISTS `filmmaker_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `filmmaker_books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filmmaker_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filmmaker_id` (`filmmaker_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `filmmaker_books_ibfk_1` FOREIGN KEY (`filmmaker_id`) REFERENCES `filmmakers` (`tmdb_id`) ON DELETE CASCADE,
  CONSTRAINT `filmmaker_books_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filmmakers`
--

DROP TABLE IF EXISTS `filmmakers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `filmmakers` (
  `tmdb_id` int(11) NOT NULL,
  `imdb_id` varchar(20) DEFAULT NULL,
  `name_en` varchar(255) NOT NULL,
  `name_original` varchar(255) DEFAULT NULL,
  `name_translit` varchar(255) DEFAULT NULL,
  `profile_image_url` text DEFAULT NULL,
  `bio` text DEFAULT NULL,
  PRIMARY KEY (`tmdb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `films`
--

DROP TABLE IF EXISTS `films`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `films` (
  `tmdb_id` int(11) NOT NULL,
  `filmmaker_id` int(11) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `title_original` varchar(255) DEFAULT NULL,
  `title_translit` varchar(255) DEFAULT NULL,
  `release_year` int(11) DEFAULT NULL,
  `poster_url` text DEFAULT NULL,
  PRIMARY KEY (`tmdb_id`),
  KEY `filmmaker_id` (`filmmaker_id`),
  CONSTRAINT `films_ibfk_1` FOREIGN KEY (`filmmaker_id`) REFERENCES `filmmakers` (`tmdb_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-25 15:08:20
