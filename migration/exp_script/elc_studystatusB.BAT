rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="select   1, a.Xh,a.Kcid,case when b.fs>59 then 4 else 2 end ,a.Bkcs ,b.fs ,a.Zgcjid,a.Ksdwlxdm  from %lv1%..xkbkcsb a  inner join %lv1%..cjdmb  b on a.Zgcjid =b.Cjdm  where cast(left(a.xxdm,1) as int)>3 "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

