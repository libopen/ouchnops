rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select RIGHT(a.nd,2)+ltrim(a.Xqdm)+ltrim(a.Xslxdm)+LTRIM(a.zyccdm)+LTRIM(a.zydm) as newtcpcode,a.Nd+a.Xqdm as batchcode,a.Gzh ,a.Xslxdm studenttype  ,a.Zyccdm professionallevel ,a.Zydm spycode   from %lv1%..zygzsyndb a   "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

