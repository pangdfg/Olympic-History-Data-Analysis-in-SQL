SELECT TOP(1) Sport,COUNT(Medal) total_medals
FROM athlete_events
WHERE  Medal <> 'NA' AND Team = 'India'
GROUP BY Sport
ORDER BY total_medals desc