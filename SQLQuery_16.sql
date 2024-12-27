select Games,MAX(case when Medal Like 'Gold' then region + '-' + CAST(max_m AS varchar) end) max_gold,MAX(case when Medal Like 'Silver' then region + '-' + CAST(max_m AS varchar) end) max_silver,MAX(case when Medal Like 'Bronze' then region + '-' + CAST(max_m AS varchar) end ) max_bronze

from(select c.Games,c.Medal,max_m,region
from (select Games,Medal,MAX(count_m) max_m
from(select Games,Medal,count_m
	from(select [NOC],[Games],[Medal],count([Medal]) count_m
	  FROM [athlete_events] 
	  where [Medal]<>'NA' 
	  group by [NOC],[Games],[Medal] 
	) a
	INNER JOIN [noc_regions] n ON a.NOC = n.NOC
) b
group by  Games,Medal
) c
INNER JOIN (select region,Games,Medal,count_m
from(select [NOC],[Games],[Medal],count([Medal]) count_m
  FROM [athlete_events] 
  where [Medal]<>'NA' 
  group by [NOC],[Games],[Medal] 
) a
INNER JOIN [noc_regions] n ON a.NOC = n.NOC ) r
ON r.Games = c.Games AND r.count_m = c.max_m
) f

group by Games
order by Games
