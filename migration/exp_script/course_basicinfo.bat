set lv1=%1 
set lv2=%2 
set lv3=%3 
set lv4=%4 
set lv5=%5 

set va1= "select  rtrim(dyxxdm)+kcid SN, a.Kcid as courseid,replace(REPLACE(a.kcmc,' ',''),',',';') as coursename,REPLACE(a.kcjc ,' ','') as Abbreviation,REPLACE (isnull(a.kczjm,''),' ','') as Mnemonic ,a.Kcccdm  as level,a.Kclxdm as Coursetype,RTRIM(a.Dyxxdm ) as OrgCode,a.Glbmdm as Department ,a.Zcjs as Teacher,a.Xf as credit,a.xslx as Hourtype, a.xs as hour,replace(isnull(a.Mldm,'9901'),' ','') as Categrries,left(replace(isnull(a.Mldm,'9901'),' ',''),2) as subject ,case when a.Kcztdm=0 then 1 else 0 end as state,CONVERT(varchar(10),a.dyrq ,120) as createtime ,1 as IsvalidCredit ,null as applicationtime  from %lv1%..kczb a" 
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

