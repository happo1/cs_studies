USE cs_studies;

-- Visualizações Avançadas~

SELECT DISTINCT 
	m.id_match,
	t1.team_name AS team1_name,
	t2.team_name AS team2_name,
	m2.map_name,
	t3.team_name AS winner_team,
	t.tournament_name AS Tournament
FROM matches m
JOIN maps_played mp ON m.id_match = mp.id_match
JOIN maps m2 ON mp.id_map = m2.id_map
JOIN maps_results mr ON mr.id_match = m.id_match
JOIN teams t1 ON mr.id_team1 = t1.id_team
JOIN teams t2 ON mr.id_team2 = t2.id_team
JOIN teams t3 ON mr.id_winner = t3.id_team
JOIN tournaments t ON m.id_tournament = t.id_tournament;

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
 (mp.kills / mp.deaths) AS rating 
FROM teams t
JOIN players p ON t.id_team = p.id_team
JOIN  maps_played mp ON mp.id_player = p.id_player
JOIN matches m ON m.id_match = mp.id_match
JOIN maps m2 ON mp.id_map = m2.id_map
WHERE t.id_team = @id_team
ORDER BY map_name;

/* Escolha o ID do time que deseja verificar os status geral de jogadores: */ 

-- Consulte os IDs de times:
SELECT id_team, team_name
FROM teams;

SET @id_team = 5;

SELECT t.team_name, p.player_name, 
    SUM(mp.kills) AS total_kills, 
    SUM(mp.deaths) AS total_deaths, 
    SUM(mp.assists) AS total_assists, 
    SUM(mp.headshots) AS total_headshots,
    AVG(mp.adr) AS avg_adr,
    CONCAT(FORMAT((SUM(mp.headshots) / SUM(mp.kills)) * 100, 2), '%') AS headshot_percentage,
    (SUM(mp.kills) / SUM(mp.deaths)) AS KD_rating
FROM teams t
JOIN players p ON t.id_team = p.id_team
JOIN maps_played mp ON mp.id_player = p.id_player
JOIN matches m ON m.id_match = mp.id_match
WHERE t.id_team = @id_team
GROUP BY t.team_name, p.player_name
ORDER BY KD_rating DESC;

/* Escolha o ID do jogador que deseja verificar status geral:*/ 

-- Consulte os IDs de jogadores:
SELECT id_player, player_name
FROM players;
--
SET @id_player = 11;

SELECT p.player_name,
    t.team_name,
	SUM(mp.kills) AS total_kills,
	SUM(mp.deaths) AS total_deaths,
	SUM(mp.assists) AS total_assists,
	SUM(mp.headshots) AS total_headshots,
    (SUM(mp.kills) / SUM(mp.deaths)) AS KD_rating,
	CONCAT(FORMAT((SUM(mp.headshots) / SUM(mp.kills)) * 100, 2), '%') AS headshot_percentage
FROM players p
JOIN teams t ON t.id_team = p.id_team
JOIN  maps_played mp ON mp.id_player = p.id_player
WHERE p.id_player = @id_player
GROUP BY p.player_name, t.team_name;

SELECT t.tournament_name, tt.team_name
FROM tournaments t
JOIN teams tt ON tt.id_team = p.id_team
JOIN  maps_played mp ON mp.id_player = tt.id_player


