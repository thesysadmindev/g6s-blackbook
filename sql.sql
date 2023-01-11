CREATE TABLE `blackbook` (
	`name` VARCHAR(128) NOT NULL COLLATE 'latin1_swedish_ci',
	`steam` VARCHAR(60) NOT NULL COLLATE 'latin1_swedish_ci',
	`license` VARCHAR(60) NOT NULL COLLATE 'latin1_swedish_ci',
	`ip` VARCHAR(60) NOT NULL COLLATE 'latin1_swedish_ci',
	`xbl` VARCHAR(60) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`live` VARCHAR(60) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`discord` VARCHAR(60) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`fivem` VARCHAR(60) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`token` VARCHAR(128) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`lastconnect` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`license`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
