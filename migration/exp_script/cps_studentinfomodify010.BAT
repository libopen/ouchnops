rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select 1 as sn ,a.Nd+a.Xqdm ,ltrim(b.Xxdm) +RTRIM(a.Xh) as studentid, a.Xh ,b.Xxdm ,b.Bdm , b.Xxdm as apporg, case when a.Zyshbz =1 then 8 else 7 end ,1 as isfinish ,a.Xm ,rtrim(a.Ylxm) ylxm, a.Xbdm ,a.Ylxbdm ,a.Sfzh ,a.Ylsfzh ,rtrim(a.Zydm) zydm,rtrim(a.Ylzydm) ylzydm ,a.Csrq ,a.Ylcsrq  ,a.Whcddm ,a.Ylwhcddm ,a.Zjlxdm ,a.Ylzjlxdm ,a.Mzdm ,a.YlMzdm,a.Ybysj,a.Ylybysj ,rtrim(a.Ybyxx) ybyxx,rtrim(a.Ylybyxx) ylbyxx ,a.bbh,rtrim(a.sxh),'cen' from %lv1%..xsxxgdb a inner join %lv1%..xsb b on a.Xh=b.xh  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%


