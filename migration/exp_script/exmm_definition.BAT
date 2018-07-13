rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select 1,a.Ksdm,a.ksdm ,a.Ksmc ,a.Ksnd,a.Ksxmdm ,1,1,1,null,'010',null,'imp','imp',null,1 from %lv1%..ksdyb a  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

