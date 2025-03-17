-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cs_studies
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cs_studies
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cs_studies` DEFAULT CHARACTER SET utf8mb3 ;
USE `cs_studies` ;

-- -----------------------------------------------------
-- Table `cs_studies`.`maps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`maps` (
  `id_map` INT NOT NULL AUTO_INCREMENT,
  `map_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_map`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cs_studies`.`teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`teams` (
  `id_team` INT NOT NULL AUTO_INCREMENT,
  `team_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_team`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cs_studies`.`tournaments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`tournaments` (
  `id_tournament` INT NOT NULL AUTO_INCREMENT,
  `tournament_name` VARCHAR(50) NOT NULL,
  `tournament_category` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_tournament`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cs_studies`.`matches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`matches` (
  `id_match` INT NOT NULL AUTO_INCREMENT,
  `match_date` DATE NOT NULL,
  `id_tournament` INT NOT NULL,
  `id_team1` INT NOT NULL,
  `id_team2` INT NOT NULL,
  `team1_maps_won` INT NOT NULL,
  `team2_maps_won` INT NOT NULL,
  PRIMARY KEY (`id_match`),
  INDEX `fk.matches_team1_idx` (`id_team1` ASC) VISIBLE,
  INDEX `fk.matches_team2_idx` (`id_team2` ASC) VISIBLE,
  INDEX `fk.matches_tournaments_idx` (`id_tournament` ASC) VISIBLE,
  CONSTRAINT `fk.matches_team1`
    FOREIGN KEY (`id_team1`)
    REFERENCES `cs_studies`.`teams` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk.matches_team2`
    FOREIGN KEY (`id_team2`)
    REFERENCES `cs_studies`.`teams` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk.matches_tournaments`
    FOREIGN KEY (`id_tournament`)
    REFERENCES `cs_studies`.`tournaments` (`id_tournament`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cs_studies`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`players` (
  `id_player` INT NOT NULL AUTO_INCREMENT,
  `id_team` INT NOT NULL,
  `player_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_player`),
  INDEX `fk_players_teams` (`id_team` ASC) VISIBLE,
  CONSTRAINT `fk_players_teams`
    FOREIGN KEY (`id_team`)
    REFERENCES `cs_studies`.`teams` (`id_team`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cs_studies`.`maps_played`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`maps_played` (
  `id_map_played` INT NOT NULL AUTO_INCREMENT,
  `id_match` INT NOT NULL,
  `id_map` INT NOT NULL,
  `id_player` INT NOT NULL,
  `id_team` INT NOT NULL,
  `kills` INT NOT NULL,
  `deaths` INT NOT NULL,
  `assists` INT NOT NULL,
  `headshots` INT NOT NULL,
  `adr` DECIMAL(4,1) NOT NULL,
  PRIMARY KEY (`id_map_played`),
  INDEX `fk.maps_played_matches_idx` (`id_match` ASC) VISIBLE,
  INDEX `fk.maps_played_maps_idx` (`id_map` ASC) VISIBLE,
  INDEX `fk.maps_played_players1_idx` (`id_player` ASC) VISIBLE,
  INDEX `fk.maps_played_teams_idx` (`id_team` ASC) VISIBLE,
  CONSTRAINT `fk.maps_played_maps1`
    FOREIGN KEY (`id_map`)
    REFERENCES `cs_studies`.`maps` (`id_map`),
  CONSTRAINT `fk.maps_played_matches1`
    FOREIGN KEY (`id_match`)
    REFERENCES `cs_studies`.`matches` (`id_match`),
  CONSTRAINT `fk.maps_played_players1`
    FOREIGN KEY (`id_player`)
    REFERENCES `cs_studies`.`players` (`id_player`),
  CONSTRAINT `fk.maps_played_teams`
    FOREIGN KEY (`id_team`)
    REFERENCES `cs_studies`.`teams` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cs_studies`.`maps_results`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`maps_results` (
  `id_maps_results` INT NOT NULL AUTO_INCREMENT,
  `id_match` INT NOT NULL,
  `id_team1` INT NOT NULL,
  `id_team2` INT NOT NULL,
  `rounds_team1` INT NOT NULL,
  `rounds_team2` INT NOT NULL,
  `id_winner` INT NOT NULL,
  `id_map` INT NOT NULL,
  PRIMARY KEY (`id_maps_results`),
  INDEX `fk.maps_results_matches_idx` (`id_match` ASC) VISIBLE,
  INDEX `fk.maps_results_team1_idx` (`id_team1` ASC) VISIBLE,
  INDEX `fk.maps_results_team2_idx` (`id_team2` ASC) VISIBLE,
  INDEX `fk.maps_results_winner_idx` (`id_winner` ASC) VISIBLE,
  CONSTRAINT `fk.maps_results_matches`
    FOREIGN KEY (`id_match`)
    REFERENCES `cs_studies`.`matches` (`id_match`),
  CONSTRAINT `fk.maps_results_team1`
    FOREIGN KEY (`id_team1`)
    REFERENCES `cs_studies`.`teams` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk.maps_results_team2`
    FOREIGN KEY (`id_team2`)
    REFERENCES `cs_studies`.`teams` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk.maps_results_winner`
    FOREIGN KEY (`id_winner`)
    REFERENCES `cs_studies`.`teams` (`id_team`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;

USE `cs_studies` ;

-- -----------------------------------------------------
-- Placeholder table for view `cs_studies`.`player_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`player_stats` (`team_name` INT, `player_name` INT, `kills` INT, `deaths` INT, `assists` INT, `headshots` INT, `kdr` INT, `hsr` INT);

-- -----------------------------------------------------
-- Placeholder table for view `cs_studies`.`teams_players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`teams_players` (`team_name` INT, `player_name` INT);

-- -----------------------------------------------------
-- Placeholder table for view `cs_studies`.`matches_overlook`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`matches_overlook` (`id_match` INT, `match_date` INT, `tournament_name` INT, `id_team1` INT, `team1_name` INT, `id_team2` INT, `team2_name` INT, `team1_maps_won` INT, `team2_maps_won` INT);

-- -----------------------------------------------------
-- Placeholder table for view `cs_studies`.`best_players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`best_players` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `cs_studies`.`best_teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs_studies`.`best_teams` (`id` INT);

-- -----------------------------------------------------
-- View `cs_studies`.`player_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cs_studies`.`player_stats`;
USE `cs_studies`;
CREATE  OR REPLACE VIEW `player_stats` AS
SELECT t.team_name, p.player_name, SUM(mp.kills) AS kills, SUM(mp.deaths) AS deaths, SUM(mp.assists) AS assists, SUM(mp.headshots) AS headshots,
	   (SUM(mp.kills) / SUM(mp.deaths)) AS kdr,
       CONCAT(FORMAT((SUM(mp.headshots) / SUM(mp.kills)) * 100, 2), '%') AS hsr
FROM maps_played mp
JOIN players p ON mp.id_player = p.id_player
JOIN teams t ON mp.id_team = t.id_team
GROUP BY t.team_name, p.player_name
ORDER BY kdr DESC;

-- -----------------------------------------------------
-- View `cs_studies`.`teams_players`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cs_studies`.`teams_players`;
USE `cs_studies`;
CREATE  OR REPLACE VIEW `teams_players` AS
SELECT t.team_name, p.player_name
FROM teams t
JOIN players p ON t.id_team = p.id_team;

-- -----------------------------------------------------
-- View `cs_studies`.`matches_overlook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cs_studies`.`matches_overlook`;
USE `cs_studies`;
CREATE  OR REPLACE VIEW `matches_overlook` AS
SELECT
		m.id_match,
		m.match_date,
        t.tournament_name,
        tt1.id_team AS id_team1,
        tt1.team_name AS team1_name,
        tt2.id_team AS id_team2,
        tt2.team_name AS team2_name,
        m.team1_maps_won,
        m.team2_maps_won
    FROM matches m
	JOIN tournaments t ON m.id_tournament = t.id_tournament
    JOIN teams tt1 ON m.id_team1 = tt1.id_team
    JOIN teams tt2 ON m.id_team2 = tt2.id_team;

-- -----------------------------------------------------
-- View `cs_studies`.`best_players`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cs_studies`.`best_players`;
USE `cs_studies`;
CREATE  OR REPLACE VIEW `best_players` AS
WITH best_players AS (
    SELECT 
        p.player_name,
        t.team_name,
        SUM(mp.kills) AS kills,
        SUM(mp.deaths) AS deaths,
        SUM(mp.assists) AS assists,
        SUM(mp.headshots) AS headshots,
        AVG(mp.adr) AS avg_adr,
        (SUM(mp.kills) * 1.0 / NULLIF(SUM(mp.deaths), 0)) AS kdr,
        CONCAT(FORMAT((SUM(mp.headshots) / SUM(mp.kills)) * 100, 2), '%') AS hsr
    FROM maps_played mp
    RIGHT JOIN players p ON mp.id_player = p.id_player
    RIGHT JOIN teams t ON mp.id_team = t.id_team
    GROUP BY p.player_name, t.team_name
)
SELECT ROW_NUMBER() OVER (ORDER BY kdr DESC) AS ranking, player_name, kills, deaths, assists, headshots, avg_adr, kdr, hsr 
FROM best_players;

-- -----------------------------------------------------
-- View `cs_studies`.`best_teams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cs_studies`.`best_teams`;
USE `cs_studies`;
CREATE  OR REPLACE VIEW `best_teams` AS
WITH best_teams AS (
	SELECT
    t.team_name,
    SUM(mp.kills) AS kills,
    SUM(mp.deaths) AS deaths,
    SUM(mp.assists) AS assists,
    SUM(mp.headshots) AS headshots,
    (SUM(mp.kills) / SUM(mp.deaths)) AS kdr,
    CONCAT(FORMAT((SUM(mp.headshots) / SUM(mp.kills)) * 100, 1), '%') AS hsr,
    	(SUM(CASE
			WHEN t.id_team = mo.id_team1 THEN mo.team1_maps_won
			WHEN t.id_team = mo.id_team2 THEN mo.team2_maps_won
		END) /
		NULLIF(SUM(CASE
			WHEN t.id_team = mo.id_team1 THEN mo.team2_maps_won
			WHEN t.id_team = mo.id_team2 THEN mo.team1_maps_won
		END), 0)) AS map_wr_rating
    FROM teams t
    LEFT JOIN maps_played mp ON t.id_team = mp.id_team
    JOIN matches_overlook mo ON t.id_team = mo.id_team1 OR t.id_team = mo.id_team2
    GROUP BY t.team_name
)
SELECT 
	ROW_NUMBER() OVER (ORDER BY map_wr_rating DESC) AS ranking,
	team_name, kills, deaths, assists, headshots, kdr, map_wr_rating
FROM best_teams;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
