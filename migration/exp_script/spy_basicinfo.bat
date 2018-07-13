set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="select 1 as SN,a.zydm ,case when CHARINDEX(')',Zymc )>0 then replace(RIGHT(zymc, LEN(zymc)-charindex('(',zymc)),')','') else null end as spydirection,case when CHARINDEX('(',Zymc )>0 then replace(left(zymc, charindex('(',zymc)),'(','') else zymc end as spyname ,case when a.Jwzydm IS NULL then LEFT(a.Zydm ,6) else a.Jwzydm end as jwzydm ,LEFT(a.Zydm ,2),'2000-1-1'  from %lv1%..zydmb a "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

