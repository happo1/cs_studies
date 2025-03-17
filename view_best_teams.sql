CREATE VIEW `best_teams` AS
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