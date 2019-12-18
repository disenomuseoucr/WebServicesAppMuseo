-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 18-12-2019 a las 21:03:03
-- Versión del servidor: 5.7.28-0ubuntu0.18.04.4
-- Versión de PHP: 7.2.24-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `prueba`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`prueba`@`%` PROCEDURE `SP_DELETE_INACTIVE_USERS` ()  BEGIN
   DECLARE v_uid   BIGINT(20) unsigned;
      DECLARE exit_loop BOOLEAN;         
      DECLARE inactive_users_cursor CURSOR FOR
	SELECT UID FROM USER WHERE TIMESTAMPDIFF(MINUTE,LAST_ACTIVITY,NOW()) > 70 AND USER_TYPE = 0;
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
      OPEN inactive_users_cursor;
      inactive_users_loop: LOOP
          FETCH  inactive_users_cursor INTO v_uid;
               DELETE FROM USER WHERE UID = v_uid;
     IF exit_loop THEN
         CLOSE inactive_users_cursor;
         LEAVE inactive_users_loop;
     END IF;
   END LOOP inactive_users_loop;
 END$$

CREATE DEFINER=`prueba`@`%` PROCEDURE `SP_SET_CUSTOM_VAL` (`sSeqName` VARCHAR(50), `sSeqGroup` VARCHAR(10), `nVal` INT UNSIGNED)  BEGIN
    IF (SELECT COUNT(*) FROM SEQUENCE  
            WHERE SEQ_NAME = sSeqName  
                AND SEQ_GROUP = sSeqGroup) = 0 THEN
        INSERT INTO SEQUENCE (seq_name,seq_group,seq_val)
        VALUES (sSeqName,sSeqGroup,nVal);
    ELSE
        UPDATE SEQUENCE SET SEQ_VAL = nVal
        WHERE SEQ_NAME = sSeqName AND SEQ_GROUP = sSeqGroup;
    END IF;
END$$

--
-- Funciones
--
CREATE DEFINER=`prueba`@`%` FUNCTION `FC_GET_NEXT_CUSTOM_SEQ` (`sSeqName` VARCHAR(50), `sSeqGroup` VARCHAR(10)) RETURNS VARCHAR(20) CHARSET latin1 BEGIN
    DECLARE nLast_val INT; 
 
    SET nLast_val =  (SELECT SEQ_VAL
                          FROM SEQUENCE
                          WHERE SEQ_NAME = sSeqName
                                AND SEQ_GROUP = sSeqGroup);
    IF nLast_val IS NULL THEN
        SET nLast_val = 1;
        INSERT INTO SEQUENCE (SEQ_NAME,SEQ_GROUP,SEQ_VAL)
        VALUES (sSeqName,sSeqGroup,nLast_Val);
    ELSE
        SET nLast_val = nLast_val + 1;
        UPDATE SEQUENCE SET SEQ_VAL = nLast_val
        WHERE SEQ_NAME = sSeqName AND SEQ_GROUP = sSeqGroup;
    END IF; 
 
    SET @ret = (SELECT concat(sSeqGroup,'-',lpad(nLast_val,16,'0')));
    RETURN @ret;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SCREEN`
--

CREATE TABLE `SCREEN` (
  `ID` int(11) NOT NULL,
  `NAME` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `SCREEN`
--

INSERT INTO `SCREEN` (`ID`, `NAME`) VALUES
(1, 'Inicio'),
(2, 'Tutorial'),
(3, 'Creditos'),
(4, 'Preferencias');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SCREEN_DATA`
--

