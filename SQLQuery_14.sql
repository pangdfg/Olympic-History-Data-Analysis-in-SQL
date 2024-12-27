SELECT n.region country,COALESCE(SUM(m_gold),0) gold,COALESCE(SUM(m_silver),0) silver,COALESCE(SUM(m_bronze),0) bronze
FROM (SELECT NOC, COUNT(Medal) m_gold
	FROM  athlete_events 
	WHERE Medal = 'Gold' 
	GROUP BY NOC ) t
FULL OUTER JOIN (SELECT NOC, COUNT(Medal) m_silver
		FROM  athlete_events 
		WHERE Medal = 'Silver' 
		GROUP BY NOC) s
ON t.NOC = s.NOC
FULL OUTER JOIN (SELECT NOC, COUNT(Medal) m_bronze
		FROM  athlete_events 
		WHERE Medal = 'Bronze' 
		GROUP BY NOC) b
ON t.NOC = b.NOC

INNER JOIN noc_regions n
ON t.NOC = n.NOC
GROUP BY n.region

ORDER BY gold desc,silver desc,bronze desc