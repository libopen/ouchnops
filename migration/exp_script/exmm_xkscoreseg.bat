rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd %6segment
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5
set lv6=%6

 set va1="select distinct 1,Ksdm,rtrim(Kslbdm),kcid,case when cast(LEFT(sjh,2) as int)=27 or cast(LEFT(sjh,2) as int)=49 then '4' else case when cast(LEFT(sjh,2) as int)<20 then '1' else case when cast(LEFT(sjh,2) as int)>49 then '5' else '2' end end end+sjh  sjh,LEFT(xsb.xxdm,3),LEFT(xsb.xxdm,5),xsb.xxdm,xsb.Xh,cj,REPLACE(cjdm,' ',''),Czy,isnull(CONVERT(varchar(10),czrq,120),'1900-1-1'),1 ,xsb.bdm,'end' from %lv1%..xkxmcjb inner join %lv1%..xsb  on xkxmcjb.xh=xsb.xh where xkxmcjb.jxb='999' "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

