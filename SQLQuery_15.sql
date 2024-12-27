SELECT t.Games,n.region country,COALESCE(SUM(m_gold),0) gold,COALESCE(SUM(m_silver),0) silver,COALESCE(SUM(m_bronze),0) bronze
FROM (SELECT NOC, COUNT(Medal) m_gold ,Games
	FROM  athlete_events 
	WHERE Medal = 'Gold' 
	GROUP BY NOC,Games ) t

FULL OUTER JOIN (SELECT NOC, COUNT(Medal) m_silver ,Games
		FROM  athlete_events 
		WHERE Medal = 'Silver' 
		GROUP BY NOC,Games) s
ON t.NOC = s.NOC AND t.Games = s.Games
FULL OUTER JOIN (SELECT NOC, COUNT(Medal) m_bronze ,Games
		FROM  athlete_events 
		WHERE Medal = 'Bronze' 
		GROUP BY NOC,Games) b
ON t.NOC = b.NOC AND t.Games = b.Games

INNER JOIN noc_regions n
ON t.NOC = n.NOC 
GROUP BY n.region,t.Games

ORDER BY Games,country