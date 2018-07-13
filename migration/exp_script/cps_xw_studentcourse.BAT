rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select rtrim(xh),rtrim(xxdm) ,rtrim(kcid) ,case when isnumeric(zgcj)=0 then null else rtrim([zgcj]) end,rtrim(zgcjid),rtrim(ksdwlxdm) ,'end' from %lv1%..xwstucourse  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%
pause

