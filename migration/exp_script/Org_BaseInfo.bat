set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

set va1= " select 1,rtrim(a.Xxdm) ,replace(a.Xxmc ,',','£¬'),LEFT(a.xxdm,len(a.xxdm)-2),case when LEN(a.xxdm)=3 then 2 when LEN(a.xxdm)=5 then 3 else 4 end,1 State,'2000-1-1' from %lv1%..xxdmb a   "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

