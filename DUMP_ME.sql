CREATE DATABASE IF NOT EXISTS `base`; 
USE `base`;

CREATE TABLE `users` (
	`id` VARCHAR(50) NOT NULL,
	`license` VARCHAR(50) NULL DEFAULT NULL,
	`username` VARCHAR(50) NULL DEFAULT NULL,
	`lastPosition` VARCHAR(255) NULL DEFAULT NULL,
	`rank` VARCHAR(25) NULL DEFAULT 'user',
	PRIMARY KEY (`id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
