CREATE DATABASE IF NOT EXISTS `base`; 
USE `base`;

CREATE TABLE IF NOT EXISTS `users` (
    `id` varchar(20) NULL,
    `license` varchar(50) NULL,
    `username` varchar(50) NULL,
    PRIMARY KEY (`id`)
); #Creates users table where we store user information
