rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd %6segment
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5
set lv6=%6

 set va1="select distinct 1,rtrim(xxmmc),case when xxdm='all' then '330' else rtrim(xxdm) end as  seg,null,null,100,100-isnull(xkcjzzfbl,0),xkcjzzfbl,0,0 as xkjg, 0  as jmjg,null,null,'imp',null as date,'end' from %lv1%..xkxmb a where a.Ksdm='201701' "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%
pause

