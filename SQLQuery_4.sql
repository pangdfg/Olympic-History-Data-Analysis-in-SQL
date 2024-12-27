SELECT low_countries,highest_countries
FROM (SELECT TOP (1) Games + ' - ' +CAST(cnoc AS varchar) low_countries
FROM (SELECT  COUNT(NOC) cnoc,Games
	FROM (SELECT DISTINCT NOC,Games
		FROM athlete_events) a
	GROUP BY Games) b
	ORDER BY cnoc ) table1

FULL OUTER JOIN (SELECT highest_countries
FROM (SELECT TOP (1) Games + ' - ' +CAST(cnoc AS varchar) highest_countries
FROM (SELECT  COUNT(NOC) cnoc,Games
	FROM (SELECT DISTINCT NOC,Games
		FROM athlete_events) e
	GROUP BY Games) f
	ORDER BY cnoc desc) g) table2
ON table1.low_countries <> table2.highest_countries