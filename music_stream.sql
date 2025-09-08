CREATE DATABASE IF NOT EXISTS `Music Stream`;
USE `Music Stream`;

CREATE TABLE `Last fm` (
  `Artist` VARCHAR(100) PRIMARY KEY,
  `Genre` VARCHAR(100),
  `Set year` YEAR,
  `Similars` VARCHAR(255),
  `Biography` VARCHAR(1000),
  `Listeners` INT,
  `Playcount` INT);

CREATE TABLE spotipy (
  `Track` VARCHAR(255) PRIMARY KEY,
  `Album` VARCHAR(255),
  `Release year` YEAR,
  `Artist` VARCHAR(255),
  `Popularity` INT,
  `Genre` VARCHAR(100),
  FOREIGN KEY (artist) REFERENCES `Last fm` (`Artist`)
  ON UPDATE CASCADE
  ON DELETE CASCADE);
  


