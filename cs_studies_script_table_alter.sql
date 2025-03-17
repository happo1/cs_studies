ALTER TABLE matches ADD CONSTRAINT check_teams_different CHECK (id_team1 <> id_team2);

ALTER TABLE maps_played
ADD CONSTRAINT chk_headshots_kills CHECK (headshots <= kills);


SET SQL_SAFE_UPDATES = 0;


CREATE INDEX idx_maps_played_match_map ON maps_played (id_match, id_map);


SELECT * 
FROM stats;