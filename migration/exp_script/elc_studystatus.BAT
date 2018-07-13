rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="select a.xxdm, 1, a.Xh,a.Kcid,case when a.Zgcjid is null then 1 else case  when b.fs>59 then 4 else 2 end end ,a.Bkcs ,b.fs ,a.Zgcjid,a.Ksdwlxdm,'end'  from %lv1%..xkbkcsb a  inner join %lv1%..cjdmb  b on isnull(a.Zgcjid,0) =b.Cjdm  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

