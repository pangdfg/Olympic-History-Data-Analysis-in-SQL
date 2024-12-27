select ma.Games , max_gold,max_silver,max_bronze,max_medals

from(select Games,MAX(case when Medal Like 'Gold' then region + '-' + CAST(max_m AS varchar) end) max_gold,MAX(case when Medal Like 'Silver' then region + '-' + CAST(max_m AS varchar) end) max_silver,MAX(case when Medal Like 'Bronze' then region + '-' + CAST(max_m AS varchar) end ) max_bronze

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
) max_gsb

INNER JOIN (select f.Games,region+ ' - ' + CAST(max_all AS varchar) max_medals
from(select c.Games,MAX(max_m) max_all
from (select Games,NOC,SUM(count_m) max_m
from(select Games,a.NOC,count_m
	from(select [NOC],[Games],count([Medal]) count_m
	  FROM [athlete_events] 
	  where [Medal]<>'NA' 
	  group by [NOC],[Games]
	) a
	INNER JOIN [noc_regions] n ON a.NOC = n.NOC
) b
group by  Games,NOC
) c
group by Games
) f

INNER JOIN (select region,Games,sum_m
from (select [NOC],[Games],SUM(count_m) sum_m
from(select [NOC],[Games],count([Medal]) count_m
  FROM [athlete_events] 
  where [Medal]<>'NA' 
  group by [NOC],[Games]
) a
group by  Games,NOC)s
INNER JOIN [noc_regions] n ON s.NOC = n.NOC) r

ON r.Games = f.Games AND r.sum_m = f.max_all
) ma ON max_gsb.Games = ma.Games

order by max_gsb.Games