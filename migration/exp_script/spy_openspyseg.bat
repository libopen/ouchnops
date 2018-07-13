rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="select distinct 1 as SN,LEFT(a.xxdm,3) as segmentorgcode,a.zydm,a.xslxdm as studenttype,a.zyccdm as professionallevel,'1' as openstate,'2000-1-1' from %lv1%..jxdzyszb a  where a.xslxdm is not null"
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

