rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="select c.Xxdm , 1 sn, a.Xh ,ltrim(c.Xxdm) +RTRIM(c.Xh) as studentid,sqr,a.sqsj ,convert(varchar(10),cast(a.sqsj+'01' as date),120),case when b.wkcjkm='62' then '70' when b.wkcjkm='63' then '71' when b.wkcjkm='64' then '72' else rtrim(b.wkcjkm) end ,a.Mkyy,a.Sxspr ,convert(varchar(10),cast(a.sxshsj+'01' as date),120),a.Sxshzt ,Zyspr ,convert(varchar(10),cast(a.zyshsj+'01' as date),120),a.zyshzt,case a.zyshzt when '1' then '7' when '0' then '8' else '6' end ,case a.zyshzt when '1' then 1 when '0' then 1 else 0 end ,a.xm  from %lv1%..wkmkb a inner join %lv1%..wkcjmwkkmdzb b on a.mkkm=b.mWkkm  inner join %lv1%..xsb c on a.xh=c.xh "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

