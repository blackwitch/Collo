-- account and password for connectiong mysql
  -- account : tester
  -- password : test_pw

-- database : dbtest1 
CREATE DATABASE IF NOT EXISTS `dbtest1` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dbtest1`;

-- table : dbtest1.tb4read
CREATE TABLE IF NOT EXISTS `tb4read` (
  `sqn` int(11) NOT NULL AUTO_INCREMENT,
  `company` char(50) NOT NULL DEFAULT '0',
  `sales` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`sqn`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- table : dbtest1.tb4write
CREATE TABLE IF NOT EXISTS `tb4write` (
  `company` char(50) DEFAULT NULL,
  `sales` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- database : dbtest2
CREATE DATABASE IF NOT EXISTS `dbtest2` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dbtest2`;

-- table : dbtest2.tb4read
CREATE TABLE IF NOT EXISTS `tb4read` (
  `sqn` int(11) NOT NULL AUTO_INCREMENT,
  `company` char(50) NOT NULL DEFAULT '0',
  `sales` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`sqn`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE USER 'tester'@'%' IDENTIFIED BY 'test_pw';
GRANT ALL PRIVILEGES ON dbtest1.* TO 'tester'@'%' ;
GRANT ALL PRIVILEGES ON dbtest2.* TO 'tester'@'%';
flush privileges;
