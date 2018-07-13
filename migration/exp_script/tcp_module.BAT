rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select         newid() sn,     a.batchcode, a.tcpcode ,b.Mkh,b.Mkxf,b.Mkzyxf     from (select distinct a.nd,a.xqdm, RIGHT(a.nd,2)+ltrim(a.Xqdm)+ltrim(right(a.gzh,11)) as tcpcode ,a.Gzh ,a.nd+ltrim(a.Xqdm) batchcode,right(LEFT(a.gzh,6),2) as xslxdm,RIGHT(left(a.gzh,7),1) zyccdm,RIGHT(a.gzh,8) as zydm from %lv1%..zygzsyndb a  ) a inner join %lv1%..zymkb b on a.gzh=b.gzh  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

