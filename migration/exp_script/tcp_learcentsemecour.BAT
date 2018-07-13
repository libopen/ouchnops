rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select 1, a.Nd+a.Xqdm,LEFT(a.Xxdm ,3) ,a.Xxdm ,a.Kcid ,null,1,null  from %lv1%..jxdxqkskcb a order by a.Nd,a.Xqdm ,a.Kcid "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

