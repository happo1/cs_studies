WITH relation AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY SUM(mp.kills) DESC) AS ranking,
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
SELECT * FROM relation;

