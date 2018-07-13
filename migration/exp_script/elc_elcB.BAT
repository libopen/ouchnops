rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="select  a.sxh,CAST(a.nd as CHAR(4))+CAST(a.xqdm as CHAR(2)),a.Xh ,a.Kcid ,a.Xxdm ,a.Bdm ,1,'imp',1,CONVERT(varchar(10),cast(a.sscsj as datetime),23),'imp',1,CONVERT(varchar(10),cast(a.sscsj as datetime),23),a.Xkcs ,0 as isapplyexam,4 as elctype,ltrim(a.Xxdm) +RTRIM(a.Xh) as studentid,1 as refid ,b.zydm from %lv1%..xsxkjgb a  inner join %lv1%..xsb b on a.xh=b.xh where cast(left(a.xxdm,1) as int)>3 "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

