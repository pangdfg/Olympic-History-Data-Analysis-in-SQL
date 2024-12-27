
select country,MAX(gold) gold,MAX(silver) silver,MAX(bronze) bronze
from(select region country,case when Medal LIKE 'Gold' then sum_m else 0 end gold,case when Medal LIKE 'Silver' then sum_m else 0 end silver,case when Medal LIKE 'Bronze' then sum_m else 0 end bronze
from(select region,Medal,SUM(count_m) sum_m
from(select region,Medal,count_m
	from(select [NOC],[Medal],count([Medal]) count_m
	  FROM [athlete_events] 
	  where [Medal]<>'NA' 
	  group by [NOC],[Medal] 
	) a
	INNER JOIN [noc_regions] n ON a.NOC = n.NOC) d
group by region,Medal ) b
) f

group by country
HAVING MAX(gold) < 1
order by silver desc,bronze desc