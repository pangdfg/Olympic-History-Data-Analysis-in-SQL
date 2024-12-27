SELECT Team,Sport,Games,COUNT(Medal) total_medals
FROM athlete_events
WHERE Sport = 'Hockey' AND Medal <> 'NA' AND Team = 'India'
GROUP BY Games,Team,Sport
ORDER BY total_medals desc