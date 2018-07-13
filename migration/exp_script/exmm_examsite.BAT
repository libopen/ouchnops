rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select distinct 1 sn ,SUBSTRING(case when xxdm='9999999' then Kddm else xxdm end,1,3) seg,SUBSTRING (case when xxdm='9999999' then Kddm else xxdm end ,1,5) col ,case when xxdm='9999999' then Kddm else xxdm end Lea,a.Kdmc ESN,Kddm ESC ,a.Lxr,a.Dh,a.Dcrs    from %lv1%..kdxxb a  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

