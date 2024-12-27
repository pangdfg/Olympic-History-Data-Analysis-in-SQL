SELECT Games games,COUNT(Sport) no_of_sports
FROM (SELECT DISTINCT Games,Sport
	FROM athlete_events) a
GROUP BY Games
ORDER BY no_of_sports desc