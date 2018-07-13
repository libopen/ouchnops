rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select  newid()  sn,a.Nd+a.Xqdm as batchcode, RIGHT(a.nd,2)+ltrim(a.Xqdm)+ltrim(right(a.gzh,11))  as TCPCode,c.kcid,1 as SuggestOpenSemester,2 as ExamUnit,a.Nd+a.Xqdm+'01' as createTime  from %lv1%..zygzsyndb a inner join %lv1%..zygzb b on a.Gzh =b.Gzh   inner join %lv1%..bxgzkcb c on b.bxGzh =c.Bxgzh  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

