SELECT  '1: ' + CAST((SUM(case when Sex = 'M' then 1 else 0 end) + 0.0) / (SUM(case when Sex = 'F' then 1 else 0 end) + 0.0) AS varchar) ratio
FROM athlete_events