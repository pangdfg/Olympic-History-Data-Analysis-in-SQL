SELECT  Name,Team,total_gold_medal
FROM (SELECT  Name,Team,COUNT(Medal) total_gold_medal
FROM (SELECT  Name,Team, Medal 
	FROM athlete_events 
	WHERE Medal = 'Gold') m
GROUP BY Name,Team)n

INNER JOIN (SELECT DISTINCT TOP (5) COUNT(Medal) total_five
	FROM (SELECT  Name,Team, Medal
		FROM athlete_events 
		WHERE Medal = 'Gold') e
		GROUP BY Name,Team
		ORDER BY total_five desc) tf

ON n.total_gold_medal = tf.total_five
ORDER BY total_gold_medal desc