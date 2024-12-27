SELECT *
FROM (SELECT Name,Sex,case when Age = 'NA' then 0 else Age end age ,Team,Games,City,Sport,Event,Medal
	FROM athlete_events) a
WHERE Medal = 'Gold' AND age = (SELECT MAX(age) FROM (SELECT case when Age = 'NA' then 0 else Age end age FROM athlete_events WHERE Medal = 'Gold' ) b)
