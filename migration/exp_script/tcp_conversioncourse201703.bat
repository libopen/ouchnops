rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="   select * from   (select  newid()  sn,a.Nd+a.Xqdm as batchcode,  RIGHT(a.nd,2)+ltrim(a.Xqdm)+right(a.gzh,11)  as TCPCode,c.[kcID],c.SuggestOpenSemester, c.examunit ExamUnit,a.Nd+a.Xqdm+'01' as createTime  from %lv1%..r1703zygzsyndb a   inner join %lv1%..[bxgz201703] c on a.Gzh =c.[gzh] ) a   where a.batchcode='201703' "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

pause