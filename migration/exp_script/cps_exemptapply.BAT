rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select 1,a.Kclx as applytype,a.Xh studentcode,a.Xm fullname,a.Bdm classcode,left(a.xxdm,3) as segmentcode,LEFT(a.xxdm,5) as collegecode ,a.Xxdm as learningcentercode,a.zyccdm as spylevel,a.Xslxdm as studenttype,Rtrim(a.Gzh) as tcpcode ,a.Kcid as courseid,a.Xf as credit,a.Yxtzymc as outspecialty,a.Yxtkcccdm as outcourselevel ,replace(a.Yxtkcmc,',',' ') as outcoursename,rtrim(b.Xtykclymc) as outcoursesource,a.Yxtxf as outcredit,a.Yxtbzdw as Certorg ,a.Yxtbznf as CertificateYear,a.Cjdm as scorecode,a.Lrsj as yearterm ,rtrim(a.Gzh) as applytcpcode,a.Xxdm as applyorgcode,4 as applyorgtype ,case when a.Shztbz=2 then 8 else 7  end as curAuditState ,'imp' as cenauditor ,a.Zyshwpzyy as cenauditopinion,a.Sxshwpzyy as segauditopinion,case when a.lrsj is not null then left(a.lrsj,4)+'-'+RIGHT(a.lrsj,2)+'-01' else null end as applydate ,case when a.Zyshsj is not null then left(a.Zyshsj ,4)+'-'+RIGHT(a.Zyshsj ,2)+'-01' else null end as CenAuditdate ,case when a.sxshsj is not null then left(a.Sxshsj ,4)+'-'+RIGHT(a.Sxshsj ,2)+'-01' else null end  as SegAuditdate ,rtrim(a.Xxdm )+LTRIM(a.xh),replace(a.Kcmc,',','') as coursename,a.sxh,isnull(c.ksdwlxdm,2) from %lv1%..mxmkb a left join %lv1%..xtykclydmb b on a.Xtykclydm =b.Xtykclydm left join %lv1% ..mkkcb c on a.Gzh =c.Gzh and a.Kcid =c.Kcid  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

