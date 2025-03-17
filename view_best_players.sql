CREATE VIEW `best_players` AS
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