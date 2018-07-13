rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select 1, b.sj2+a.Sjdm  as sjdm  ,a.Ksdwlxdm ,'010' as Segmentcode ,null as departmentcode ,'12' as AssessMode,null as ExamMode,a.Sfydtk ,a.Sfsytq ,a.Sfsycd ,a.Sfyzgt ,a.Kcdybz  ,case when isnumeric(a.kssjcd)=1 then a.Kssjcd else 0 end ,'imp',null as sdate,'0'  ,replace(a.Sjhmc,char(10)+char(13),'')   from %lv1%..kskmb a   inner join (  select sjdm ,case when cast(LEFT(sjdm,2) as int)=27 or cast(LEFT(sjdm,2) as int)=49 then '4' else case when cast(LEFT(sjdm,2) as int)<20 then '1' else case when cast(LEFT(sjdm,2) as int)>49 then '5' else '2' end end end as sj2  from %lv1%..kskmb) b on a.Sjdm =b.Sjdm    "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

