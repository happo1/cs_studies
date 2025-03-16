ALTER TABLE matches ADD CONSTRAINT check_teams_different CHECK (id_team1 <> id_team2);

ALTER TABLE maps_played
ADD CONSTRAINT chk_headshots_kills CHECK (headshots <= kills);


SET SQL_SAFE_UPDATES = 0;

UPDATE players SET player_name = 'woxic'
WHERE id_player = 23


