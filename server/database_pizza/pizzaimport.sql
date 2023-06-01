
CREATE TABLE pizza (
    id INT PRIMARY KEY,
    nev VARCHAR(50),
    meret INT,
    ar INT
);

CREATE TABLE rendeles (
    id INT PRIMARY KEY,
    pizzaid INT,
    darab INT,
    cimid INT,
    szallitas DATETIME
);

CREATE TABLE cim (
    id INT PRIMARY KEY,
    nev VARCHAR(50),
    utca VARCHAR(50),
    hsz VARCHAR(10)
);

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

#tesztadatok generálása start
delete from rendeles;
delete from pizza;
delete from cim;

LOAD DATA INFILE 'pizza.txt'
INTO TABLE pizza
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA INFILE 'cim.txt'
INTO TABLE cim
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA INFILE 'rendeles.txt'
INTO TABLE rendeles
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

SELECT * FROM pizza;
SELECT * FROM rendeles;
SELECT * FROM cim;

#tesztadatok generálása vége