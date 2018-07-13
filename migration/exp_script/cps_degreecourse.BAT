set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

set va1= " select 1 as sn,1 as dsn,rtrim(a.Zdnd) +rtrim(a.Zdxq)  as batchcode,RTRIM(a.Zydm ) as zydm,RTRIM(a.hzgxdm) as hzgxdm,a.Kcid ,b.Xf,b.Kcmc ,a.Ksdwlxdm ,a.Zdcj  from %lv1%..xwkcb a left join %lv1%..kczb b on a.Kcid =b.kcid   "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

