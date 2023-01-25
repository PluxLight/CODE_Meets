-- MySQL Script generated by MySQL Workbench
-- Fri Jan 20 14:28:01 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema s08p11d109
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema s08p11d109
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `s08p11d109` DEFAULT CHARACTER SET utf8mb4 ;
USE `s08p11d109` ;

-- -----------------------------------------------------
-- Table `s08p11d109`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`user` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`user` (
  `user_pk` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(16) NOT NULL,
  `password` VARCHAR(1000) NOT NULL,
  `token` VARCHAR(256) NULL,
  `user_active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`user_pk`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`user_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`user_info` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`user_info` (
  `user_info_pk` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(10) NOT NULL,
  `nickname` VARCHAR(16) NULL,
  `tel` VARCHAR(13) NULL,
  `email` VARCHAR(45) NULL,
  `profile_photo` VARCHAR(512) NULL,
  `email_public` TINYINT NOT NULL DEFAULT 1,
  `tel_public` TINYINT NOT NULL DEFAULT 1,
  `user_pk` INT NOT NULL,
  PRIMARY KEY (`user_info_pk`),
  UNIQUE INDEX `user_info_pk_UNIQUE` (`user_info_pk` ASC),
  UNIQUE INDEX `tel_UNIQUE` (`tel` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `user-user_info_idx` (`user_pk` ASC),
  CONSTRAINT `user_info.user_pk`
    FOREIGN KEY (`user_pk`)
    REFERENCES `s08p11d109`.`user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`group` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`group` (
  `group_pk` INT NOT NULL AUTO_INCREMENT,
  `group_name` VARCHAR(100) NOT NULL,
  `group_desc` VARCHAR(200) NULL,
  `manager_id` INT NOT NULL,
  `group_url` VARCHAR(512) NULL,
  PRIMARY KEY (`group_pk`),
  UNIQUE INDEX `group_pk_UNIQUE` (`group_pk` ASC),
  INDEX `user-group_idx` (`manager_id` ASC),
  CONSTRAINT `group.manager_id`
    FOREIGN KEY (`manager_id`)
    REFERENCES `s08p11d109`.`user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`group-user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`group-user` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`group-user` (
  `group_user_pk` INT NOT NULL AUTO_INCREMENT,
  `group_user_position` INT NOT NULL DEFAULT 3,
  `group_pk` INT NOT NULL,
  `user_pk` INT NOT NULL,
  PRIMARY KEY (`group_user_pk`),
  UNIQUE INDEX `group_user_pk_UNIQUE` (`group_user_pk` ASC),
  INDEX `user-group_user.user_pk_idx` (`user_pk` ASC),
  INDEX `group-group-user.group_pk_idx` (`group_pk` ASC),
  CONSTRAINT `group-user.user_pk`
    FOREIGN KEY (`user_pk`)
    REFERENCES `s08p11d109`.`user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `group-user.group_pk`
    FOREIGN KEY (`group_pk`)
    REFERENCES `s08p11d109`.`group` (`group_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`group_notice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`group_notice` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`group_notice` (
  `group_notice_pk` INT NOT NULL AUTO_INCREMENT,
  `group_notice_title` VARCHAR(100) NOT NULL,
  `group_notice_contents` VARCHAR(500) NOT NULL,
  `upload_file` JSON NULL,
  `group_notice_date` DATE NOT NULL,
  `group_pk` INT NOT NULL,
  `user_pk` INT NOT NULL,
  `group_notice_hit` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_notice_pk`),
  UNIQUE INDEX `group_notice_pk_UNIQUE` (`group_notice_pk` ASC),
  INDEX `group_notice.user_pk_idx` (`user_pk` ASC),
  INDEX `group_notice.group_pk_idx` (`group_pk` ASC),
  CONSTRAINT `group_notice.group_pk`
    FOREIGN KEY (`group_pk`)
    REFERENCES `s08p11d109`.`group-user` (`group_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `group_notice.user_pk`
    FOREIGN KEY (`user_pk`)
    REFERENCES `s08p11d109`.`group-user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`group_question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`group_question` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`group_question` (
  `group_question_pk` INT NOT NULL AUTO_INCREMENT,
  `group_question_title` VARCHAR(100) NOT NULL,
  `group_question_contents` VARCHAR(500) NOT NULL,
  `group_question_date` DATE NOT NULL,
  `group_question_update` TINYINT NOT NULL DEFAULT 0,
  `group_question_like` JSON NOT NULL,
  `group_pk` INT NOT NULL,
  `user_pk` INT NOT NULL,
  PRIMARY KEY (`group_question_pk`),
  UNIQUE INDEX `group_question_pk_UNIQUE` (`group_question_pk` ASC),
  INDEX `group_question.group_pk_idx` (`group_pk` ASC),
  INDEX `group_question.user_pk_idx` (`user_pk` ASC),
  CONSTRAINT `group_question.group_pk`
    FOREIGN KEY (`group_pk`)
    REFERENCES `s08p11d109`.`group-user` (`group_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `group_question.user_pk`
    FOREIGN KEY (`user_pk`)
    REFERENCES `s08p11d109`.`group-user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`group_answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`group_answer` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`group_answer` (
  `group_answer_pk` INT NOT NULL AUTO_INCREMENT,
  `group_answer_contents` VARCHAR(500) NOT NULL,
  `group_answer_date` DATE NOT NULL,
  `group_answer_update` TINYINT NOT NULL DEFAULT 0,
  `group_answer_like` JSON NOT NULL,
  `group_question_pk` INT NOT NULL,
  `user_pk` INT NOT NULL,
  PRIMARY KEY (`group_answer_pk`),
  UNIQUE INDEX `group_answer_pk_UNIQUE` (`group_answer_pk` ASC),
  INDEX `group_question.group_question_pk_idx` (`group_question_pk` ASC),
  INDEX `group-user.user_pk_idx` (`user_pk` ASC),
  CONSTRAINT `group_answer.group_question_pk`
    FOREIGN KEY (`group_question_pk`)
    REFERENCES `s08p11d109`.`group_question` (`group_question_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `group_answer.user_pk`
    FOREIGN KEY (`user_pk`)
    REFERENCES `s08p11d109`.`group-user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`conference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`conference` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`conference` (
  `conference_pk` INT NOT NULL AUTO_INCREMENT,
  `call_start_time` DATETIME NOT NULL,
  `call_end_time` DATETIME NULL,
  `conference_title` VARCHAR(100) NOT NULL,
  `conference_contents` VARCHAR(500) NOT NULL,
  `conference_active` TINYINT NOT NULL DEFAULT 1,
  `conference_url` VARCHAR(512) NOT NULL,
  `group_pk` INT NOT NULL,
  `user_pk` INT NOT NULL,
  PRIMARY KEY (`conference_pk`),
  UNIQUE INDEX `conference_pk_UNIQUE` (`conference_pk` ASC),
  UNIQUE INDEX `conference_url_UNIQUE` (`conference_url` ASC),
  INDEX `group-user.group_pk_idx` (`group_pk` ASC),
  INDEX `conference.user_pk_idx` (`user_pk` ASC),
  CONSTRAINT `conference.group_pk`
    FOREIGN KEY (`group_pk`)
    REFERENCES `s08p11d109`.`group-user` (`group_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `conference.user_pk`
    FOREIGN KEY (`user_pk`)
    REFERENCES `s08p11d109`.`group-user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`conference-user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`conference-user` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`conference-user` (
  `conference-user_pk` INT NOT NULL AUTO_INCREMENT,
  `conference_pk` INT NOT NULL,
  `user_pk` INT NOT NULL,
  PRIMARY KEY (`conference-user_pk`),
  UNIQUE INDEX `conference-user_pk_UNIQUE` (`conference-user_pk` ASC),
  INDEX `conference-user.user_pk_idx` (`user_pk` ASC),
  INDEX `conference-user.conference_pk_idx` (`conference_pk` ASC),
  CONSTRAINT `conference-user.user_pk`
    FOREIGN KEY (`user_pk`)
    REFERENCES `s08p11d109`.`user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `conference-user.conference_pk`
    FOREIGN KEY (`conference_pk`)
    REFERENCES `s08p11d109`.`conference` (`conference_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`conference_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`conference_history` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`conference_history` (
  `conference_history_pk` INT NOT NULL AUTO_INCREMENT,
  `action` INT NOT NULL,
  `inserted_time` DATETIME NOT NULL,
  `conference_pk` INT NULL,
  `user_pk` INT NULL,
  PRIMARY KEY (`conference_history_pk`),
  UNIQUE INDEX `conference_history_UNIQUE` (`conference_history_pk` ASC),
  INDEX `conference_history.conference_pk_idx` (`conference_pk` ASC),
  INDEX `conference_history.user_pk_idx` (`user_pk` ASC),
  CONSTRAINT `conference_history.conference_pk`
    FOREIGN KEY (`conference_pk`)
    REFERENCES `s08p11d109`.`conference-user` (`conference_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `conference_history.user_pk`
    FOREIGN KEY (`user_pk`)
    REFERENCES `s08p11d109`.`conference-user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`conference_question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`conference_question` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`conference_question` (
  `conference_question_pk` INT NOT NULL AUTO_INCREMENT,
  `conference_question_contents` VARCHAR(500) NOT NULL,
  `conference_question_like` JSON NOT NULL,
  `conference_question_date` DATETIME NOT NULL,
  `conference_question_update` TINYINT NOT NULL DEFAULT 0,
  `conference_pk` INT NOT NULL,
  `group_pk` INT NOT NULL,
  `user_pk` INT NOT NULL,
  PRIMARY KEY (`conference_question_pk`),
  UNIQUE INDEX `conference_question_pk_UNIQUE` (`conference_question_pk` ASC),
  INDEX `conference_question.conference_pk_idx` (`conference_pk` ASC),
  INDEX `conference_question.group_pk_idx` (`group_pk` ASC),
  INDEX `conference_question.user_pk_idx` (`user_pk` ASC),
  CONSTRAINT `conference_question.conference_pk`
    FOREIGN KEY (`conference_pk`)
    REFERENCES `s08p11d109`.`conference` (`conference_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `conference_question.group_pk`
    FOREIGN KEY (`group_pk`)
    REFERENCES `s08p11d109`.`group` (`group_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `conference_question.user_pk`
    FOREIGN KEY (`user_pk`)
    REFERENCES `s08p11d109`.`user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`conference_answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`conference_answer` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`conference_answer` (
  `conference_answer_pk` INT NOT NULL,
  `conference_answer_contents` VARCHAR(500) NOT NULL,
  `conference_answer_date` DATETIME NOT NULL,
  `conference_answer_update` TINYINT NOT NULL DEFAULT 0,
  `conference_answer_like` JSON NOT NULL,
  `conference_question_pk` INT NOT NULL,
  `user_pk` INT NOT NULL,
  PRIMARY KEY (`conference_answer_pk`),
  INDEX `conference_answer.conference_question_pk_idx` (`conference_question_pk` ASC),
  INDEX `conference_answer.user_pk_idx` (`user_pk` ASC),
  CONSTRAINT `conference_answer.conference_question_pk`
    FOREIGN KEY (`conference_question_pk`)
    REFERENCES `s08p11d109`.`conference_question` (`conference_question_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `conference_answer.user_pk`
    FOREIGN KEY (`user_pk`)
    REFERENCES `s08p11d109`.`user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`dm_header`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`dm_header` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`dm_header` (
  `dm_header_pk` INT NOT NULL AUTO_INCREMENT,
  `dm_header_subject` VARCHAR(100) NOT NULL,
  `dm_header_time` TIMESTAMP NULL,
  `from_id` INT NOT NULL,
  `status` INT NOT NULL,
  `to_id` INT NOT NULL,
  PRIMARY KEY (`dm_header_pk`),
  UNIQUE INDEX `from_id_UNIQUE` (`from_id` ASC),
  UNIQUE INDEX `to_id_UNIQUE` (`to_id` ASC),
  INDEX `dm_header.status_idx` (`status` ASC),
  CONSTRAINT `dm_header.from_id`
    FOREIGN KEY (`from_id`)
    REFERENCES `s08p11d109`.`user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `dm_header.to_id`
    FOREIGN KEY (`to_id`)
    REFERENCES `s08p11d109`.`user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `dm_header.status`
    FOREIGN KEY (`status`)
    REFERENCES `s08p11d109`.`user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`dm_message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`dm_message` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`dm_message` (
  `dm_message_pk` INT NOT NULL,
  `is_from_sender` TINYINT NOT NULL,
  `dm_message_contents` VARCHAR(100) NOT NULL,
  `dm_message_read` TINYINT NOT NULL,
  `dm_message_time` TIMESTAMP NULL,
  `dm_header_pk` INT NOT NULL,
  PRIMARY KEY (`dm_message_pk`),
  INDEX `dm_message.dm_header_pk_idx` (`dm_header_pk` ASC),
  CONSTRAINT `dm_message.dm_header_pk`
    FOREIGN KEY (`dm_header_pk`)
    REFERENCES `s08p11d109`.`dm_header` (`dm_header_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s08p11d109`.`alarm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s08p11d109`.`alarm` ;

CREATE TABLE IF NOT EXISTS `s08p11d109`.`alarm` (
  `alarm_pk` INT NOT NULL AUTO_INCREMENT,
  `alarm_contents` VARCHAR(100) NOT NULL,
  `alarm_time` TIMESTAMP NOT NULL,
  `alarm_read` TINYINT NOT NULL DEFAULT 0,
  `alarm_url` VARCHAR(512) NOT NULL,
  `alarm_to_id` INT NOT NULL,
  PRIMARY KEY (`alarm_pk`),
  UNIQUE INDEX `alarm_pk_UNIQUE` (`alarm_pk` ASC),
  INDEX `alarm.alarm_to_id_idx` (`alarm_to_id` ASC),
  CONSTRAINT `alarm.alarm_to_id`
    FOREIGN KEY (`alarm_to_id`)
    REFERENCES `s08p11d109`.`user` (`user_pk`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
