﻿--
-- Script was generated by Devart dbForge Studio 2019 for MySQL, Version 8.1.22.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 2023.03.30. 21:44:57
-- Server version: 5.5.5-10.4.27-MariaDB
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

DROP DATABASE IF EXISTS taxi5;

CREATE DATABASE IF NOT EXISTS taxi5
	CHARACTER SET utf8
	COLLATE utf8_hungarian_ci;

--
-- Set default database
--
USE taxi5;

--
-- Create table `users`
--
CREATE TABLE IF NOT EXISTS users (
  id INT(11) NOT NULL AUTO_INCREMENT,
  firstName VARCHAR(50) DEFAULT NULL,
  lastName VARCHAR(50) DEFAULT NULL,
  gender VARCHAR(10) DEFAULT NULL,
  userName VARCHAR(50) DEFAULT NULL,
  email VARCHAR(255) DEFAULT NULL,
  password VARCHAR(100) DEFAULT NULL,
  number INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 24,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

--
-- Create index `UK_users_email` on table `users`
--
ALTER TABLE users 
  ADD UNIQUE INDEX UK_users_email(email);

--
-- Create index `UK_users_userName` on table `users`
--
ALTER TABLE users 
  ADD UNIQUE INDEX UK_users_userName(userName);

DELIMITER $$

--
-- Create function `randomInteger`
--
CREATE DEFINER = 'root'@'localhost'
FUNCTION IF NOT EXISTS randomInteger(min int, max int)
  RETURNS int(11)
BEGIN

RETURN FLOOR(min + RAND()*(max-min+1));
END
$$

--
-- Create function `randomLicensPlate`
--
CREATE DEFINER = 'root'@'localhost'
FUNCTION IF NOT EXISTS randomLicensPlate(carName varchar(255))
  RETURNS varchar(255) CHARSET utf8 COLLATE utf8_hungarian_ci
BEGIN
set @word = concat(left(carName,1),left(carName,1),left(carName,1));
set @number = randomInteger(100,999);
set @rsz = concat(@word, '-', @number);

RETURN @rsz;
END
$$

--
-- Create function `randomCar`
--
CREATE DEFINER = 'root'@'localhost'
FUNCTION IF NOT EXISTS randomCar()
  RETURNS varchar(255) CHARSET utf8 COLLATE utf8_hungarian_ci
BEGIN

RETURN ELT(randomInteger(1,5),'Mercedesz','Fiat','BMW','Volvo','Toyota');
END
$$

DELIMITER ;

--
-- Create table `drivers`
--
CREATE TABLE IF NOT EXISTS drivers (
  id INT(11) NOT NULL AUTO_INCREMENT,
  driverName VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 16,
AVG_ROW_LENGTH = 1092,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

--
-- Create table `cars`
--
CREATE TABLE IF NOT EXISTS cars (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  licenceNumber VARCHAR(255) DEFAULT NULL,
  hourlyRate INT(11) DEFAULT NULL,
  outOfTraffic TINYINT(4) DEFAULT 0,
  driverId INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 605,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

--
-- Create foreign key
--
ALTER TABLE cars 
  ADD CONSTRAINT FK_cars_drivers_id FOREIGN KEY (driverId)
    REFERENCES drivers(id);

--
-- Create table `trips`
--
CREATE TABLE IF NOT EXISTS trips (
  id INT(11) NOT NULL AUTO_INCREMENT,
  numberOfMinits INT(11) DEFAULT NULL,
  date DATETIME DEFAULT NULL,
  carId INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3544,
AVG_ROW_LENGTH = 2048,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

--
-- Create foreign key
--
ALTER TABLE trips 
  ADD CONSTRAINT FK_trips_cars_id FOREIGN KEY (carId)
    REFERENCES cars(id);

DELIMITER $$

--
-- Create procedure `tesztAdatgeneratorStaikus`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE tesztAdatgeneratorStaikus()
BEGIN

DELETE
  FROM trips;
DELETE
  FROM cars;
DELETE
  FROM users;


INSERT cars (id, name, licenceNumber, hourlyRate)
  VALUES (1, 'Mercedes', 'MM-111', 2500), (2, 'BMW', 'BB-111', 2700), (3, 'Fiat', 'FF-111', 2200);

INSERT trips (numberOfMinits, date, carId)
  VALUES (25, '2022.11.12 12:22:00', 1), (15, '2022.11.12 13:30:00', 1), (35, '2022.11.12 15:30:00', 1),
  (22, '2022.11.12 12:12:00', 2), (32, '2022.11.12 12:50:00', 2),
  (33, '2022.11.12 12:22:00', 3), (12, '2022.11.12 13:45:00', 3), (45, '2022.11.12 15:22:00', 3);

INSERT users (id, email, password)
  VALUES (1, 'geza@gmail.com', 'gezajelszo'), (2, 'jozsi@gmail.com', 'jozsijelszo'), (3, 'feri@gmail.com', 'ferijelszo');

SELECT
  *
FROM cars;
SELECT
  *
FROM trips;
SELECT
  *
FROM users;

END
$$

--
-- Create procedure `tesztAdatgeneratorDinamikus`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE tesztAdatgeneratorDinamikus(carCount int, dateValue varchar(255), tripCountMin int, tripCountMax int)
BEGIN

DELETE
  FROM trips;
DELETE
  FROM cars;
DELETE
  FROM drivers;

# Vezetők generálása
INSERT drivers (id, driverName)
  VALUES (1, 'Béla'), (2, 'Feri'), (3, 'Áron'), (4, 'Géza'), (5, 'Benő'),
  (6, 'Józsi'), (7, 'Miklós'), (8, 'Ernő'), (9, 'Zsolt'), (10, 'Hugó'),
  (11, 'Tibor'), (12, 'Jenő'), (13, 'Attila'), (14, 'Gyuri'), (15, 'János');

set @a = 1;

simple_loop: LOOP         
    
    #véletlen autó
    set @car = randomCar();

INSERT cars (id, name, licenceNumber, hourlyRate, driverId)
  VALUES (@a, @car, randomLicensPlate(@car), randomInteger(2000, 3000), @a);

    #trips-ek
    set @t = 1;
    set @deltaMinits = 0;
    set @tripsCount =  randomInteger(tripCountMin, tripCountMax);
    trips_loop: LOOP 
       
       set @numberOfMinits =  randomInteger(15, 60);
 #eddig tart egy fuvar
       set @pauseMinits = randomInteger(0, 60);
 #várakozási idő a következő fuvarig
       set @deltaMinits =  @deltaMinits + @numberOfMinits + @pauseMinits;
#TIMESTAMPADD(MINUTE, @deltaMInits), dateValue)

#trips készítése

INSERT trips (numberOfMinits, date, carId)
  VALUES (@numberOfMinits, TIMESTAMPADD(MINUTE, @deltaMinits, dateValue), @a);

       SET @t=@t+1;
       IF @t>@tripsCount THEN
          LEAVE trips_loop;
       END IF;
    END LOOP trips_loop;


   SET @a=@a+1;
   IF @a>carCount THEN
      LEAVE simple_loop;
   END IF;
END LOOP simple_loop;


SELECT
  *
FROM cars;
SELECT
  *
FROM trips;
SELECT
  *
FROM drivers;
SELECT
  *
FROM users;

END
$$

DELIMITER ;

-- 
-- Dumping data for table drivers
--
INSERT INTO drivers VALUES
(1, 'Béla'),
(2, 'Feri'),
(3, 'Áron'),
(4, 'Géza'),
(5, 'Benő'),
(6, 'Józsi'),
(7, 'Miklós'),
(8, 'Ernő'),
(9, 'Zsolt'),
(10, 'Hugó'),
(11, 'Tibor'),
(12, 'Jenő'),
(13, 'Attila'),
(14, 'Gyuri'),
(15, 'János');

-- 
-- Dumping data for table cars
--
INSERT INTO cars VALUES
(1, 'Fiat', 'FFF-490', 2506, 0, 1),
(2, 'Volvo', 'VVV-369', 2587, 0, 2),
(3, 'Mercedesz', 'MMM-960', 2242, 0, 3),
(4, 'Mercedesz', 'MMM-816', 2835, 0, 4),
(5, 'Toyota', 'TTT-486', 2271, 0, 5),
(6, 'BMW', 'BBB-340', 2812, 0, 6),
(7, 'Volvo', 'VVV-325', 2149, 0, 7),
(8, 'Mercedesz', 'MMM-599', 2318, 0, 8),
(9, 'Toyota', 'TTT-199', 2602, 0, 9),
(10, 'Toyota', 'TTT-357', 2658, 0, 10);

-- 
-- Dumping data for table users
--
INSERT INTO users VALUES
(1, NULL, NULL, NULL, NULL, 'geza@gmail.com', 'gezajelszo', NULL),
(2, NULL, NULL, NULL, NULL, 'jozsi@gmail.com', 'jozsijelszo', NULL),
(3, NULL, NULL, NULL, NULL, 'feri@gmail.com', 'ferijelszo', NULL),
(14, 'Géza', 'Balog', 'férfi', 'geza', 'balog.geza@gmail.com', '$2b$10$QujnJRlebJJv1z5SCN0GF.J02uWxhE5WGfUq/cmlP.87/KKGHOG3q', 123456),
(15, 'Feri', 'Fehér', 'férfi', 'feri', 'feher.feri@gmail.com', '$2b$10$eEoAKAxZy3qrlV.vpUgUy.SZrwtXG00wsqu87dvWrqNntFYtSHNvW', 33333333),
(19, 'h', 'Fehér', 'férfi', 'h', 'feher.h@gmail.com', '$2b$10$IKCOg8DDwXX377fQGb69NOmnyaepncab2vkJlDceCqLnjvwLAV/ea', 33333333),
(22, 'h', 'Fehér', 'férfi', 'h1', 'feher.h1@gmail.com', '$2b$10$Sxv0wo1I.hSDJmT96aVewuWmBV14Cdof7D.iN.TXka5Rflx53Z916', 33333333),
(23, 'Jani', 'Nagy', 'férfi', 'jani', 'nagy.jani@gmail.com', '$2b$10$Bx5gZei.c2scZNowzNYFH.yJ7wUp86EdPKke/SgqRi0U4NBMZF8u.', 1);

-- 
-- Dumping data for table trips
--
INSERT INTO trips VALUES
(3510, 43, '2022-10-13 13:07:00', 1),
(3511, 22, '2022-10-13 14:07:00', 1),
(3512, 34, '2022-10-13 13:32:00', 2),
(3513, 41, '2022-10-13 15:12:00', 2),
(3514, 60, '2022-10-13 13:53:00', 3),
(3515, 36, '2022-10-13 15:12:00', 3),
(3516, 20, '2022-10-13 16:01:00', 3),
(3517, 34, '2022-10-13 13:22:00', 4),
(3518, 47, '2022-10-13 14:15:00', 4),
(3519, 33, '2022-10-13 15:30:00', 4),
(3520, 27, '2022-10-13 16:12:00', 4),
(3521, 35, '2022-10-13 17:14:00', 4),
(3522, 39, '2022-10-13 13:04:00', 5),
(3523, 39, '2022-10-13 14:08:00', 5),
(3524, 53, '2022-10-13 13:21:00', 6),
(3525, 51, '2022-10-13 14:48:00', 6),
(3526, 41, '2022-10-13 15:34:00', 6),
(3527, 39, '2022-10-13 13:20:00', 7),
(3528, 51, '2022-10-13 15:07:00', 7),
(3529, 25, '2022-10-13 15:53:00', 7),
(3530, 19, '2022-10-13 16:39:00', 7),
(3531, 58, '2022-10-13 18:01:00', 7),
(3532, 45, '2022-10-13 13:20:00', 8),
(3533, 56, '2022-10-13 15:05:00', 8),
(3534, 28, '2022-10-13 15:34:00', 8),
(3535, 26, '2022-10-13 16:08:00', 8),
(3536, 15, '2022-10-13 16:59:00', 8),
(3537, 42, '2022-10-13 13:39:00', 9),
(3538, 56, '2022-10-13 15:16:00', 9),
(3539, 48, '2022-10-13 16:36:00', 9),
(3540, 40, '2022-10-13 17:22:00', 9),
(3541, 22, '2022-10-13 12:55:00', 10),
(3542, 24, '2022-10-13 13:46:00', 10),
(3543, 41, '2022-10-13 15:03:00', 10);

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;