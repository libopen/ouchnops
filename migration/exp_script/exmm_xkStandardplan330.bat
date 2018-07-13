rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd %6segment
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5
set lv6=%6

 set va1="select 1,1,case when xxdm='all' then '330' else rtrim(xxdm) end as  seg,null as col,null as lea ,a.ksdm,sjh,rtrim(kslbdm),case when jmcjjgbz='true' then 60 else null end ,case when xkcjjgbz='true' then 60 else null end ,100,100-isnull(xkcjzzfbl,0),xkcjzzfbl,null as qz,case when xkcjjgbz='true' then 1 else 0 end as xkjg,case when jmcjjgbz='true' then 1 else 0 end as jmjg,'imp',null as date,null as sn,'end' from %lv1%..xkxmb a where a.Ksdm='201701' "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%
pause

