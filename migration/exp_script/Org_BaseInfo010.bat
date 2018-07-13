set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

set va1= " select 1,a.Xxdm ,replace(a.Xxmc ,',','£¬'),case when LEN(a.xxdm)=3 and a.xxdm <>'010' then '010' when a.xxdm ='010' then '' else  LEFT(a.xxdm,len(a.xxdm)-2) end,case when LEN(a.xxdm)=3 and a.xxdm <>'010' then 2 when LEN(a.xxdm)=5 then 3 when LEN(a.xxdm)=3 and a.xxdm ='010' then 1 when LEN(a.xxdm)>5 then  4 end,1 State ,'2000-1-1' from %lv1%..xxdmb a where LEN(a.xxdm)=3  and left(a.xxdm,3)!='807'   "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

