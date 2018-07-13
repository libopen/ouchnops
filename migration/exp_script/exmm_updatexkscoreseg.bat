rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd %6segment
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5
set lv6=%6

 set va1="update a set Jxb='999' from %lv1%..xkxmcjb a where exists(select * from (select  ksdm,kslbdm,xh,kcid,sjh,MAX(cj) cj ,MAX(isnull(czrq,'1900-1-1')) czrq from %lv1%..xkxmcjb  group by ksdm,kslbdm,xh,kcid,sjh ) b where a.Ksdm=b.Ksdm and a.Kslbdm=b.Kslbdm and a.Xh=b.Xh and a.Kcid=b.Kcid and a.Sjh=b.Sjh and a.Cj=b.cj and isnull(a.Czrq,'1900-1-1')=b.czrq) select 1"
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

