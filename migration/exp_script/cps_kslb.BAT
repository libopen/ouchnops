rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select  rtrim(a.Kslbdm),a.kslbmc ,a.Zyccdm ,a.Xslxdm  ,a.Xslbdm ,'010' Seg    from %lv1%..xslbkslbdyb a "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

