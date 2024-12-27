
SELECT region,total_medals,RANK() OVER(ORDER BY total_medals DESC) AS rank
FROM (SELECT n.region,SUM(total) total_medals
FROM (SELECT NOC, COUNT(Medal) total
	FROM  athlete_events 
	WHERE Medal = 'Gold' OR Medal = 'Silver' OR Medal = 'Bronze'
	GROUP BY NOC) t
INNER JOIN noc_regions n
ON t.NOC = n.NOC
GROUP BY n.region) e
ORDER BY total_medals desc