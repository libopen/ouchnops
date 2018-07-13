rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select b.Xxdm, a.Xh ,a.Dzzczh ,a.Xwzh,a.Bynd+a.Byxq as batchcode,case when a.Xwbz=1 then 2 when a.Xwbz=3 then 1 else 0 end ,a.xwbz, 'end'   from %lv1%..xsbyb a left join %lv1%..xsb b on a.Xh=b.Xh  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

