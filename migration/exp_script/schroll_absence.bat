set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

set va1= " select 1,a.xh,LEFT(b.xxdm,3),b.Xxdm,b.Bdm,rtrim(a.sqnd)+rtrim(a.sqxq),'' as applicant,rtrim(replace(replace(a.xxtxyy ,char(13),'') ,',',';')) as appreason ,'2' as apptype,replace(replace(a.jxdbtyyy ,char(13),'') ,',',';') as leaauditopinion  ,case when a.jxdspbz=1 then '1'        when a.jxdspbz=0 then '2' end as leaaustat  ,rtrim(replace(replace(a.fxbtyyy ,char(13),'') ,',',';')) as segopin  ,case when a.fxbz=1 then '1'        when a.fxbz=0 then '2' end as segaustat        ,case when a.zyspbz=0 then '7'      when a.zyspbz=1 then '7.5'      else          case when fxbz=1 then '6'               when a.fxbz=null then '3'               when a.fxbz=0 then '4'               when a.fxbz=2 then '6' end end as auditstate  ,rtrim(replace(replace(a.zybtyyy ,char(13),'') ,',',';')) as cenopin   ,case when a.zyspbz=1 then 1        else 0 end as isreport         ,0 isfinish , 'imp' as appsource  from %lv1%..xsxxtxsqb a inner join %lv1%..xsb b on a.xh=b.xh where a.jxdspbz ='1' and xxtxbz='5'  "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

