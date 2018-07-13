rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select a.Mkyy ,case when c.Wkkm='62' then '70' when c.wkkm='63' then '71' else rtrim(c.Wkkm) end  ,ltrim(a.Mkyymc) ,0 from %lv1%..mwkyydmb a inner join %lv1%..wkcjmwkkmdzb b on a.Mkkm =b.mwkkm inner join %lv1%..wkkmb c on b.wkcjkm =c.Wkkm  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

