
-- if no any country join every olympics games.
SELECT nr.region country, ae.count_game
FROM (SELECT COUNT(DISTINCT Games) count_game, NOC
                FROM athlete_events
                GROUP BY NOC) ae

INNER JOIN noc_regions nr ON ae.NOC = nr.NOC
WHERE count_game = (SELECT DISTINCT COUNT(Games)
       FROM (SELECT DISTINCT Games
			FROM athlete_events) c1 )
ORDER BY nr.region