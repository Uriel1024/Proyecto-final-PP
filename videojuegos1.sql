-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: videojuegos1
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `CarritoCompras`
--

DROP TABLE IF EXISTS `CarritoCompras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CarritoCompras` (
  `id_carrito` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  PRIMARY KEY (`id_carrito`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `CarritoCompras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CarritoCompras`
--

LOCK TABLES `CarritoCompras` WRITE;
/*!40000 ALTER TABLE `CarritoCompras` DISABLE KEYS */;
INSERT INTO `CarritoCompras` VALUES (1,37,'2023-04-01'),(2,10,'2023-04-10'),(3,26,'2023-04-15'),(4,38,'2023-04-20'),(5,35,'2023-04-25'),(6,4,'2023-05-02'),(7,40,'2023-05-10'),(8,13,'2023-05-18'),(9,5,'2023-05-27'),(10,19,'2023-06-01'),(11,15,'2023-06-15'),(12,32,'2023-06-23'),(13,12,'2023-07-03'),(14,34,'2023-07-10'),(15,17,'2023-07-18'),(16,46,'2023-07-25'),(17,29,'2023-08-02'),(18,36,'2023-08-10'),(19,31,'2023-08-15'),(20,39,'2023-08-20'),(21,22,'2023-08-25'),(22,25,'2023-09-05'),(23,20,'2023-09-10'),(24,42,'2023-09-15'),(25,23,'2023-09-25'),(26,1,'2023-10-01'),(27,21,'2023-10-05'),(28,2,'2023-10-07'),(29,16,'2023-10-08'),(30,24,'2023-10-10'),(31,7,'2023-10-12'),(32,28,'2023-10-13'),(33,27,'2023-10-14'),(34,41,'2023-10-15'),(35,9,'2023-10-16'),(36,45,'2023-10-17'),(37,30,'2023-10-18'),(38,18,'2023-10-19'),(39,33,'2023-10-20'),(40,29,'2023-10-21'),(41,25,'2023-10-22'),(42,4,'2023-10-23'),(43,2,'2023-10-24'),(44,33,'2023-10-25'),(45,30,'2023-10-26'),(46,16,'2023-10-27'),(47,13,'2023-10-28');
/*!40000 ALTER TABLE `CarritoCompras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DetallesCarrito`
--

DROP TABLE IF EXISTS `DetallesCarrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DetallesCarrito` (
  `id_detalle_carrito` int NOT NULL AUTO_INCREMENT,
  `id_carrito` int DEFAULT NULL,
  `id_videojuego` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_detalle_carrito`),
  KEY `id_carrito` (`id_carrito`),
  KEY `id_videojuego` (`id_videojuego`),
  CONSTRAINT `DetallesCarrito_ibfk_1` FOREIGN KEY (`id_carrito`) REFERENCES `CarritoCompras` (`id_carrito`),
  CONSTRAINT `DetallesCarrito_ibfk_2` FOREIGN KEY (`id_videojuego`) REFERENCES `videojuegos` (`id_videojuego`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DetallesCarrito`
--

LOCK TABLES `DetallesCarrito` WRITE;
/*!40000 ALTER TABLE `DetallesCarrito` DISABLE KEYS */;
INSERT INTO `DetallesCarrito` VALUES (1,1,15,2,1998.00),(2,1,23,1,79.00),(3,2,9,3,4197.00),(4,2,35,2,2798.00),(5,3,11,1,699.00),(6,3,42,1,1499.00),(7,4,5,2,0.00),(8,4,7,3,2097.00),(9,5,18,1,0.00),(10,5,28,2,2998.00),(11,6,12,1,599.00),(12,6,30,1,1399.00),(13,7,6,2,1098.00),(14,7,3,3,2997.00),(15,8,17,1,0.00),(16,8,31,2,2598.00),(17,9,14,3,4197.00),(18,9,8,2,1798.00),(19,10,40,1,1199.00),(20,10,25,1,1499.00);
/*!40000 ALTER TABLE `DetallesCarrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DetallesCompraExtensiones`
--

DROP TABLE IF EXISTS `DetallesCompraExtensiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DetallesCompraExtensiones` (
  `id_detalle_extension` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `id_extension` int DEFAULT NULL,
  `fecha_compra` date DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_detalle_extension`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_extension` (`id_extension`),
  CONSTRAINT `DetallesCompraExtensiones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `DetallesCompraExtensiones_ibfk_2` FOREIGN KEY (`id_extension`) REFERENCES `ExtensionesVideojuegos` (`id_extension`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DetallesCompraExtensiones`
--

LOCK TABLES `DetallesCompraExtensiones` WRITE;
/*!40000 ALTER TABLE `DetallesCompraExtensiones` DISABLE KEYS */;
INSERT INTO `DetallesCompraExtensiones` VALUES (1,10,1,'2023-09-01',1,199.99),(2,12,4,'2024-01-10',2,399.98),(3,15,13,'2023-12-05',1,229.99),(4,20,18,'2023-10-01',1,259.99),(5,18,9,'2023-12-10',3,1049.97);
/*!40000 ALTER TABLE `DetallesCompraExtensiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DetallesPedido`
--

DROP TABLE IF EXISTS `DetallesPedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DetallesPedido` (
  `id_detalle_pedido` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int DEFAULT NULL,
  `id_videojuego` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_detalle_pedido`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_videojuego` (`id_videojuego`),
  CONSTRAINT `DetallesPedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `Pedidos` (`id_pedido`),
  CONSTRAINT `DetallesPedido_ibfk_2` FOREIGN KEY (`id_videojuego`) REFERENCES `videojuegos` (`id_videojuego`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DetallesPedido`
--

LOCK TABLES `DetallesPedido` WRITE;
/*!40000 ALTER TABLE `DetallesPedido` DISABLE KEYS */;
INSERT INTO `DetallesPedido` VALUES (1,1,1,2,2798.00),(2,1,3,1,999.00),(3,2,2,1,1299.00),(4,2,4,3,1497.00),(5,3,5,2,0.00),(6,3,6,1,549.00),(7,4,7,1,699.00),(8,4,8,2,1798.00),(9,5,9,1,1399.00),(10,5,10,2,2598.00),(11,6,11,1,699.00),(12,6,12,3,1797.00),(13,7,13,2,2798.00),(14,7,14,1,1399.00),(15,8,15,1,999.00),(16,8,16,2,0.00),(17,9,17,1,0.00),(18,9,18,2,0.00),(19,10,19,3,2097.00),(20,10,20,1,1399.00),(21,11,21,1,1299.00),(22,11,22,2,2998.00),(23,12,23,3,237.00),(24,12,24,1,399.00),(25,13,25,2,2998.00),(26,13,26,3,4197.00),(27,14,27,1,1499.00),(28,14,28,2,2998.00),(29,15,29,3,4797.00),(30,15,30,1,1399.00),(31,16,31,2,2598.00),(32,16,32,3,2997.00),(33,17,33,1,1499.00),(34,17,34,2,2798.00),(35,18,35,3,4197.00),(36,18,36,1,1299.00),(37,19,37,2,798.00),(38,19,38,3,897.00),(39,20,39,1,899.00),(40,20,40,2,2398.00);
/*!40000 ALTER TABLE `DetallesPedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Devoluciones`
--

DROP TABLE IF EXISTS `Devoluciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Devoluciones` (
  `id_devolucion` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int DEFAULT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `estado` enum('pendiente','aceptada','rechazada') DEFAULT 'pendiente',
  `monto_reembolso` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_devolucion`),
  KEY `id_pedido` (`id_pedido`),
  CONSTRAINT `Devoluciones_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `Pedidos` (`id_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Devoluciones`
--

LOCK TABLES `Devoluciones` WRITE;
/*!40000 ALTER TABLE `Devoluciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `Devoluciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Estado`
--

DROP TABLE IF EXISTS `Estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Estado` (
  `nombre` enum('pendiente','enviado','entregado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Estado`
--

LOCK TABLES `Estado` WRITE;
/*!40000 ALTER TABLE `Estado` DISABLE KEYS */;
/*!40000 ALTER TABLE `Estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExtensionesVideojuegos`
--

DROP TABLE IF EXISTS `ExtensionesVideojuegos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExtensionesVideojuegos` (
  `id_extension` int NOT NULL AUTO_INCREMENT,
  `id_videojuego` int DEFAULT NULL,
  `nombre_extension` varchar(100) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `descripcion` text,
  `fecha_lanzamiento` date DEFAULT NULL,
  PRIMARY KEY (`id_extension`),
  KEY `id_videojuego` (`id_videojuego`),
  CONSTRAINT `ExtensionesVideojuegos_ibfk_1` FOREIGN KEY (`id_videojuego`) REFERENCES `videojuegos` (`id_videojuego`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExtensionesVideojuegos`
--

LOCK TABLES `ExtensionesVideojuegos` WRITE;
/*!40000 ALTER TABLE `ExtensionesVideojuegos` DISABLE KEYS */;
INSERT INTO `ExtensionesVideojuegos` VALUES (1,33,'Speedsters Pack',149.99,'Añade nuevos autos de alta velocidad y circuitos desafiantes.','2023-07-12'),(2,33,'Night Riders Expansion',199.99,'Expansión con modos de carrera nocturnos y nuevas pistas.','2024-01-05'),(3,9,'Armored Warfare Expansion',249.99,'Incluye tanques pesados y armas de asalto en nuevas misiones.','2023-05-20'),(4,9,'Battle Royale Mode',299.99,'Modo de juego Battle Royale con hasta 100 jugadores en un mapa abierto.','2023-10-11'),(5,14,'Ancient Gods Pack',199.99,'Expande el mundo del juego con deidades mitológicas y poderes especiales.','2023-08-22'),(6,14,'The Forbidden Realm',279.99,'Explora un reino prohibido lleno de desafíos épicos y tesoros ocultos.','2023-12-30'),(7,16,'Fighter Legends DLC',399.99,'Incluye nuevos personajes legendarios con habilidades exclusivas.','2023-06-07'),(8,28,'Galactic Conquest Expansion',349.99,'Añade nuevos planetas y misiones espaciales en una guerra intergaláctica.','2023-11-15'),(9,30,'Jungle Warfare Expansion',229.99,'Nuevas misiones en selvas peligrosas, con enemigos furtivos y trampas.','2024-02-14'),(10,46,'Stealth Operations Pack',179.99,'Modo de juego sigiloso con nuevas herramientas y habilidades tácticas.','2023-09-05'),(11,62,'Ultimate Fighter Pack',299.99,'Añade cinco nuevos luchadores con estilos de combate únicos.','2023-10-01'),(12,56,'Zombie Survival Mode',149.99,'Enfrenta hordas interminables de zombis en este nuevo modo de supervivencia.','2023-07-18'),(13,6,'Legends of the Abyss',199.99,'Aventura submarina en lo más profundo del océano con criaturas míticas.','2023-12-02'),(14,6,'The Sunken Kingdom',289.99,'Explora un reino submarino olvidado lleno de ruinas y tesoros.','2024-01-25'),(15,8,'Cyberpunk City Expansion',349.99,'Añade una nueva ciudad futurista con misiones de alta tecnología.','2024-03-10'),(16,30,'Mystical Forest Pack',199.99,'Explora bosques místicos llenos de criaturas mágicas y secretos.','2023-08-18'),(17,49,'Winter Assault Expansion',249.99,'Combate en terrenos nevados y sobrevive a las duras condiciones climáticas.','2023-11-25'),(18,62,'Pirates of the High Seas',269.99,'Embárcate en aventuras piratas con nuevos barcos, armas y misiones.','2024-01-12'),(19,4,'Desert Warfare Pack',319.99,'Misiones de combate en el desierto con vehículos y tácticas especiales.','2023-10-30'),(20,7,'The Dark Fortress',399.99,'Enfrenta los horrores de una fortaleza oscura llena de trampas y enemigos.','2023-09-17');
/*!40000 ALTER TABLE `ExtensionesVideojuegos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MetodosPago`
--

DROP TABLE IF EXISTS `MetodosPago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MetodosPago` (
  `id_pago` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int DEFAULT NULL,
  `tipo_pago` enum('tarjeta','paypal','otros') DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_pago`),
  KEY `id_pedido` (`id_pedido`),
  CONSTRAINT `MetodosPago_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `Pedidos` (`id_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MetodosPago`
--

LOCK TABLES `MetodosPago` WRITE;
/*!40000 ALTER TABLE `MetodosPago` DISABLE KEYS */;
INSERT INTO `MetodosPago` VALUES (1,1,'tarjeta',3797.00),(2,2,'paypal',2796.00),(3,3,'otros',549.00),(4,4,'tarjeta',2497.00),(5,5,'paypal',3997.00),(6,6,'otros',2496.00),(7,7,'tarjeta',4197.00),(8,8,'paypal',999.00),(9,9,'otros',0.00),(10,10,'tarjeta',3496.00),(11,11,'paypal',4297.00),(12,12,'otros',636.00),(13,13,'tarjeta',7195.00),(14,14,'paypal',4497.00),(15,15,'otros',6196.00),(16,16,'tarjeta',5595.00),(17,17,'paypal',4297.00),(18,18,'otros',5496.00),(19,19,'tarjeta',1695.00),(20,20,'paypal',3297.00);
/*!40000 ALTER TABLE `MetodosPago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pedidos`
--

DROP TABLE IF EXISTS `Pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pedidos` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `fecha_pedido` date DEFAULT NULL,
  `estado` enum('pendiente','enviado','entregado') DEFAULT 'pendiente',
  PRIMARY KEY (`id_pedido`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `Pedidos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedidos`
--

LOCK TABLES `Pedidos` WRITE;
/*!40000 ALTER TABLE `Pedidos` DISABLE KEYS */;
INSERT INTO `Pedidos` VALUES (1,3,'2023-04-05','pendiente'),(2,6,'2023-05-12','enviado'),(3,8,'2023-06-18','entregado'),(4,11,'2023-07-22','pendiente'),(5,14,'2023-08-09','enviado'),(6,3,'2023-09-05','entregado'),(7,6,'2023-10-01','pendiente'),(8,8,'2023-04-17','enviado'),(9,11,'2023-05-30','entregado'),(10,14,'2023-06-10','pendiente'),(11,3,'2023-07-14','enviado'),(12,6,'2023-08-22','entregado'),(13,8,'2023-09-01','pendiente'),(14,11,'2023-10-03','enviado'),(15,14,'2023-04-25','entregado'),(16,3,'2023-05-06','pendiente'),(17,6,'2023-06-21','enviado'),(18,8,'2023-07-19','entregado'),(19,11,'2023-08-11','pendiente'),(20,14,'2023-09-28','enviado');
/*!40000 ALTER TABLE `Pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_dev`
--

DROP TABLE IF EXISTS `estado_dev`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_dev` (
  `nombre` enum('pendiente','aceptada','rechazada') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_dev`
--

LOCK TABLES `estado_dev` WRITE;
/*!40000 ALTER TABLE `estado_dev` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado_dev` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generos`
--

DROP TABLE IF EXISTS `generos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generos` (
  `id_genero` int NOT NULL AUTO_INCREMENT,
  `nombre_genero` varchar(50) NOT NULL,
  PRIMARY KEY (`id_genero`),
  UNIQUE KEY `nombre_genero` (`nombre_genero`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generos`
--

LOCK TABLES `generos` WRITE;
/*!40000 ALTER TABLE `generos` DISABLE KEYS */;
INSERT INTO `generos` VALUES (1,'Accion'),(2,'Aventura'),(7,'Carreras'),(16,'Ciencia Ficcion'),(6,'Deportes'),(5,'Estrategia'),(17,'Fantasia'),(9,'Lucha'),(15,'Metroidvania'),(19,'MMORPG'),(12,'Mundo Abierto'),(13,'Musica'),(8,'Plataformas'),(11,'Puzles'),(3,'Rol'),(20,'Sandbox'),(18,'Shooter'),(4,'Simulacion'),(14,'Survival Horror'),(10,'Terror');
/*!40000 ALTER TABLE `generos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `nombre` enum('cliente','administrador') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_pago`
--

DROP TABLE IF EXISTS `tipo_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_pago` (
  `nombre` enum('tarjeta','paypal','otros') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_pago`
--

LOCK TABLES `tipo_pago` WRITE;
/*!40000 ALTER TABLE `tipo_pago` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `primer_apellido` varchar(50) NOT NULL,
  `segundo_apellido` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contrasena` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `rol` enum('cliente','administrador') DEFAULT 'cliente',
  `id_carrito_compras` int DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Luis','Gomez','Perez','luis.gomez1@example.com','Contra12345!','123 Main St, New York, NY','1234567890','cliente',NULL),(2,'Ana','Lopez','Garcia','ana.lopez2@example.com','SecureP@ssw0rd','456 Elm St, Los Angeles, CA','1234567891','cliente',NULL),(3,'Pedro','Martinez','Sanchez','pedro.martinez3@example.com','Passw0rd!98','789 Maple Ave, Chicago, IL','1234567892','administrador',NULL),(4,'Marta','Diaz','Gomez','marta.diaz4@example.com','P@ssword#2021','321 Oak Dr, Houston, TX','1234567893','cliente',NULL),(5,'Jorge','Fernandez','Lopez','jorge.fernandez5@example.com','Admin123$','654 Pine Rd, Philadelphia, PA','1234567894','cliente',NULL),(6,'Laura','Garcia','Martinez','laura.garcia6@example.com','Pa$$w0rd2022','987 Birch Ln, Phoenix, AZ','1234567895','administrador',NULL),(7,'Carlos','Santos','Ramirez','carlos.santos7@example.com','MyP@ss123!','432 Cedar St, San Antonio, TX','1234567896','cliente',NULL),(8,'Patricia','Morales','Hernandez','patricia.morales8@example.com','SuperP@ss!','876 Redwood Blvd, San Diego, CA','1234567897','administrador',NULL),(9,'Raul','Torres','Jimenez','raul.torres9@example.com','Welcome2023!','543 Aspen Ave, Dallas, TX','1234567898','cliente',NULL),(10,'Carmen','Nunez','Perez','carmen.nunez10@example.com','S@fePass2023','210 Spruce Way, San Jose, CA','1234567899','cliente',NULL),(11,'Antonio','Vargas','Castro','antonio.vargas11@example.com','Pa$$word2024!','190 Sequoia St, Austin, TX','1234567800','administrador',NULL),(12,'Isabel','Reyes','Sanchez','isabel.reyes12@example.com','AdminPass!456','280 Chestnut Rd, Jacksonville, FL','1234567801','cliente',NULL),(13,'Manuel','Hernandez','Gomez','manuel.hernandez13@example.com','P@$$w0rd!','370 Willow St, Columbus, OH','1234567802','cliente',NULL),(14,'Gloria','Ruiz','Lopez','gloria.ruiz14@example.com','Secur3P@ss','460 Cypress Ave, Indianapolis, IN','1234567803','administrador',NULL),(15,'Jose','Mendoza','Diaz','jose.mendoza15@example.com','Mypass123#','120 Fir St, San Francisco, CA','1234567804','cliente',NULL),(16,'Sara','Medina','Fernandez','sara.medina16@example.com','SaFe$Pa$$','260 Poplar Rd, Fort Worth, TX','1234567805','cliente',NULL),(17,'David','Romero','Garcia','david.romero17@example.com','Password123$','310 Olive Dr, Charlotte, NC','1234567806','cliente',NULL),(18,'Sonia','Rojas','Santos','sonia.rojas18@example.com','Secure#4567','230 Magnolia Ln, Detroit, MI','1234567807','cliente',NULL),(19,'Alejandro','Paredes','Morales','alejandro.paredes19@example.com','Passw0rd@2022','140 Dogwood Ct, El Paso, TX','1234567808','cliente',NULL),(20,'Maria','Leon','Vargas','maria.leon20@example.com','MyS@fe123','320 Hickory St, Memphis, TN','1234567809','cliente',NULL),(21,'Ricardo','Ortega','Nunez','ricardo.ortega21@example.com','P@ssw0rd!2023','220 Redwood Blvd, Denver, CO','1234567810','cliente',NULL),(22,'Veronica','Gil','Reyes','veronica.gil22@example.com','MysafeP@$$','410 Dogwood Way, Boston, MA','1234567811','cliente',NULL),(23,'Luis','Cruz','Perez','luis.cruz23@example.com','P@ssword!2024','520 Hemlock St, Nashville, TN','1234567812','cliente',NULL),(24,'Elena','Castillo','Vargas','elena.castillo24@example.com','SafePass@2024','650 Maple Ave, Portland, OR','1234567813','cliente',NULL),(25,'Fernando','Flores','Garcia','fernando.flores25@example.com','MySafeP@ss!','710 Oak Dr, Oklahoma City, OK','1234567814','cliente',NULL),(26,'Claudia','Martin','Diaz','claudia.martin26@example.com','P@ssword@2025','890 Pine Rd, Las Vegas, NV','1234567815','cliente',NULL),(27,'Javier','Moreno','Santos','javier.moreno27@example.com','MyPa$$w0rd!','110 Cedar St, Albuquerque, NM','1234567816','cliente',NULL),(28,'Monica','Vega','Hernandez','monica.vega28@example.com','Secure@2025!','470 Spruce Way, Tucson, AZ','1234567817','cliente',NULL),(29,'Andres','Campos','Gomez','andres.campos29@example.com','P@ssword#789','240 Aspen Ave, Fresno, CA','1234567818','cliente',NULL),(30,'Cristina','Iglesias','Ramirez','cristina.iglesias30@example.com','MyP@$$w0rd!','680 Birch Ln, Sacramento, CA','1234567819','cliente',NULL),(31,'Miguel','Serrano','Martinez','miguel.serrano31@example.com','Safe#Password','870 Maple Ct, Kansas City, MO','1234567820','cliente',NULL),(32,'Beatriz','Alvarez','Morales','beatriz.alvarez32@example.com','P@$$Secure789','980 Oak Dr, Mesa, AZ','1234567821','cliente',NULL),(33,'Oscar','Guerrero','Santos','oscar.guerrero33@example.com','SecureP@ssw0rd','120 Elm St, Atlanta, GA','1234567822','cliente',NULL),(34,'Natalia','Herrera','Perez','natalia.herrera34@example.com','S@fePass2023','560 Dogwood Blvd, Omaha, NE','1234567823','cliente',NULL),(35,'Adrian','Ramos','Diaz','adrian.ramos35@example.com','MyP@ss123','310 Cypress Ln, Raleigh, NC','1234567824','cliente',NULL),(36,'Alicia','Molina','Fernandez','alicia.molina36@example.com','P@ssword#456','620 Fir St, Miami, FL','1234567825','cliente',NULL),(37,'Daniel','Blanco','Garcia','daniel.blanco37@example.com','Mypass@Secure','430 Magnolia Rd, Tampa, FL','1234567826','cliente',NULL),(38,'Rosa','Benitez','Vargas','rosa.benitez38@example.com','P@ssw0rd789','740 Redwood Ave, Aurora, CO','1234567827','cliente',NULL),(39,'Felipe','Espinosa','Lopez','felipe.espinosa39@example.com','Secur3P@ss!','850 Poplar Dr, Orlando, FL','1234567828','cliente',NULL),(40,'Lucia','Prieto','Perez','lucia.prieto40@example.com','SafePa$$123','960 Sequoia St, Cleveland, OH','1234567829','cliente',NULL),(41,'Gonzalo','Lara','Castro','gonzalo.lara41@example.com','Pass#2023!','180 Hickory Rd, Minneapolis, MN','1234567830','cliente',NULL),(42,'Celia','Duran','Santos','celia.duran42@example.com','P@ssword!2023','570 Dogwood Ln, St. Louis, MO','1234567831','cliente',NULL),(43,'Ramiro','Rivas','Gomez','ramiro.rivas43@example.com','MyS@fe2023!','680 Elm Blvd, New Orleans, LA','1234567832','administrador',NULL),(44,'Sofia','Cano','Sanchez','sofia.cano44@example.com','Admin#Pass!','780 Pine Ct, Cincinnati, OH','1234567833','administrador',NULL),(45,'Pablo','Gallardo','Martinez','pablo.gallardo45@example.com','MyS@fePa$$!','890 Birch St, Pittsburgh, PA','1234567834','cliente',NULL),(46,'Olga','Perez','Garcia','olga.perez46@example.com','P@ss123456!','190 Maple Ave, Buffalo, NY','1234567835','cliente',NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videojuego_genero`
--

DROP TABLE IF EXISTS `videojuego_genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videojuego_genero` (
  `id_videojuego` int NOT NULL,
  `id_genero` int NOT NULL,
  PRIMARY KEY (`id_videojuego`,`id_genero`),
  KEY `id_genero` (`id_genero`),
  CONSTRAINT `videojuego_genero_ibfk_1` FOREIGN KEY (`id_videojuego`) REFERENCES `videojuegos` (`id_videojuego`),
  CONSTRAINT `videojuego_genero_ibfk_2` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`id_genero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videojuego_genero`
--

LOCK TABLES `videojuego_genero` WRITE;
/*!40000 ALTER TABLE `videojuego_genero` DISABLE KEYS */;
INSERT INTO `videojuego_genero` VALUES (1,1),(3,1),(4,1),(5,1),(9,1),(11,1),(12,1),(14,1),(15,1),(16,1),(19,1),(20,1),(21,1),(22,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(34,1),(35,1),(36,1),(38,1),(39,1),(40,1),(41,1),(43,1),(44,1),(46,1),(49,1),(51,1),(53,1),(54,1),(55,1),(57,1),(58,1),(59,1),(60,1),(61,1),(65,1),(1,2),(2,2),(3,2),(7,2),(11,2),(14,2),(20,2),(21,2),(22,2),(29,2),(58,2),(60,2),(7,3),(8,3),(17,3),(30,3),(32,3),(37,3),(41,3),(45,3),(46,3),(47,3),(48,3),(50,3),(51,3),(52,3),(53,3),(56,3),(6,4),(23,4),(24,4),(64,4),(10,5),(13,6),(42,6),(62,6),(33,7),(34,7),(62,7),(63,7),(64,7),(2,8),(36,8),(38,8),(44,8),(35,9),(43,9),(61,9),(20,10),(23,10),(25,10),(31,10),(65,10),(3,12),(4,12),(6,12),(8,12),(12,12),(14,12),(21,12),(26,12),(31,12),(49,12),(59,12),(10,13),(24,13),(37,13),(7,16),(8,16),(11,16),(39,16),(40,16),(45,16),(47,16),(52,16),(55,16),(56,16),(57,16),(4,17),(9,17),(12,17),(15,17),(26,17),(27,17),(28,17),(54,17),(5,18),(16,18),(18,18),(19,18),(6,19),(17,20);
/*!40000 ALTER TABLE `videojuego_genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videojuegos`
--

DROP TABLE IF EXISTS `videojuegos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videojuegos` (
  `id_videojuego` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(75) DEFAULT NULL,
  `plataforma` varchar(50) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `desarrollador` varchar(100) DEFAULT NULL,
  `fecha_lanzamiento` date DEFAULT NULL,
  PRIMARY KEY (`id_videojuego`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videojuegos`
--

LOCK TABLES `videojuegos` WRITE;
/*!40000 ALTER TABLE `videojuegos` DISABLE KEYS */;
INSERT INTO `videojuegos` VALUES (1,'The Legend of Zelda: Breath of the Wild','Nintendo Switch',1399.00,25,'Nintendo','2017-03-03'),(2,'Super Mario Odyssey','Nintendo Switch',1299.00,30,'Nintendo','2017-10-27'),(3,'Red Dead Redemption 2','PlayStation 4',999.00,20,'Rockstar Games','2018-10-26'),(4,'Grand Theft Auto V','PlayStation 4',499.00,40,'Rockstar Games','2014-11-18'),(5,'Fortnite','PC',0.00,50,'Epic Games','2017-07-21'),(6,'Minecraft','PC',549.00,35,'Mojang','2011-11-18'),(7,'The Witcher 3: Wild Hunt','PC',699.00,28,'CD Projekt Red','2015-05-19'),(8,'Cyberpunk 2077','PC',899.00,15,'CD Projekt Red','2020-12-10'),(9,'Call of Duty: Modern Warfare','PlayStation 4',1399.00,22,'Infinity Ward','2019-10-25'),(10,'Animal Crossing: New Horizons','Nintendo Switch',1299.00,45,'Nintendo','2020-03-20'),(11,'God of War','PlayStation 4',699.00,38,'Santa Monica Studio','2018-04-20'),(12,'Horizon Zero Dawn','PlayStation 4',599.00,29,'Guerrilla Games','2017-02-28'),(13,'FIFA 21','PlayStation 4',1399.00,50,'EA Sports','2020-10-09'),(14,'Assassins Creed Valhalla','PlayStation 4',1399.00,18,'Ubisoft','2020-11-10'),(15,'Doom Eternal','PC',999.00,12,'id Software','2020-03-20'),(16,'Apex Legends','PC',0.00,48,'Respawn Entertainment','2019-02-04'),(17,'League of Legends','PC',0.00,50,'Riot Games','2009-10-27'),(18,'Valorant','PC',0.00,42,'Riot Games','2020-06-02'),(19,'Overwatch','PC',699.00,27,'Blizzard Entertainment','2016-05-24'),(20,'The Last of Us Part II','PlayStation 4',1399.00,10,'Naughty Dog','2020-06-19'),(21,'Ghost of Tsushima','PlayStation 4',1299.00,32,'Sucker Punch','2020-07-17'),(22,'Spider-Man: Miles Morales','PlayStation 5',1499.00,25,'Insomniac Games','2020-11-12'),(23,'Among Us','PC',79.00,40,'InnerSloth','2018-11-16'),(24,'Fall Guys','PC',399.00,19,'Mediatonic','2020-08-04'),(25,'Resident Evil Village','PlayStation 5',1499.00,20,'Capcom','2021-05-07'),(26,'Far Cry 6','PC',1399.00,22,'Ubisoft','2021-10-07'),(27,'Battlefield 2042','PlayStation 5',1499.00,12,'DICE','2021-11-19'),(28,'Halo Infinite','Xbox Series X',1499.00,30,'343 Industries','2021-12-08'),(29,'Ratchet & Clank: Rift Apart','PlayStation 5',1599.00,17,'Insomniac Games','2021-06-11'),(30,'Elden Ring','PlayStation 4',1399.00,10,'FromSoftware','2022-02-25'),(31,'Dying Light 2','PC',1299.00,28,'Techland','2022-02-04'),(32,'Diablo II: Resurrected','PC',999.00,15,'Blizzard Entertainment','2021-09-23'),(33,'Forza Horizon 5','Xbox Series X',1499.00,16,'Playground Games','2021-11-09'),(34,'Mario Kart 8 Deluxe','Nintendo Switch',1399.00,37,'Nintendo','2017-04-28'),(35,'Super Smash Bros. Ultimate','Nintendo Switch',1399.00,29,'Nintendo','2018-12-07'),(36,'Metroid Dread','Nintendo Switch',1299.00,20,'Nintendo','2021-10-08'),(37,'Hades','PC',399.00,15,'Supergiant Games','2020-09-17'),(38,'Cuphead','PC',299.00,25,'Studio MDHR','2017-09-29'),(39,'Control','PlayStation 4',899.00,18,'Remedy Entertainment','2019-08-27'),(40,'Sekiro: Shadows Die Twice','PlayStation 4',1199.00,14,'FromSoftware','2019-03-22'),(41,'Dark Souls III','PC',599.00,28,'FromSoftware','2016-04-12'),(42,'NBA 2K22','PlayStation 5',1499.00,11,'Visual Concepts','2021-09-10'),(43,'Mortal Kombat 11','PlayStation 4',999.00,32,'NetherRealm Studios','2019-04-23'),(44,'Crash Bandicoot 4: Its About Time','PlayStation 4',999.00,23,'Toys for Bob','2020-10-02'),(45,'Tales of Arise','PlayStation 5',1499.00,10,'Bandai Namco','2021-09-10'),(46,'Final Fantasy VII Remake','PlayStation 4',1399.00,12,'Square Enix','2020-04-10'),(47,'NieR: Automata','PC',799.00,30,'PlatinumGames','2017-03-17'),(48,'Dragon Quest XI S','Nintendo Switch',999.00,15,'Square Enix','2019-09-27'),(49,'Monster Hunter Rise','Nintendo Switch',1399.00,14,'Capcom','2021-03-26'),(50,'Persona 5 Royal','PlayStation 4',999.00,19,'Atlus','2020-03-31'),(51,'Yakuza: Like a Dragon','PlayStation 4',1299.00,20,'Ryu Ga Gotoku Studio','2020-11-10'),(52,'Shin Megami Tensei V','Nintendo Switch',1499.00,10,'Atlus','2021-11-12'),(53,'Gears 5','Xbox Series X',799.00,20,'The Coalition','2019-09-10'),(54,'Borderlands 3','PlayStation 4',899.00,25,'Gearbox Software','2019-09-13'),(55,'Death Stranding','PlayStation 4',999.00,16,'Kojima Productions','2019-11-08'),(56,'Resident Evil 3','PlayStation 4',1299.00,10,'Capcom','2020-04-03'),(57,'Nioh 2','PlayStation 4',1299.00,20,'Team Ninja','2020-03-13'),(58,'The Outer Worlds','PC',999.00,22,'Obsidian Entertainment','2019-10-25'),(59,'Ghostrunner','PC',699.00,35,'One More Level','2020-10-27'),(60,'Disco Elysium','PC',499.00,29,'ZA/UM','2019-10-15'),(61,'Ori and the Will of the Wisps','PC',599.00,18,'Moon Studios','2020-03-11'),(62,'Fire Emblem: Three Houses','Nintendo Switch',1399.00,27,'Intelligent Systems','2019-07-26'),(63,'Luigis Mansion 3','Nintendo Switch',1399.00,23,'Nintendo','2019-10-31'),(64,'Splatoon 2','Nintendo Switch',1199.00,32,'Nintendo','2017-07-21'),(65,'The Sims 4','PC',499.00,40,'Maxis','2014-09-02'),(66,'The Legend of Zelda: Breath of the Wild','Nintendo Switch',1399.00,25,'Nintendo','2017-03-03'),(67,'Super Mario Odyssey','Nintendo Switch',1299.00,30,'Nintendo','2017-10-27'),(68,'Red Dead Redemption 2','PlayStation 4',999.00,20,'Rockstar Games','2018-10-26'),(69,'Grand Theft Auto V','PlayStation 4',499.00,40,'Rockstar Games','2014-11-18'),(70,'Fortnite','PC',0.00,50,'Epic Games','2017-07-21'),(71,'Minecraft','PC',549.00,35,'Mojang','2011-11-18'),(72,'The Witcher 3: Wild Hunt','PC',699.00,28,'CD Projekt Red','2015-05-19'),(73,'Cyberpunk 2077','PC',899.00,15,'CD Projekt Red','2020-12-10'),(74,'Call of Duty: Modern Warfare','PlayStation 4',1399.00,22,'Infinity Ward','2019-10-25'),(75,'Animal Crossing: New Horizons','Nintendo Switch',1299.00,45,'Nintendo','2020-03-20'),(76,'God of War','PlayStation 4',699.00,38,'Santa Monica Studio','2018-04-20'),(77,'Horizon Zero Dawn','PlayStation 4',599.00,29,'Guerrilla Games','2017-02-28'),(78,'FIFA 21','PlayStation 4',1399.00,50,'EA Sports','2020-10-09'),(79,'Assassins Creed Valhalla','PlayStation 4',1399.00,18,'Ubisoft','2020-11-10'),(80,'Doom Eternal','PC',999.00,12,'id Software','2020-03-20'),(81,'Apex Legends','PC',0.00,48,'Respawn Entertainment','2019-02-04'),(82,'League of Legends','PC',0.00,50,'Riot Games','2009-10-27'),(83,'Valorant','PC',0.00,42,'Riot Games','2020-06-02'),(84,'Overwatch','PC',699.00,27,'Blizzard Entertainment','2016-05-24'),(85,'The Last of Us Part II','PlayStation 4',1399.00,10,'Naughty Dog','2020-06-19'),(86,'Ghost of Tsushima','PlayStation 4',1299.00,32,'Sucker Punch','2020-07-17'),(87,'Spider-Man: Miles Morales','PlayStation 5',1499.00,25,'Insomniac Games','2020-11-12'),(88,'Among Us','PC',79.00,40,'InnerSloth','2018-11-16'),(89,'Fall Guys','PC',399.00,19,'Mediatonic','2020-08-04'),(90,'Resident Evil Village','PlayStation 5',1499.00,20,'Capcom','2021-05-07'),(91,'Far Cry 6','PC',1399.00,22,'Ubisoft','2021-10-07'),(92,'Battlefield 2042','PlayStation 5',1499.00,12,'DICE','2021-11-19'),(93,'Halo Infinite','Xbox Series X',1499.00,30,'343 Industries','2021-12-08'),(94,'Ratchet & Clank: Rift Apart','PlayStation 5',1599.00,17,'Insomniac Games','2021-06-11'),(95,'Elden Ring','PlayStation 4',1399.00,10,'FromSoftware','2022-02-25'),(96,'Dying Light 2','PC',1299.00,28,'Techland','2022-02-04'),(97,'Diablo II: Resurrected','PC',999.00,15,'Blizzard Entertainment','2021-09-23'),(98,'Forza Horizon 5','Xbox Series X',1499.00,16,'Playground Games','2021-11-09'),(99,'Mario Kart 8 Deluxe','Nintendo Switch',1399.00,37,'Nintendo','2017-04-28'),(100,'Super Smash Bros. Ultimate','Nintendo Switch',1399.00,29,'Nintendo','2018-12-07'),(101,'Metroid Dread','Nintendo Switch',1299.00,20,'Nintendo','2021-10-08'),(102,'Hades','PC',399.00,15,'Supergiant Games','2020-09-17'),(103,'Cuphead','PC',299.00,25,'Studio MDHR','2017-09-29'),(104,'Control','PlayStation 4',899.00,18,'Remedy Entertainment','2019-08-27'),(105,'Sekiro: Shadows Die Twice','PlayStation 4',1199.00,14,'FromSoftware','2019-03-22'),(106,'Dark Souls III','PC',599.00,28,'FromSoftware','2016-04-12'),(107,'NBA 2K22','PlayStation 5',1499.00,11,'Visual Concepts','2021-09-10'),(108,'Mortal Kombat 11','PlayStation 4',999.00,32,'NetherRealm Studios','2019-04-23'),(109,'Crash Bandicoot 4: Its About Time','PlayStation 4',999.00,23,'Toys for Bob','2020-10-02'),(110,'Tales of Arise','PlayStation 5',1499.00,10,'Bandai Namco','2021-09-10'),(111,'Final Fantasy VII Remake','PlayStation 4',1399.00,12,'Square Enix','2020-04-10'),(112,'NieR: Automata','PC',799.00,30,'PlatinumGames','2017-03-17'),(113,'Dragon Quest XI S','Nintendo Switch',999.00,15,'Square Enix','2019-09-27'),(114,'Monster Hunter Rise','Nintendo Switch',1399.00,14,'Capcom','2021-03-26'),(115,'Persona 5 Royal','PlayStation 4',999.00,19,'Atlus','2020-03-31'),(116,'Yakuza: Like a Dragon','PlayStation 4',1299.00,20,'Ryu Ga Gotoku Studio','2020-11-10'),(117,'Shin Megami Tensei V','Nintendo Switch',1499.00,10,'Atlus','2021-11-12'),(118,'Gears 5','Xbox Series X',799.00,20,'The Coalition','2019-09-10'),(119,'Borderlands 3','PlayStation 4',899.00,25,'Gearbox Software','2019-09-13'),(120,'Death Stranding','PlayStation 4',999.00,16,'Kojima Productions','2019-11-08'),(121,'Resident Evil 3','PlayStation 4',1299.00,10,'Capcom','2020-04-03'),(122,'Nioh 2','PlayStation 4',1299.00,20,'Team Ninja','2020-03-13'),(123,'The Outer Worlds','PC',999.00,22,'Obsidian Entertainment','2019-10-25'),(124,'Ghostrunner','PC',699.00,35,'One More Level','2020-10-27'),(125,'Disco Elysium','PC',499.00,29,'ZA/UM','2019-10-15'),(126,'Ori and the Will of the Wisps','PC',599.00,18,'Moon Studios','2020-03-11'),(127,'Fire Emblem: Three Houses','Nintendo Switch',1399.00,27,'Intelligent Systems','2019-07-26'),(128,'Luigis Mansion 3','Nintendo Switch',1399.00,23,'Nintendo','2019-10-31'),(129,'Splatoon 2','Nintendo Switch',1199.00,32,'Nintendo','2017-07-21'),(130,'The Sims 4','PC',499.00,40,'Maxis','2014-09-02');
/*!40000 ALTER TABLE `videojuegos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-27 11:04:33
