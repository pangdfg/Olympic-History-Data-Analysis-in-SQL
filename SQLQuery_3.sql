SELECT  Games,COUNT(NOC) total_countries
FROM (SELECT DISTINCT NOC,Games
	FROM athlete_events) a
GROUP BY Games
ORDER BY Games