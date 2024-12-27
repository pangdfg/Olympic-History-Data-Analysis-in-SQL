SELECT Sport,no_of_games,e.total
FROM (SELECT Sport,COUNT(Season) no_of_games
	FROM (SELECT DISTINCT Games,Sport,Season
		FROM athlete_events) a
		WHERE Season = 'Summer' 
		GROUP BY Sport ) b

INNER JOIN (SELECT MAX(no_of_games) total
		FROM (SELECT COUNT(Season) no_of_games
		FROM (SELECT DISTINCT Games,Sport,Season
			FROM athlete_events) c
			WHERE Season = 'Summer' 
			GROUP BY Sport ) d) e 

ON b.no_of_games = e.total
ORDER BY b.no_of_games desc
