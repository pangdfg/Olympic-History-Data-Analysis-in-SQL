
SELECT COUNT(Games) total_olympics_games
FROM (SELECT DISTINCT Games
	FROM athlete_events) a
