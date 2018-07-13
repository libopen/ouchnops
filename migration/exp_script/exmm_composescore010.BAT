rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd %6segment
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5
set lv6=%6

 set va1="select   1 ,left(a.xxdm,3)  as segmentcode  ,LEFT(a.xxdm,5) as collegecode,rtrim(b.bdm) ,rtrim(a.ksdm) ,rtrim(a.kslbdm) ,a.ksdwlxdm ,a.kcid ,case when cast(LEFT(sjh,2) as int)=27 or cast(LEFT(sjh,2) as int)=49 then '4' else case when cast(LEFT(sjh,2) as int)<20 then '1' else case when cast(LEFT(sjh,2) as int)>49 then '5' else '2' end end end+a.sjh  sjh,rtrim(a.xxdm),a.Xh ,a.sjcj ,REPLACE(a.sjcjdm,' ','') ,a.xkcj,REPLACE(a.xkcjdm,' ',''),a.xkbl ,a.zhcj ,REPLACE(a.zhcjdm,' ','') ,isnull(CONVERT(varchar(10),a.qdcjsj,120),'1900-1-1'),'1900-1-1' ,case when a.zhcjdm is not null then 1 else 0 end ,case when a.zhcjdm is not null then 1 else 0 end  from %lv1%..zcjb a inner join %lv1%..xsb b on a.xh=b.xh    "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

