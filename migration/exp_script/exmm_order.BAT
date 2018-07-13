rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select 1 as sn,a.Ksdm ,rtrim(a.Kslb) ,rtrim(a.Sjdm),rtrim(a.Dwdm) as orgcode,rtrim(isnull(a.Fxdm,a.dwdm)) as toporgcode,a.Pkcrs as numofexaminee,'1900-1-1','imp' from %lv1%..zddb a  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