CREATE TABLE `SCREEN_DATA` (
  `ID` int(11) NOT NULL,
  `SCREEN_ID` int(11) DEFAULT NULL,
  `ORDER_DATA` int(11) DEFAULT NULL,
  `DATA_TYPE` varchar(15) DEFAULT NULL,
  `DATA_CONTENT` text NOT NULL,
  `CAPTION` text,
  `IS_TITLE` tinyint(4) DEFAULT NULL,
  `IS_SUBTITLE` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `SCREEN_DATA`
--

INSERT INTO `SCREEN_DATA` (`ID`, `SCREEN_ID`, `ORDER_DATA`, `DATA_TYPE`, `DATA_CONTENT`, `CAPTION`, `IS_TITLE`, `IS_SUBTITLE`) VALUES
(1, 1, 1, 'txt', '¡A conocer el campus!', NULL, 1, 0),
(2, 1, 2, 'img', 'https://comunidad.inie.ucr.ac.cr/pruebas/media/images/tempera_baja_calidad.jpg', NULL, 0, 0),
(3, 1, 3, 'aud', 'https://comunidad.inie.ucr.ac.cr/pruebas/media/audio/introduccion.mp3', NULL, 0, 0),
(4, 1, 4, 'txt', 'Un paseo por el campus es una aplicación para Android, diseñada como una audio guía para descubrir el patrimonio arquitectónico y el arte público de la Ciudad Universitaria Rodrigo Facio Brenes, mientras la recorre. Por medio de audios, textos y fotografías se podrá conocer más sobre los bienes culturales que resguarda la Universidad de Costa Rica.', NULL, 0, 0),
(5, 1, 5, 'txt', 'La aplicación fue desarrollada en su totalidad por estudiantes del curso CI-1430 Ingeniería de Software 2 de la Escuela de Ciencias de la Computación e Informática, con la colaboración de estudiantes con horas asistente, de diversas áreas, del museo+UCR. Así, el museo+UCR se compromete con la divulgación de las colecciones de la UCR y con el apoyo a la docencia.', NULL, 0, 0),
(6, 2, 1, 'txt', 'Tutorial', NULL, 1, 0),
(7, 2, 2, 'txt', 'Este tutorial le enseñará a como utilizar las funciones principales de Un Paseo por el Campus', NULL, 0, 0),
(8, 2, 3, 'txt', 'Para acceder a un sitio debe de mantener el ícono de sitio presionado.', NULL, 0, 0),
(9, 2, 3, 'img', '/media/images/tutorial4.png', NULL, 0, 0),
(10, 2, 4, 'img', '/media/images/tutorial3.png', NULL, 0, 0),
(11, 2, 5, 'img', '/media/images/tutorial5.png', NULL, 0, 0),
(12, 2, 6, 'img', '/media/images/tutorial1.png', NULL, 0, 0),
(13, 2, 7, 'img', '/media/images/tutorial6.png', NULL, 0, 0),
(14, 2, 8, 'img', '/media/images/tutorial2.png', NULL, 0, 0),
(15, 2, 9, 'img', '/media/images/tutorial8.png', NULL, 0, 0),
(16, 2, 10, 'img', '/media/images/tutorial7.png', NULL, 0, 0),
(17, 3, 1, 'txt', 'Créditos', NULL, 1, 0),
(18, 3, 2, 'txt', 'museo+UCR', NULL, 0, 1),
(19, 3, 3, 'txt', 'Eugenia Zavaleta Ochoa\nMariano Chinchilla Chavarría\nMarco Díaz Segura\nAdriana Araya Gochez\nDiana León Torres', NULL, 0, 0),
(20, 3, 4, 'txt', 'ECCI - Escuela de Ciencias de la Computación e Informática', NULL, 0, 1),
(21, 3, 5, 'txt', 'Alan Calderón Castro\r\nEstudiantes curso Ingeniería de Software 2016', NULL, 0, 0),
(22, 3, 6, 'txt', 'Atlantis Code - Equipo de desarrollo', NULL, 0, 1),
(23, 3, 7, 'txt', 'Franklin Rodríguez Vargas\r\nJorge Remón Montealegre\r\nKevin León Sandoval', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SEQUENCE`
--

CREATE TABLE `SEQUENCE` (
  `SEQ_NAME` varchar(50) NOT NULL,
  `SEQ_GROUP` varchar(10) NOT NULL,
  `SEQ_VAL` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `SEQUENCE`
--

INSERT INTO `SEQUENCE` (`SEQ_NAME`, `SEQ_GROUP`, `SEQ_VAL`) VALUES
('SEQ_USER_INVITED', 'INV', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SITE`
--

CREATE TABLE `SITE` (
  `ID` int(11) NOT NULL,
  `LATITUDE` text,
  `LONGITUDE` text,
  `ACCESS_DISTANCE` int(11) DEFAULT NULL,
  `NAME` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `SITE`
--

INSERT INTO `SITE` (`ID`, `LATITUDE`, `LONGITUDE`, `ACCESS_DISTANCE`, `NAME`) VALUES
(1, '9.934535', '-84.052497', 30, 'Edificio de la Escuela de Arquitectura'),
(2, '9.934502', '-84.052941', 15, 'Instituto Confucio y Casa del SINDEU'),
(3, '9.935517', '-84.052101', 30, 'Edificio de la Facultad de Ingeniería'),
(4, '9.935553', '-84.051330', 15, 'Busto del profesor Carlos Monge Alfaro'),
(5, '9.935804', '-84.051154', 15, 'Fuente de cupido y el cisne'),
(6, '9.935693', '-84.050830', 15, 'Estatua de Rodrigo Facio Brenes'),
(7, '9.936010', '-84.050556', 30, 'Edificio de Escuela de Estudios Generales'),
(8, '9.935868', '-84.050632', 30, 'Jardín escultórico'),
(9, '9.9375197', '-84.0487133', 30, 'Edificio de la Escuela de Química'),
(10, '9.9377532', '-84.0489829', 15, 'Busto de Clodomiro Picado por Juan Rafael Chacón'),
(11, '9.9380260', '-84.0490754', 30, 'Edificio de la Facultad de Microbiología'),
(12, '9.9383291', '-84.0490680', 15, 'Busto de Pasteur'),
(13, '9.9387093', '-84.0484984', 15, 'Busto del Ing. Fabio Baudrit Moreno'),
(14, '9.9380871', '-84.0524399', 30, 'Edificio de Escuela Centroamericana de Geología'),
(15, '9.9371032', '-84.0517710', 30, 'Edificio de la Facultad de Ciencias Económicas'),
(16, '9.9363556', '-84.0508044', 15, 'Plaza 24 de abril'),
(17, '9.9365184', '-84.0506927', 15, 'Escultura de Leda Astorga'),
(18, '9.9362321', '-84.0524781', 15, 'Bronce. Marisel Jiménez Rittner. Biblioteca Luis Demetrio Tinoco'),
(19, '9.9357674', '-84.0526015', 15, 'Busto de Luis Demetrio Tinoco'),
(20, '9.9354662', '-84.0545464', 15, 'Busto del Dr. Rafael Angel Calderón Guardia'),
(21, '9.935754', '-84.048694', 15, 'Busto de Omar Dengo'),
(22, '9.9360382', '-84.0540435', 15, 'Busto del Lic. Fernando Baudrit Solera'),
(23, '9.935725', '-84.048650', 15, 'Edificio de la Facultad de Educación'),
(24, '9.938987', '-84.050785', 30, 'Edificio de la Facultad de Medicina'),
(25, '9.938808', '-84.050879', 15, 'Busto del Dr. Solón Núñez Frutos'),
(26, '9.9386883', '-84.051645', 15, 'Busto del Dr. José Joaquín Jiménez N.'),
(27, '9.938684', '-84.052720', 15, 'Eva. Bronce'),
(28, '9.93865', '-84.053014', 15, 'Conjunto de esculturas: bustos de Margarita Bertheau'),
(29, '9.9365745', '-84.0526843', 30, 'Esculturas de José Sancho');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SITE_DATA`
--

CREATE TABLE `SITE_DATA` (
  `ID` int(11) NOT NULL,
  `SITE_ID` int(11) DEFAULT NULL,
  `ORDER_DATA` int(11) DEFAULT NULL,
  `DATA_TYPE` varchar(15) DEFAULT NULL,
  `DATA_CONTENT` text NOT NULL,
  `CAPTION` text,
  `IS_TITLE` tinyint(4) DEFAULT NULL,
  `IS_SUBTITLE` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `SITE_DATA`
--

INSERT INTO `SITE_DATA` (`ID`, `SITE_ID`, `ORDER_DATA`, `DATA_TYPE`, `DATA_CONTENT`, `CAPTION`, `IS_TITLE`, `IS_SUBTITLE`) VALUES
(1, 1, 1, 'TEXT', 'Estas rocas parecen una serie de capas, una encima de otra, por lo que se asemejan al postre\r\nconocido como “torta chilena”. Todas ellas se formaron en el mar por la acumulación de\r\npartículas de arena y bloques de roca a profundidades menores a los doscientos metros. En\r\ngeneral, estas reciben el nombre de rocas sedimentarias.', NULL, 0, 0),
(2, 1, 2, 'TEXT', 'Cada capa se llama estrato y corresponde con variaciones de cuando se estaban\r\nsedimentando en el fondo marino.', NULL, 0, 0),
(3, 1, 3, 'IMAGE', 'https://moodle.htwchur.ch/pluginfile.php/124614/mod_page/content/4/example.jpg', 'Image caption', 0, 0),
(4, 1, 4, 'TEXT', 'Los estratos, que originalmente fueron horizontales, se deformaron e inclinaron por la\r\nacción de las fuerzas de la tierra que actúan sobre las rocas. Dichas fuerzas son las mismas\r\nque producen los terremotos.', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SITE_LIKES`
--

CREATE TABLE `SITE_LIKES` (
  `SITE_ID` int(11) NOT NULL,
  `UID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Disparadores `SITE_LIKES`
--
DELIMITER $$
CREATE TRIGGER `TR_ARD_SITE_LIKES` AFTER DELETE ON `SITE_LIKES` FOR EACH ROW BEGIN
    UPDATE USER SET LAST_ACTIVITY = NOW() WHERE UID = OLD.UID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TR_ARI_SITE_LIKES` AFTER INSERT ON `SITE_LIKES` FOR EACH ROW BEGIN
    UPDATE USER SET LAST_ACTIVITY = NOW() WHERE UID = NEW.UID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `USER`
--

CREATE TABLE `USER` (
  `UID` varchar(20) NOT NULL DEFAULT '',
  `USER_TYPE` tinyint(4) NOT NULL,
  `NAME` varchar(200) NOT NULL,
  `IMEI` varchar(20) NOT NULL,
  `LAST_ACTIVITY` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `USER`
--

INSERT INTO `USER` (`UID`, `USER_TYPE`, `NAME`, `IMEI`, `LAST_ACTIVITY`) VALUES
('111', 0, 'Fulano de Tal 333', '333444555', '2019-11-06 11:03:49'),
('1232', 0, 'Fulano de Tal 3', '333', '2019-10-29 16:18:39'),
('12345', 1, 'Fulano de Tal FB', '333444555999', '2019-11-06 11:39:41'),
('123456', 1, 'Fulano de Tal FB', '333444555999', '2019-11-06 12:21:31'),
('1630889670375030', 1, 'Kevin LeÃ³n', '123', '2019-10-28 14:08:10'),
('2365349966888961', 1, 'Franklin Rodríguez Vargas', '456', '2019-10-30 19:40:17'),
('5204184673559993', 0, 'Usuario anonimo', '789', '2019-10-28 14:08:22'),
('INV-0000000000000001', 0, 'INVITADO', '012', '2019-10-28 14:08:31'),
('INV-0000000000000002', 0, 'Perico de los Palotes', '345', '2019-10-28 14:11:30'),
('INV-0000000000000003', 0, 'Fulano de Tal 333', '333444555666', '2019-11-06 11:04:08'),
('INV-0000000000000005', 0, 'Fulano de Tal 444', '333444555777', '2019-11-06 12:21:04');

--
-- Disparadores `USER`
--
DELIMITER $$
CREATE TRIGGER `TR_BRI_USER` BEFORE INSERT ON `USER` FOR EACH ROW BEGIN
	SET time_zone = '-06:00';
	SET NEW.LAST_ACTIVITY = NOW();
	IF NEW.UID = '' AND NEW.USER_TYPE = 0 THEN
		SET NEW.UID = FC_GET_NEXT_CUSTOM_SEQ("SEQ_USER_INVITED","INV");
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TR_BRU_USER` BEFORE UPDATE ON `USER` FOR EACH ROW BEGIN
	SET time_zone = '-06:00';
	SET NEW.LAST_ACTIVITY = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `USER_SITE`
--

CREATE TABLE `USER_SITE` (
  `UID` varchar(20) NOT NULL,
  `SITE_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `USER_SITE`
--

INSERT INTO `USER_SITE` (`UID`, `SITE_ID`) VALUES
('2365349966888961', 1);

--
-- Disparadores `USER_SITE`
--
DELIMITER $$
CREATE TRIGGER `TR_ARD_USER_SITE` AFTER DELETE ON `USER_SITE` FOR EACH ROW BEGIN
    UPDATE USER SET LAST_ACTIVITY = NOW() WHERE UID = OLD.UID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TR_ARI_USER_SITE` AFTER INSERT ON `USER_SITE` FOR EACH ROW BEGIN
    UPDATE USER SET LAST_ACTIVITY = NOW() WHERE UID = NEW.UID;
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `SCREEN`
--
ALTER TABLE `SCREEN`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `SCREEN_DATA`
--
ALTER TABLE `SCREEN_DATA`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_SCREEN_DATA_SCREEN` (`SCREEN_ID`);

--
-- Indices de la tabla `SEQUENCE`
--
ALTER TABLE `SEQUENCE`
  ADD PRIMARY KEY (`SEQ_NAME`);

--
-- Indices de la tabla `SITE`
--
ALTER TABLE `SITE`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `SITE_DATA`
--
ALTER TABLE `SITE_DATA`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_SITE_DATA_SITE` (`SITE_ID`);

--
-- Indices de la tabla `SITE_LIKES`
--
ALTER TABLE `SITE_LIKES`
  ADD PRIMARY KEY (`SITE_ID`,`UID`),
  ADD KEY `FK_SITE_LIKES_USER` (`UID`);

--
-- Indices de la tabla `USER`
--
ALTER TABLE `USER`
  ADD PRIMARY KEY (`UID`);

--
-- Indices de la tabla `USER_SITE`
--
ALTER TABLE `USER_SITE`
  ADD PRIMARY KEY (`UID`,`SITE_ID`),
  ADD KEY `FK_USER_SITE_SITE` (`SITE_ID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `SCREEN`
--
ALTER TABLE `SCREEN`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `SCREEN_DATA`
--
ALTER TABLE `SCREEN_DATA`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT de la tabla `SITE`
--
ALTER TABLE `SITE`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT de la tabla `SITE_DATA`
--
ALTER TABLE `SITE_DATA`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `SCREEN_DATA`
--
ALTER TABLE `SCREEN_DATA`
  ADD CONSTRAINT `FK_SCREEN_DATA_SCREEN` FOREIGN KEY (`SCREEN_ID`) REFERENCES `SCREEN` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `SITE_DATA`
--
ALTER TABLE `SITE_DATA`
  ADD CONSTRAINT `FK_SITE_DATA_SITE` FOREIGN KEY (`SITE_ID`) REFERENCES `SITE` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `SITE_LIKES`
--
ALTER TABLE `SITE_LIKES`
  ADD CONSTRAINT `FK_SITE_LIKES_USER` FOREIGN KEY (`UID`) REFERENCES `USER` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SITE_SITE_LIKES` FOREIGN KEY (`SITE_ID`) REFERENCES `SITE` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `USER_SITE`
--
ALTER TABLE `USER_SITE`
  ADD CONSTRAINT `FK_USER_SITE_SITE` FOREIGN KEY (`SITE_ID`) REFERENCES `SITE` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_USER_SITE_USER` FOREIGN KEY (`UID`) REFERENCES `USER` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`prueba`@`%` EVENT `EV_DELETE_INACTIVE_USERS` ON SCHEDULE EVERY 3 MONTH STARTS '2019-09-09 03:45:13' ON COMPLETION NOT PRESERVE ENABLE DO CALL SP_DELETE_INACTIVE_USERS()$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
