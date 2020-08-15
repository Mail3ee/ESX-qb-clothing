CREATE TABLE `playerskins` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`citizenid` VARCHAR(255) NOT NULL,
	`model` VARCHAR(255) NOT NULL,
	`skin` TEXT NOT NULL,
	`active` TINYINT(2) NOT NULL DEFAULT 1,
	PRIMARY KEY (`id`),
	INDEX `citizenid` (`citizenid`),
	INDEX `active` (`active`)
)

CREATE TABLE `player_outfits` (
	`id` INT(11) NOT NULL,
	`citizenid` VARCHAR(50) NULL DEFAULT NULL,
	`outfitname` VARCHAR(50) NOT NULL,
	`model` VARCHAR(50) NULL DEFAULT NULL,
	`skin` TEXT NULL DEFAULT NULL,
	`outfitId` VARCHAR(50) NOT NULL
)