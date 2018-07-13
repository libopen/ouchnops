rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select distinct 1 as sn,a.Ksdm ,a.Kxlb ,rtrim(a.Sjdm) ,rtrim(a.Dwdm),a.Sjggdm ,a.Sjds ,a.Sjzds  from %lv1%..sjddb a   "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

