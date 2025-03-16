USE cs_studies;

-- Visualizações Avançadas~

SELECT 
	m.match_date,
    m2.map_name,
    t.tournament_name AS Tournament,
    t1.team_name AS team1,
    t2.team_name AS team2,
    t3.team_name AS winner_team
FROM matches m
JOIN maps_results mr ON m.id_match = mr.id_match
JOIN maps m2 ON mr.id_map = m2.id_map
JOIN teams t1 ON m.id_team1 = t1.id_team
JOIN teams t2 ON m.id_team2 = t2.id_team
JOIN teams t3 ON mr.id_winner = t3.id_team
JOIN tournaments t ON m.id_tournament = t.id_tournament
ORDER BY m.match_date;

SELECT 
    m.id_match,
    t.tournament_name AS Tournament,
    t1.team_name AS team1,
    t2.team_name AS team2,
    t3.team_name AS winner_team,
    GROUP_CONCAT(DISTINCT m2.map_name ORDER BY m2.map_name SEPARATOR ', ') AS maps_played
FROM matches m
JOIN maps_results mr ON m.id_match = mr.id_match
JOIN maps m2 ON mr.id_map = m2.id_map
JOIN teams t1 ON m.id_team1 = t1.id_team
JOIN teams t2 ON m.id_team2 = t2.id_team
JOIN teams t3 ON mr.id_winner = t3.id_team
JOIN tournaments t ON m.id_tournament = t.id_tournament
GROUP BY m.id_match, t.tournament_name, t1.team_name, t2.team_name, t3.team_name
ORDER BY m.id_match;





-- Todos jogadores por times:

SELECT t.team_name, p.player_name AS name
FROM players p
JOIN teams t ON p.id_team = t.id_team;

-- Status de jogadores por time específico:

-- Consulte os IDs de times:
SELECT id_team, team_name
FROM teams;

SET @id_team = 3;

SELECT t.team_name, p.player_name
FROM players p
JOIN teams t ON t.id_team = p.id_team
WHERE t.id_team = @id_team;

--

/* Escolha o ID do time que deseja verificar os status de jogadores: */  
SET @id_team = 3;

SELECT t.team_name, m2.map_name, p.player_name, m.id_match, mp.kills, mp.deaths, mp.assists, mp.headshots, mp.adr,
 CONCAT(FORMAT((mp.headshots / mp.kills) * 100, 2), '%') AS headshot_percentage,
 (mp.kills / mp.deaths) AS KD_rating 
FROM teams t
JOIN players p ON t.id_team = p.id_team
JOIN  maps_played mp ON mp.id_player = p.id_player
JOIN matches m ON m.id_match = mp.id_match
JOIN maps m2 ON mp.id_map = m2.id_map
WHERE t.id_team = @id_team
ORDER BY map_name, KD_rating DESC;

SELECT m.map_name,
		SUM(mp.kills) AS kills,
		SUM(mp.deaths) AS deaths,
        SUM(mp.assists) AS assists,
        SUM(mp.headshots) AS headshots,
        (SUM(mp.kills) / SUM(mp.deaths)) AS kdr,
        CONCAT(FORMAT((mp.headshots / mp.kills) * 100, 2), '%') AS hsr
FROM maps m
JOIN maps_played mp ON m.id_map = mp.id_map
GROUP BY m.map_name;







