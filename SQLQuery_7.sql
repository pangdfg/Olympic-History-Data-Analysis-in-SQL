SELECT DISTINCT b.Sport,no_of_games,c.Games
FROM (SELECT Sport,COUNT(Games) no_of_games
	FROM (SELECT DISTINCT Sport,Games
		FROM athlete_events) a
		GROUP BY Sport) b
INNER JOIN  athlete_events c
ON b.Sport = c.Sport
WHERE no_of_games = 1
ORDER BY b.Sport