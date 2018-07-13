set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

set va1= " select  ltrim(b.Xxdm) +RTRIM(b.Xh) as studentid ,a.Xh StudentCode ,left(a.Xbdm,1) Gender  ,left(a.Mzdm,2)  Ethnic ,case when left(a.Zzmmdm,2)='14' or left(a.Zzmmdm,2)='15' then '13' else left(a.Zzmmdm,2) end Politicsstatus ,a.Hyzkdm Maritalstatus ,left(a.Jgdm,2) HomeTown  ,CONVERT(varchar(10),a.Csrq ,120) birghday  ,left(a.Whcddm,2)  education  ,CONVERT(varchar(10),a.Cjgzsj ,120) workingtime ,left(a.Hkxzdm,2) hukou ,a.Sfzh idnumber ,left(a.Fbdm,1) distribution ,a.Xflydm tuition  ,a.Zkzh admissionnumber  ,a.Zjlxdm ducumenttype ,a.Sfzh idcard ,'end'    from %lv1%..xsjbqkb  a inner join %lv1%..xsb b on a.Xh=b.xh  "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

