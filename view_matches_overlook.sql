CREATE VIEW `matches_overlook` AS
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
    JOIN teams tt2 ON m.id_team2 = tt2.id_team