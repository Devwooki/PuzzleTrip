CREATE TABLE IF NOT EXISTS `enjoytrip`.`file_info` (
    `idx` INT NOT NULL AUTO_INCREMENT,
    `board_no` INT NULL DEFAULT NULL,
    `save_folder` VARCHAR(45) NULL DEFAULT NULL,
    `original_file` VARCHAR(50) NULL DEFAULT NULL,
    `save_file` VARCHAR(50) NULL DEFAULT NULL,
    PRIMARY KEY (`idx`),
    INDEX `file_info_to_board_article_no_fk` (`board_no` ASC) VISIBLE,
    CONSTRAINT `file_info_to_board_article_no_fk`
    FOREIGN KEY (`board`)
    REFERENCES `enjoytrip`.`board` (`no`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;