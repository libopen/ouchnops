rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select distinct a.Nd +b.xqdm,a.Nd +b.xqdm ,'imp','imp','2000-1-1' from %lv1%..ndb a cross join %lv1%..xqdmb b "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

