CREATE VIEW `player_stats` AS
SELECT t.team_name, p.player_name, SUM(mp.kills) AS kills, SUM(mp.deaths) AS deaths, SUM(mp.assists) AS assists, SUM(mp.headshots) AS headshots,
	   (SUM(mp.kills) / SUM(mp.deaths)) AS kdr,
       CONCAT(FORMAT((SUM(mp.headshots) / SUM(mp.kills)) * 100, 2), '%') AS hsr
FROM maps_played mp
JOIN players p ON mp.id_player = p.id_player
JOIN teams t ON mp.id_team = t.id_team
GROUP BY t.team_name, p.player_name
ORDER BY kdr DESC;