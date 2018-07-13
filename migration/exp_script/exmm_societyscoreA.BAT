rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="select 1 ,left(b.Xxdm,3),left(b.Xxdm,5),b.Xxdm ,b.Bdm,a.Kmdm ,a.Xh,b.Xm,a.Cj ,rtrim(a.Cjdm),a.Czy ,isnull(CONVERT(varchar(10),a.czrq,120),'1900-1-1') from %lv1%..shkmcjb a inner join %lv1%..xsb b on a.Xh=b.xh where  cast(left(b.xxdm,1) as int)<4 "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

