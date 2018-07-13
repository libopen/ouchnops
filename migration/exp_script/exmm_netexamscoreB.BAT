rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select  1 as sn,ltrim(b.xxdm),b.Kssj, case when a.Wkkm='62' then '70' when a.wkkm='63' then '71' when a.wkkm='64' then '72' else rtrim(a.Wkkm) end as wkkm  ,a.Xh ,b.Cjdm ,b.Sfcrzcjb ,'imp','2000-1-1'  ,left(c.Xxdm ,5),c.Xxdm  ,rtrim(c.Bdm),1,replace(c.Xm,',','.')   from   (  select a.Kssj ,a.Wkkm ,a.Xh ,MAX(cast(left(a.sxh,8) as int )) as mxxsh   from %lv1%..wkcjb a inner join %lv1%..cjdmb b on a.Cjdm =b.Cjdm   group by a.Kssj ,a.Wkkm ,a.Xh ) a inner join  %lv1%..wkcjb b on a.Kssj =b.Kssj and a.Wkkm =b.Wkkm and a.Xh =b.Xh and a.mxxsh =CAST(left(b.sxh,8) as int) inner join %lv1% ..xsb c on a.Xh =c.Xh  where cast (left(b.Xxdm,1)  as int)>3  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

