-- MariaDB dump 10.19-11.3.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: compact
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB-1:11.3.2+maria~ubu2204

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
-- Table structure for table `antenna`
--

DROP TABLE IF EXISTS `antenna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `antenna` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `telescope_id` int(11) DEFAULT NULL,
  `latitude_degrees` float DEFAULT NULL,
  `longitude_degrees` float DEFAULT NULL,
  `elevation_meters` float DEFAULT NULL,
  `north` float DEFAULT NULL,
  `east` float DEFAULT NULL,
  `up` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `telescope_id` (`telescope_id`),
  CONSTRAINT `fk_antenna_telescope` FOREIGN KEY (`telescope_id`) REFERENCES `telescope` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antenna`
--

LOCK TABLES `antenna` WRITE;
/*!40000 ALTER TABLE `antenna` DISABLE KEYS */;
INSERT INTO `antenna` VALUES
(1,'m000','MeerKAT antenna 0',1,NULL,NULL,NULL,-207.29,-8.264,8.597),
(2,'m001','MeerKAT antenna 1',1,NULL,NULL,NULL,-171.762,1.121,8.471),
(3,'m002','MeerKAT antenna 2',1,NULL,NULL,NULL,-224.236,-32.113,8.645),
(4,'m003','MeerKAT antenna 3',1,NULL,NULL,NULL,-202.276,-66.518,8.285),
(5,'m004','MeerKAT antenna 4',1,NULL,NULL,NULL,-252.946,-123.624,8.513),
(6,'m005','MeerKAT antenna 5',1,NULL,NULL,NULL,-283.12,-102.088,8.875),
(7,'m006','MeerKAT antenna 6',1,NULL,NULL,NULL,-295.428,-18.232,9.188),
(8,'m007','MeerKAT antenna 7',1,NULL,NULL,NULL,-402.732,-89.592,9.769),
(9,'m008','MeerKAT antenna 8',1,NULL,NULL,NULL,-535.026,-93.527,10.445),
(10,'m009','MeerKAT antenna 9',1,NULL,NULL,NULL,-371.056,32.357,10.14),
(11,'m010','MeerKAT antenna 10',1,NULL,NULL,NULL,-511.872,88.095,11.186),
(12,'m011','MeerKAT antenna 11',1,NULL,NULL,NULL,-352.078,84.012,10.151),
(13,'m012','MeerKAT antenna 12',1,NULL,NULL,NULL,-368.267,140.019,10.449),
(14,'m013','MeerKAT antenna 13',1,NULL,NULL,NULL,-393.46,236.792,11.124),
(15,'m014','MeerKAT antenna 14',1,NULL,NULL,NULL,-285.792,280.669,10.547),
(16,'m015','MeerKAT antenna 15',1,NULL,NULL,NULL,-219.142,210.644,9.738),
(17,'m016','MeerKAT antenna 16',1,NULL,NULL,NULL,-185.873,288.159,9.795),
(18,'m017','MeerKAT antenna 17',1,NULL,NULL,NULL,-112.263,199.624,8.955),
(19,'m018','MeerKAT antenna 18',1,NULL,NULL,NULL,-245.87,105.727,9.529),
(20,'m019','MeerKAT antenna 19',1,NULL,NULL,NULL,-285.223,170.787,10.071),
(21,'m020','MeerKAT antenna 20',1,NULL,NULL,NULL,-299.638,97.016,9.877),
(22,'m021','MeerKAT antenna 21',1,NULL,NULL,NULL,-327.241,-295.966,8.117),
(23,'m022','MeerKAT antenna 22',1,NULL,NULL,NULL,0.544,-373.002,5.649),
(24,'m023','MeerKAT antenna 23',1,NULL,NULL,NULL,-142.185,-322.306,6.825),
(25,'m024','MeerKAT antenna 24',1,NULL,NULL,NULL,150.088,-351.046,4.845),
(26,'m025','MeerKAT antenna 25',1,NULL,NULL,NULL,225.617,-181.978,5.068),
(27,'m026','MeerKAT antenna 26',1,NULL,NULL,NULL,17.045,-99.004,6.811),
(28,'m027','MeerKAT antenna 27',1,NULL,NULL,NULL,-23.112,40.475,7.694),
(29,'m028','MeerKAT antenna 28',1,NULL,NULL,NULL,-87.17,-51.179,7.636),
(30,'m029','MeerKAT antenna 29',1,NULL,NULL,NULL,-124.111,-88.762,7.7),
(31,'m030','MeerKAT antenna 30',1,NULL,NULL,NULL,113.949,171.281,7.278),
(32,'m031','MeerKAT antenna 31',1,NULL,NULL,NULL,93.756,246.567,7.469),
(33,'m032','MeerKAT antenna 32',1,NULL,NULL,NULL,175.505,461.275,7.367),
(34,'m033','MeerKAT antenna 33',1,NULL,NULL,NULL,863.959,580.678,3.6),
(35,'m034','MeerKAT antenna 34',1,NULL,NULL,NULL,-28.308,357.811,8.972),
(36,'m035','MeerKAT antenna 35',1,NULL,NULL,NULL,-180.894,386.152,10.29),
(37,'m036','MeerKAT antenna 36',1,NULL,NULL,NULL,-290.759,388.257,10.812),
(38,'m037','MeerKAT antenna 37',1,NULL,NULL,NULL,-459.309,380.286,12.172),
(39,'m038','MeerKAT antenna 38',1,NULL,NULL,NULL,-569.08,213.308,11.946),
(40,'m039','MeerKAT antenna 39',1,NULL,NULL,NULL,-592.147,253.748,12.441),
(41,'m040','MeerKAT antenna 40',1,NULL,NULL,NULL,-712.219,-26.858,11.833),
(42,'m041','MeerKAT antenna 41',1,NULL,NULL,NULL,-661.678,-287.545,9.949),
(43,'m042','MeerKAT antenna 42',1,NULL,NULL,NULL,-460.318,-361.714,8.497),
(44,'m043','MeerKAT antenna 43',1,NULL,NULL,NULL,-128.326,-629.853,5.264),
(45,'m044','MeerKAT antenna 44',1,NULL,NULL,NULL,600.497,-896.164,-0.64),
(46,'m045','MeerKAT antenna 45',1,NULL,NULL,NULL,266.75,-1832.86,0.108),
(47,'m046','MeerKAT antenna 46',1,NULL,NULL,NULL,1751.92,-1467.34,-7.078),
(48,'m047','MeerKAT antenna 47',1,NULL,NULL,NULL,-517.297,-578.296,7.615),
(49,'m048','MeerKAT antenna 48',1,NULL,NULL,NULL,2686.86,-2805.65,-9.755),
(50,'m049','MeerKAT antenna 49',1,NULL,NULL,NULL,436.462,-3605.96,2.696),
(51,'m050','MeerKAT antenna 50',1,NULL,NULL,NULL,-843.715,-2052.34,5.338),
(52,'m051','MeerKAT antenna 51',1,NULL,NULL,NULL,-769.359,-850.255,7.614),
(53,'m052','MeerKAT antenna 52',1,NULL,NULL,NULL,-1148.65,-593.192,10.55),
(54,'m053','MeerKAT antenna 53',1,NULL,NULL,NULL,-1304.46,9.365,15.032),
(55,'m054','MeerKAT antenna 54',1,NULL,NULL,NULL,-499.812,871.98,13.364),
(56,'m055','MeerKAT antenna 55',1,NULL,NULL,NULL,96.492,1201.78,10.023),
(57,'m056','MeerKAT antenna 56',1,NULL,NULL,NULL,466.668,1598.4,6.99),
(58,'m057','MeerKAT antenna 57',1,NULL,NULL,NULL,3259.92,294.645,-10.637),
(59,'m058','MeerKAT antenna 58',1,NULL,NULL,NULL,2686.87,2805.76,-3.66),
(60,'m059','MeerKAT antenna 59',1,NULL,NULL,NULL,758.895,3686.43,11.822),
(61,'m060','MeerKAT antenna 60',1,NULL,NULL,NULL,-1840.48,3419.68,23.697),
(62,'m061','MeerKAT antenna 61',1,NULL,NULL,NULL,-2323.78,-16.409,21.304),
(63,'m062','MeerKAT antenna 62',1,NULL,NULL,NULL,-2503.77,-1440.63,21.683),
(64,'m063','MeerKAT antenna 63',1,NULL,NULL,NULL,-1840.48,-3419.58,16.383),
(65,'EF000','Effelsberg Antenna',2,NULL,NULL,NULL,NULL,NULL,NULL),
(66,'PK000','Parkes Antenna',3,NULL,NULL,NULL,NULL,NULL,NULL),
(67,'GB000','GBT Antenna',4,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `antenna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beam`
--

DROP TABLE IF EXISTS `beam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `ra_str` varchar(255) DEFAULT NULL,
  `dec_str` varchar(255) DEFAULT NULL,
  `pointing_id` int(11) NOT NULL,
  `beam_type_id` int(11) DEFAULT NULL,
  `tsamp` decimal(20,10) DEFAULT NULL,
  `is_coherent` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pointing_id` (`pointing_id`),
  KEY `beam_type_id` (`beam_type_id`),
  CONSTRAINT `beam_ibfk_3` FOREIGN KEY (`pointing_id`) REFERENCES `pointing` (`id`),
  CONSTRAINT `beam_ibfk_4` FOREIGN KEY (`beam_type_id`) REFERENCES `beam_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beam`
--

LOCK TABLES `beam` WRITE;
/*!40000 ALTER TABLE `beam` DISABLE KEYS */;
INSERT INTO `beam` VALUES
(1,'ptuse','21:40:22.41','-23:10:48.8',1,1,0.0000150600,1);
/*!40000 ALTER TABLE `beam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beam_antenna`
--

DROP TABLE IF EXISTS `beam_antenna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beam_antenna` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `antenna_id` int(11) DEFAULT NULL,
  `beam_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `antenna_id` (`antenna_id`),
  KEY `beam_id` (`beam_id`),
  CONSTRAINT `beam_antenna_ibfk_1` FOREIGN KEY (`antenna_id`) REFERENCES `antenna` (`id`),
  CONSTRAINT `beam_antenna_ibfk_2` FOREIGN KEY (`beam_id`) REFERENCES `beam` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beam_antenna`
--

LOCK TABLES `beam_antenna` WRITE;
/*!40000 ALTER TABLE `beam_antenna` DISABLE KEYS */;
/*!40000 ALTER TABLE `beam_antenna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beam_type`
--

DROP TABLE IF EXISTS `beam_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beam_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beam_type`
--

LOCK TABLES `beam_type` WRITE;
/*!40000 ALTER TABLE `beam_type` DISABLE KEYS */;
INSERT INTO `beam_type` VALUES
(1,'Stokes_I','Total Intensity Beam'),
(2,'Baseband','Baseband voltage beam');
/*!40000 ALTER TABLE `beam_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_filter`
--

DROP TABLE IF EXISTS `candidate_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candidate_filter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_filter`
--

LOCK TABLES `candidate_filter` WRITE;
/*!40000 ALTER TABLE `candidate_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circular_orbit_search`
--

DROP TABLE IF EXISTS `circular_orbit_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circular_orbit_search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `min_porb_h` decimal(20,10) DEFAULT NULL,
  `max_porb_h` decimal(20,10) DEFAULT NULL,
  `min_pulsar_mass_m0` decimal(20,10) DEFAULT NULL,
  `max_comp_mass_m0` decimal(20,10) DEFAULT NULL,
  `min_orb_phase_rad` decimal(20,10) DEFAULT NULL,
  `max_orb_phase_rad` decimal(20,10) DEFAULT NULL,
  `coverage` decimal(20,10) DEFAULT NULL,
  `mismatch` decimal(20,10) DEFAULT NULL,
  `container_image_name` varchar(255) DEFAULT NULL,
  `container_image_version` varchar(255) DEFAULT NULL,
  `container_type` varchar(255) DEFAULT NULL,
  `argument_hash` varchar(255) DEFAULT NULL,
  `container_image_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circular_orbit_search`
--

LOCK TABLES `circular_orbit_search` WRITE;
/*!40000 ALTER TABLE `circular_orbit_search` DISABLE KEYS */;
/*!40000 ALTER TABLE `circular_orbit_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_product`
--

DROP TABLE IF EXISTS `data_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_product` (
  `id` binary(16) NOT NULL,
  `beam_id` int(11) NOT NULL,
  `file_type_id` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `filepath` varchar(255) DEFAULT NULL,
  `filehash` varchar(255) DEFAULT NULL,
  `available` tinyint(4) DEFAULT NULL,
  `upload_date` timestamp NULL DEFAULT current_timestamp(),
  `modification_date` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `metainfo` varchar(255) DEFAULT NULL,
  `locked` tinyint(4) DEFAULT NULL,
  `utc_start` datetime DEFAULT NULL,
  `tsamp` decimal(20,10) DEFAULT NULL,
  `tobs` decimal(20,10) DEFAULT NULL,
  `nsamples` bigint(20) DEFAULT NULL,
  `freq_start_mhz` decimal(20,10) DEFAULT NULL,
  `freq_end_mhz` decimal(20,10) DEFAULT NULL,
  `created_by_processing_id` binary(16) DEFAULT NULL,
  `hardware_id` int(11) DEFAULT NULL,
  `tstart` decimal(20,10) DEFAULT NULL,
  `fft_size` bigint(20) DEFAULT NULL,
  `nchans` int(11) DEFAULT NULL,
  `nbits` int(11) DEFAULT NULL,
  `foff` decimal(20,10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dp_beam_id` (`beam_id`),
  KEY `fk_dp_file_type_id` (`file_type_id`),
  KEY `fk_created_by_processing_id` (`created_by_processing_id`),
  KEY `fk_hardware_id` (`hardware_id`),
  CONSTRAINT `data_product_ibfk_2` FOREIGN KEY (`beam_id`) REFERENCES `beam` (`id`),
  CONSTRAINT `data_product_ibfk_6` FOREIGN KEY (`file_type_id`) REFERENCES `file_type` (`id`),
  CONSTRAINT `fk_data_product_created_by_processing_id` FOREIGN KEY (`created_by_processing_id`) REFERENCES `processing` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_hardware_id` FOREIGN KEY (`hardware_id`) REFERENCES `hardware` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_product`
--

LOCK TABLES `data_product` WRITE;
/*!40000 ALTER TABLE `data_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elliptical_orbit_search`
--

DROP TABLE IF EXISTS `elliptical_orbit_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elliptical_orbit_search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `min_porb_h` decimal(20,10) DEFAULT NULL,
  `max_porb_h` decimal(20,10) DEFAULT NULL,
  `min_pulsar_mass_m0` decimal(20,10) DEFAULT NULL,
  `max_comp_mass_m0` decimal(20,10) DEFAULT NULL,
  `min_orb_phase_rad` decimal(20,10) DEFAULT NULL,
  `max_orb_phase_rad` decimal(20,10) DEFAULT NULL,
  `min_ecc` decimal(20,10) DEFAULT NULL,
  `max_ecc` decimal(20,10) DEFAULT NULL,
  `min_periastron_rad` decimal(20,10) DEFAULT NULL,
  `max_periastron_rad` decimal(20,10) DEFAULT NULL,
  `coverage` decimal(20,10) DEFAULT NULL,
  `mismatch` decimal(20,10) DEFAULT NULL,
  `container_image_name` varchar(255) DEFAULT NULL,
  `container_image_version` varchar(255) DEFAULT NULL,
  `container_type` varchar(255) DEFAULT NULL,
  `argument_hash` varchar(255) DEFAULT NULL,
  `container_image_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elliptical_orbit_search`
--

LOCK TABLES `elliptical_orbit_search` WRITE;
/*!40000 ALTER TABLE `elliptical_orbit_search` DISABLE KEYS */;
/*!40000 ALTER TABLE `elliptical_orbit_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_type`
--

DROP TABLE IF EXISTS `file_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `context` enum('Antenna','Beam','General') NOT NULL DEFAULT 'General',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_type`
--

LOCK TABLES `file_type` WRITE;
/*!40000 ALTER TABLE `file_type` DISABLE KEYS */;
INSERT INTO `file_type` VALUES
(1,'fil','Filterbank file','General'),
(2,'sf','PSRFITS file','General'),
(3,'fits','FITS file','General'),
(4,'csv','CSV file','General'),
(5,'png','PNG file','General'),
(6,'pdf','PDF file','General'),
(7,'txt','Text file','General'),
(8,'json','JSON file','General'),
(9,'xml','XML file','General'),
(10,'yaml','YAML file','General'),
(11,'dat','PRESTO time series file','General'),
(12,'tim','Sigproc time series file','General'),
(13,'ar','Folded archive file','General'),
(14,'pfd','PRESTO folded archive file','General'),
(15,'gz','GZIP compressed file','General'),
(16,'bestprof',NULL,'General'),
(17,'ps',NULL,'General');
/*!40000 ALTER TABLE `file_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filtool`
--

DROP TABLE IF EXISTS `filtool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filtool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfi_filter` varchar(255) DEFAULT NULL,
  `telescope_name` varchar(255) DEFAULT NULL,
  `threads` int(11) DEFAULT NULL,
  `extra_args` varchar(255) DEFAULT NULL,
  `container_image_name` varchar(255) DEFAULT NULL,
  `container_image_version` varchar(255) DEFAULT NULL,
  `container_type` varchar(255) DEFAULT NULL,
  `argument_hash` varchar(255) DEFAULT NULL,
  `container_image_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filtool`
--

LOCK TABLES `filtool` WRITE;
/*!40000 ALTER TABLE `filtool` DISABLE KEYS */;
INSERT INTO `filtool` VALUES
(1,'zdot','MeerKAT',12,NULL,'pulsarx_latest.sif','latest','singularity','2e0050fa2980610f410951e8dde997f231f9394e2a333de69844663c0a4a159b','bc1db89bd200d143cf77fd4fe36a3395a97e787971353c3ec2c5ee82e5acd941'),
(2,'zdot','meerkat',12,NULL,'pulsarx_latest.sif','latest','singularity','d5c3a7c7b05351ddf797e4872641878f27592421ef51bf9b173ad2d7f0bf1525','591dce500076f2a4351b957342c89cdfb32d25a4bd044e7d6884c6b84cc5e53c'),
(3,'zdot','meerkat',12,NULL,'pulsarx_latest.sif','latest','singularity','d5c3a7c7b05351ddf797e4872641878f27592421ef51bf9b173ad2d7f0bf1525','1a7f66a14e72b8ae038bd3d8ea2922fc1af20ba8bd04ea6af4adc59a0f03c657');
/*!40000 ALTER TABLE `filtool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fold_candidate`
--

DROP TABLE IF EXISTS `fold_candidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fold_candidate` (
  `id` binary(16) NOT NULL,
  `spin_period` float DEFAULT NULL,
  `dm` float DEFAULT NULL,
  `pdot` float DEFAULT NULL,
  `pdotdot` float DEFAULT NULL,
  `fold_snr` float DEFAULT NULL,
  `search_candidate_id` binary(16) DEFAULT NULL,
  `metadata_hash` varchar(255) DEFAULT NULL,
  `dp_id` binary(16) DEFAULT NULL,
  `candidate_filter_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `search_candidate_id` (`search_candidate_id`),
  KEY `fk_fold_candidate_dp_id` (`dp_id`),
  KEY `fk_fold_cand_candidate_filter_id` (`candidate_filter_id`),
  CONSTRAINT `fk_fold_cand_candidate_filter_id` FOREIGN KEY (`candidate_filter_id`) REFERENCES `candidate_filter` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_fold_candidate_dp_id` FOREIGN KEY (`dp_id`) REFERENCES `data_product` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_fold_candidate_search_candidate_id` FOREIGN KEY (`search_candidate_id`) REFERENCES `search_candidate` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fold_candidate`
--

LOCK TABLES `fold_candidate` WRITE;
/*!40000 ALTER TABLE `fold_candidate` DISABLE KEYS */;
/*!40000 ALTER TABLE `fold_candidate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hardware`
--

DROP TABLE IF EXISTS `hardware`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hardware` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `job_scheduler` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hardware`
--

LOCK TABLES `hardware` WRITE;
/*!40000 ALTER TABLE `hardware` DISABLE KEYS */;
INSERT INTO `hardware` VALUES
(1,'Contra','Contra HPC in Dresden','ht-condor'),
(2,'Hercules','Hercules HPC in Garching','slurm'),
(3,'OzSTAR','OzSTAR HPC in Melbourne','slurm'),
(4,'Ngarrgu','Ngarrgu Tindebeek HPC in Melbourne','slurm'),
(5,'AWS','Amazon Web Services','aws');
/*!40000 ALTER TABLE `hardware` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peasoup`
--

DROP TABLE IF EXISTS `peasoup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `peasoup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acc_start` decimal(20,10) DEFAULT NULL,
  `acc_end` decimal(20,10) DEFAULT NULL,
  `min_snr` decimal(20,10) DEFAULT NULL,
  `ram_limit_gb` decimal(20,10) DEFAULT NULL,
  `nharmonics` int(11) DEFAULT NULL,
  `ngpus` int(11) DEFAULT NULL,
  `total_cands_limit` int(11) DEFAULT NULL,
  `fft_size` bigint(20) DEFAULT NULL,
  `dm_file` varchar(255) DEFAULT NULL,
  `accel_tol` decimal(20,10) DEFAULT NULL,
  `birdie_list` varchar(255) DEFAULT NULL,
  `chan_mask` varchar(255) DEFAULT NULL,
  `extra_args` varchar(255) DEFAULT NULL,
  `container_image_name` varchar(255) DEFAULT NULL,
  `container_image_version` varchar(255) DEFAULT NULL,
  `container_type` varchar(255) DEFAULT NULL,
  `argument_hash` varchar(255) DEFAULT NULL,
  `container_image_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peasoup`
--

LOCK TABLES `peasoup` WRITE;
/*!40000 ALTER TABLE `peasoup` DISABLE KEYS */;
INSERT INTO `peasoup` VALUES
(1,-30.0000000000,30.0000000000,8.0000000000,30.0000000000,4,1,100000,67108864,'/fred/oz005/users/vishnu/one_ring/dm_file.txt',1.1100000000,NULL,NULL,NULL,'peasoup_latest.sif','latest','singularity','1fc1aa64cc4b6206410d00b6389d687fbdd6453446ce806ecd3930aaba64d4c7','95dbc22122b49f2227892ee8291f01a45c4b41947832f669b07ecbdc592045e3'),
(2,-30.0000000000,30.0000000000,8.0000000000,30.0000000000,4,1,100000,67108864,'/fred/oz005/users/vishnu/one_ring/dm_file.txt',1.1100000000,NULL,NULL,NULL,'peasoup_latest.sif','latest','singularity','65ca0a6e79d085376f964fbcb683826750efd150b82c4800f7474c81f96c2a47','95dbc22122b49f2227892ee8291f01a45c4b41947832f669b07ecbdc592045e3');
/*!40000 ALTER TABLE `peasoup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pipeline`
--

DROP TABLE IF EXISTS `pipeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pipeline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `github_repo_name` varchar(255) DEFAULT NULL,
  `github_commit_hash` char(40) DEFAULT NULL,
  `github_branch` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pipeline`
--

LOCK TABLES `pipeline` WRITE;
/*!40000 ALTER TABLE `pipeline` DISABLE KEYS */;
INSERT INTO `pipeline` VALUES
(1,'Accel Search','Time Domain Full length Accel Search using Peasoup','one_ring','52766f3c4e4510bb74895b80943087bdb7132fd1','main'),
(2,'Accel Search','Time Domain Full length Accel Search using Peasoup','one_ring','a750ad2ca7908a5fc1e472642c58a85d95f87891','main'),
(3,'Accel Search','Time Domain Full length Accel Search using Peasoup','one_ring','cdb0125de516fd6ba22355a4007345838f131572','main'),
(4,'Accel Search','Time Domain Full length Accel Search using Peasoup','one_ring','12362caf4dc527c53a047a01f775924dee669bac','main');
/*!40000 ALTER TABLE `pipeline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pointing`
--

DROP TABLE IF EXISTS `pointing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pointing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utc_start` datetime DEFAULT NULL,
  `tobs` decimal(20,10) DEFAULT NULL,
  `nchans_raw` int(11) DEFAULT NULL,
  `freq_band` varchar(50) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `freq_start_mhz` decimal(20,10) DEFAULT NULL,
  `freq_end_mhz` decimal(20,10) DEFAULT NULL,
  `tsamp_raw` decimal(20,10) DEFAULT NULL,
  `telescope_id` int(11) DEFAULT NULL,
  `receiver` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `target_id` (`target_id`),
  KEY `telescope_id` (`telescope_id`),
  CONSTRAINT `fk_pointing_target` FOREIGN KEY (`target_id`) REFERENCES `target` (`id`),
  CONSTRAINT `fk_pointing_telescope` FOREIGN KEY (`telescope_id`) REFERENCES `telescope` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pointing`
--

LOCK TABLES `pointing` WRITE;
/*!40000 ALTER TABLE `pointing` DISABLE KEYS */;
INSERT INTO `pointing` VALUES
(1,'2022-06-29 20:06:23',3600.9950268235,256,'UHF',1,543.9335937500,1087.9335937500,0.0000150600,1,'KAT');
/*!40000 ALTER TABLE `pointing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prepfold`
--

DROP TABLE IF EXISTS `prepfold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prepfold` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ncpus` int(11) DEFAULT NULL,
  `rfifind_mask` varchar(255) DEFAULT NULL,
  `extra_args` varchar(1000) DEFAULT NULL,
  `container_image_name` varchar(255) DEFAULT NULL,
  `container_image_version` varchar(255) DEFAULT NULL,
  `container_type` varchar(255) DEFAULT NULL,
  `argument_hash` varchar(255) DEFAULT NULL,
  `container_image_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prepfold`
--

LOCK TABLES `prepfold` WRITE;
/*!40000 ALTER TABLE `prepfold` DISABLE KEYS */;
INSERT INTO `prepfold` VALUES
(1,1,NULL,NULL,'pulsar-miner_turing-sm75.sif','turing-sm75','singularity','045a81f14958c314a7f79d4c784ae8781a28c84c5d4500b1a1144b059281ee1f','47422d7ef78177afaabc820fcf4f0ba6a5bb9db91013c70a3648606244d91b9e'),
(2,6,NULL,NULL,'pulsar-miner_turing-sm75.sif','turing-sm75','singularity','7efc6f0811c3daca3bd79d47f32d06e38b497edbc392fdf4859601feb33bdada','57bcb3a211b5d3df9e344627256e509e6d6e699c86c2e989f44ea8ccb0bc1f8b');
/*!40000 ALTER TABLE `prepfold` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `processing`
--

DROP TABLE IF EXISTS `processing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `processing` (
  `id` binary(16) NOT NULL,
  `pipeline_id` int(11) DEFAULT NULL,
  `hardware_id` int(11) DEFAULT NULL,
  `submit_time` datetime DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `process_status` varchar(255) DEFAULT NULL,
  `attempt_number` int(11) DEFAULT NULL,
  `max_attempts` int(11) DEFAULT NULL,
  `peasoup_id` int(11) DEFAULT NULL,
  `pulsarx_id` int(11) DEFAULT NULL,
  `prepfold_id` int(11) DEFAULT NULL,
  `filtool_id` int(11) DEFAULT NULL,
  `circular_orbit_search_id` int(11) DEFAULT NULL,
  `elliptical_orbit_search_id` int(11) DEFAULT NULL,
  `rfifind_id` int(11) DEFAULT NULL,
  `candidate_filter_id` int(11) DEFAULT NULL,
  `execution_order` int(11) DEFAULT NULL,
  `program_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pr_pipeline_id` (`pipeline_id`),
  KEY `fk_pr_cluster_id` (`hardware_id`),
  KEY `fk_peasoup_id` (`peasoup_id`),
  KEY `fk_pulsarx_id` (`pulsarx_id`),
  KEY `fk_prepfold_id` (`prepfold_id`),
  KEY `fk_filtool_id` (`filtool_id`),
  KEY `fk_circular_orbit_search_id` (`circular_orbit_search_id`),
  KEY `fk_elliptical_orbit_search_id` (`elliptical_orbit_search_id`),
  KEY `fk_rfifind_id` (`rfifind_id`),
  KEY `fk_candidate_filter_id` (`candidate_filter_id`),
  CONSTRAINT `fk_candidate_filter_id` FOREIGN KEY (`candidate_filter_id`) REFERENCES `candidate_filter` (`id`),
  CONSTRAINT `fk_circular_orbit_search_id` FOREIGN KEY (`circular_orbit_search_id`) REFERENCES `circular_orbit_search` (`id`),
  CONSTRAINT `fk_elliptical_orbit_search_id` FOREIGN KEY (`elliptical_orbit_search_id`) REFERENCES `elliptical_orbit_search` (`id`),
  CONSTRAINT `fk_filtool_id` FOREIGN KEY (`filtool_id`) REFERENCES `filtool` (`id`),
  CONSTRAINT `fk_peasoup_id` FOREIGN KEY (`peasoup_id`) REFERENCES `peasoup` (`id`),
  CONSTRAINT `fk_pr_hardware_id` FOREIGN KEY (`hardware_id`) REFERENCES `hardware` (`id`),
  CONSTRAINT `fk_pr_pipeline_id` FOREIGN KEY (`pipeline_id`) REFERENCES `pipeline` (`id`),
  CONSTRAINT `fk_prepfold_id` FOREIGN KEY (`prepfold_id`) REFERENCES `prepfold` (`id`),
  CONSTRAINT `fk_pulsarx_id` FOREIGN KEY (`pulsarx_id`) REFERENCES `pulsarx` (`id`),
  CONSTRAINT `fk_rfifind_id` FOREIGN KEY (`rfifind_id`) REFERENCES `rfifind` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `processing`
--

LOCK TABLES `processing` WRITE;
/*!40000 ALTER TABLE `processing` DISABLE KEYS */;
/*!40000 ALTER TABLE `processing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `processing_dp_inputs`
--

DROP TABLE IF EXISTS `processing_dp_inputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `processing_dp_inputs` (
  `id` binary(16) NOT NULL,
  `dp_id` binary(16) DEFAULT NULL,
  `processing_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dp_id` (`dp_id`),
  KEY `processing_id` (`processing_id`),
  CONSTRAINT `fk_processing_dp_inputs_dp_id` FOREIGN KEY (`dp_id`) REFERENCES `data_product` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_processing_dp_inputs_processing_id` FOREIGN KEY (`processing_id`) REFERENCES `processing` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `processing_dp_inputs`
--

LOCK TABLES `processing_dp_inputs` WRITE;
/*!40000 ALTER TABLE `processing_dp_inputs` DISABLE KEYS */;
/*!40000 ALTER TABLE `processing_dp_inputs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_project_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES
(1,'COMPACT','ERC funded MeerKAT baseband pulsar search survey'),
(2,'TRAPUM_GC_SEARCHES','GC Searches for the Transients and Pulsars with MeerKAT survey'),
(3,'HTRU_S_LOWLAT','HTRU South Lowlat survey');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pulsarx`
--

DROP TABLE IF EXISTS `pulsarx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pulsarx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subbands_number` int(11) DEFAULT NULL,
  `subint_length` decimal(20,10) DEFAULT NULL,
  `clfd_q_value` decimal(20,10) DEFAULT NULL,
  `fast_nbins` int(11) DEFAULT NULL,
  `slow_nbins` int(11) DEFAULT NULL,
  `rfi_filter` varchar(255) DEFAULT NULL,
  `extra_args` varchar(1000) DEFAULT NULL,
  `container_image_name` varchar(255) DEFAULT NULL,
  `container_image_version` varchar(255) DEFAULT NULL,
  `container_type` varchar(255) DEFAULT NULL,
  `threads` int(11) DEFAULT NULL,
  `argument_hash` varchar(255) DEFAULT NULL,
  `container_image_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pulsarx`
--

LOCK TABLES `pulsarx` WRITE;
/*!40000 ALTER TABLE `pulsarx` DISABLE KEYS */;
INSERT INTO `pulsarx` VALUES
(1,64,56.3195181176,2.0000000000,128,64,'zdot',NULL,'pulsarx_latest.sif','latest','singularity',12,'8f2560c7010d24e370000d58844e04e210479bd44edb03887122b340300b00ad','591dce500076f2a4351b957342c89cdfb32d25a4bd044e7d6884c6b84cc5e53c'),
(2,64,56.3195181176,2.0000000000,128,64,'zdot',NULL,'pulsarx_latest.sif','latest','singularity',12,'8f2560c7010d24e370000d58844e04e210479bd44edb03887122b340300b00ad','1a7f66a14e72b8ae038bd3d8ea2922fc1af20ba8bd04ea6af4adc59a0f03c657');
/*!40000 ALTER TABLE `pulsarx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rfifind`
--

DROP TABLE IF EXISTS `rfifind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rfifind` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` decimal(20,10) DEFAULT NULL,
  `time_sigma` decimal(20,10) DEFAULT NULL,
  `freq_sigma` decimal(20,10) DEFAULT NULL,
  `chan_frac` decimal(20,10) DEFAULT NULL,
  `int_frac` decimal(20,10) DEFAULT NULL,
  `ncpus` int(11) DEFAULT NULL,
  `extra_args` varchar(255) DEFAULT NULL,
  `container_image_name` varchar(255) DEFAULT NULL,
  `container_image_version` varchar(255) DEFAULT NULL,
  `container_type` varchar(255) DEFAULT NULL,
  `argument_hash` varchar(255) DEFAULT NULL,
  `container_image_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rfifind`
--

LOCK TABLES `rfifind` WRITE;
/*!40000 ALTER TABLE `rfifind` DISABLE KEYS */;
/*!40000 ALTER TABLE `rfifind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_candidate`
--

DROP TABLE IF EXISTS `search_candidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_candidate` (
  `id` binary(16) NOT NULL,
  `spin_period` float DEFAULT NULL,
  `dm` float DEFAULT NULL,
  `pdot` float DEFAULT NULL,
  `pdotdot` float DEFAULT NULL,
  `pb` float DEFAULT NULL,
  `x` float DEFAULT NULL,
  `t0` float DEFAULT NULL,
  `omega` float DEFAULT NULL,
  `e` float DEFAULT NULL,
  `snr` float DEFAULT NULL,
  `ddm_count_ratio` float DEFAULT NULL,
  `ddm_snr_ratio` float DEFAULT NULL,
  `nassoc` int(11) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `filepath` varchar(255) DEFAULT NULL,
  `nh` int(11) DEFAULT NULL,
  `candidate_filter_id` int(11) DEFAULT NULL,
  `metadata_hash` varchar(255) DEFAULT NULL,
  `dp_id` binary(16) DEFAULT NULL,
  `candidate_id_in_file` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `filter_id` (`candidate_filter_id`),
  KEY `fk_search_candidate_dp_id` (`dp_id`),
  CONSTRAINT `fk_search_candidate_dp_id` FOREIGN KEY (`dp_id`) REFERENCES `data_product` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `search_candidate_ibfk_1` FOREIGN KEY (`candidate_filter_id`) REFERENCES `candidate_filter` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_candidate`
--

LOCK TABLES `search_candidate` WRITE;
/*!40000 ALTER TABLE `search_candidate` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_candidate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target`
--

DROP TABLE IF EXISTS `target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_name` varchar(255) DEFAULT NULL,
  `ra` varchar(255) DEFAULT NULL,
  `dec` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `core_radius_arcmin_harris` float DEFAULT NULL,
  `core_radius_arcmin_baumgardt` float DEFAULT NULL,
  `half_mass_radius_arcmin_harris` float DEFAULT NULL,
  `half_mass_radius_arcmin_baumgardt` float DEFAULT NULL,
  `half_light_radius_arcmin_harris` float DEFAULT NULL,
  `half_light_radius_arcmin_baumgardt` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_project_id` (`project_id`),
  KEY `idx_source_name_ra_dec` (`target_name`,`ra`,`dec`),
  CONSTRAINT `fk_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target`
--

LOCK TABLES `target` WRITE;
/*!40000 ALTER TABLE `target` DISABLE KEYS */;
INSERT INTO `target` VALUES
(1,'J2140-2310B','21:40:22.41','-23:10:48.8',NULL,2,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `target` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telescope`
--

DROP TABLE IF EXISTS `telescope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telescope` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telescope`
--

LOCK TABLES `telescope` WRITE;
/*!40000 ALTER TABLE `telescope` DISABLE KEYS */;
INSERT INTO `telescope` VALUES
(1,'MeerKAT','Radio Interferometer in South Africa'),
(2,'Effelsberg','Single-Dish Radio telescope in Germany'),
(3,'Parkes','Single-Dish Radio telescope in Australia'),
(4,'GBT','Robert C. Byrd Green Bank Telescope in West Virginia');
/*!40000 ALTER TABLE `telescope` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `administrator` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_unique` (`username`),
  UNIQUE KEY `email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,'vishnu','Vishnu Balakrishnan','vishnu@mpifr-bonn.mpg.de','123456',1),
(2,'vivek','Vivek Krishnan','vkrishnan@mpifr-bonn.mpg.de','654321',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_labels`
--

DROP TABLE IF EXISTS `user_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_labels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fold_candidate_id` binary(16) DEFAULT NULL,
  `rfi` tinyint(1) DEFAULT NULL,
  `noise` tinyint(1) DEFAULT NULL,
  `t1_cand` tinyint(1) DEFAULT NULL,
  `t2_cand` tinyint(1) DEFAULT NULL,
  `known_pulsar` tinyint(1) DEFAULT NULL,
  `nb_psr` tinyint(1) DEFAULT NULL,
  `is_harmonic` tinyint(1) DEFAULT NULL,
  `is_confirmed_pulsar` tinyint(1) DEFAULT NULL,
  `pulsar_name` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fold_candidate_id` (`fold_candidate_id`),
  KEY `fk_user_labels_user_id` (`user_id`),
  CONSTRAINT `fk_user_labels_fold_candidate_id` FOREIGN KEY (`fold_candidate_id`) REFERENCES `fold_candidate` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_user_labels_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_labels`
--

LOCK TABLES `user_labels` WRITE;
/*!40000 ALTER TABLE `user_labels` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_labels` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-01 13:50:47
