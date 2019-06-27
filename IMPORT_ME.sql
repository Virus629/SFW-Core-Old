CREATE DATABASE IF NOT EXISTS `base`; 
USE `base`;

CREATE TABLE IF NOT EXISTS `users` (
    `id` varchar(50) NULL,
    `license` varchar(50) NULL,
    `username` varchar(50) NULL,

    PRIMARY KEY (`id`)
);
