rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="select  1 as sn,a.Ksdm,a.Ksdm,a.kslbdm ,'12' as assessmode,a.Kddm ,a.Sjdm  Sjdm ,a.Kcid,LEFT(a.xxdm,3) as segmentcode,left(a.xxdm,5) as colcode,a.Xxdm ,null Bdm ,a.Xh,a.Ksdwlxdm ,'imp' as applicant,a.Pzh as feecertificate,CONVERT(varchar(30),cast(isnull(a.sscsj,'1900-01-01') as datetime),20) ,case when a.Pzh is not null then 1 else 0 end as isconfirm,replace(REPLACE(c.kcmc,' ',''),',',';') as coursename from %lv1%..xsbkb a  left join %lv1%..kczb c on a.kcid=c.kcid "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

