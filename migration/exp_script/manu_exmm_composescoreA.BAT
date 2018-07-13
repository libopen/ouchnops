@echo off
setlocal enabledelayedexpansion
::read it useing a for /l statement
:: time 
set _time_start=%time% 
set /a hour_start=%_time_start:~0,2% 
set /a minute_start=1%_time_start:~3,2%-100 
set /a second_start=1%_time_start:~6,2%-100 
echo %time% 
:: business logic 

set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="select   1 ,left(a.xxdm,3)  as segmentcode  ,LEFT(a.xxdm,5) as collegecode,b.bdm ,a.ksdm ,a.kslbdm ,a.ksdwlxdm ,a.kcid ,a.sjh,a.xxdm  ,a.Xh ,a.sjcj ,a.sjcjdm ,a.xkcj,a.xkcjdm ,a.xkbl ,a.zhcj ,a.zhcjdm ,isnull(CONVERT(varchar(10),a.qdcjsj,120),'1900-1-1'),'1900-1-1' ,case when a.zhcjdm is not null then 1 else 0 end ,case when a.zhcjdm is not null then 1 else 0 end  from %lv1%..zcjb a inner join %lv1%..xsb b on a.xh=b.xh   where CAST(left(a.xxdm,1) as int)<4 "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%


:: time 
set _time_end=%time% 
set /a hour_end=%_time_end:~0,2% 
set /a minute_end=1%_time_end:~3,2%-100 
set /a second_end=1%_time_end:~6,2%-100 
echo end datetime:%time% 
:: 计算秒数 
if %second_end% lss %second_start% ( 
set /a second_end=%second_end%+60 
set /a minute_end=%minute_end%-1 
) 
set /a second=%second_end%-%second_start% 
:: 计算分钟数 
if %minute_end% lss %minute_start% ( 
set /a minute_end=%minute_end%+60 
set /a hour_end=%hour_end%-1 
) 
set /a minute=%minute_end%-%minute_start% 
:: 计算小时数 
if %hour_end% lss %hour_start% ( 
set /a hour_end=%hour_end%+24 
) 
set /a hour=%hour_end%-%hour_start% 
echo %hour%:%minute%:%second% 
pause



