WITH best_teams AS (
	SELECT
    ROW_NUMBER() OVER (ORDER BY SUM(kills) DESC) AS ranking,
    t.team_name,
    SUM(mp.kills) AS kills,
    SUM(mp.deaths) AS deaths,
    SUM(mp.assists) AS assists,
    SUM(mp.headshots) AS headshots,
    (SUM(mp.kills) / SUM(mp.deaths)) AS kdr,
    CONCAT(FORMAT((SUM(mp.headshots) / SUM(mp.kills)) * 100, 1), '%') AS hsr
    FROM teams t
    LEFT JOIN maps_played mp ON t.id_team = mp.id_team
    GROUP BY t.team_name
)
SELECT *
FROM best_teams;