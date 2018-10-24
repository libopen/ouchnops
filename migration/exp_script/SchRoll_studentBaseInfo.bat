set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5
rem "SQL server replace LR CR use char(10),char(13)
set va1= " select  ltrim(b.Xxdm) +RTRIM(b.Xh) as studentid ,a.Xh StudentCode ,left(a.Xbdm,1) Gender  ,left(a.Mzdm,2)  Ethnic ,case when left(a.Zzmmdm,2)='14' or left(a.Zzmmdm,2)='15' then '13' else left(a.Zzmmdm,2) end Politicsstatus ,a.Hyzkdm Maritalstatus ,left(a.Jgdm,2) HomeTown  ,CONVERT(varchar(10),a.Csrq ,120) birghday  ,left(a.Whcddm,2)  education  ,CONVERT(varchar(10),a.Cjgzsj ,120) workingtime ,left(a.Hkxzdm,2) hukou ,a.Sfzh idnumber ,left(a.Fbdm,1) distribution ,a.Xflydm tuition  ,a.Zkzh admissionnumber  ,replace(replace(replace(a.Gzdw ,char(13),''),char(10),'') ,',',';')  workunit ,replace(replace(replace(a.Dwdz ,char(13),''),char(10),'') ,',',';') workaddress ,a.Dwyzbm workzipcode ,replace(replace(replace(a.Dwdh ,char(13),''),char(10),'') ,',',';')  workphone  ,replace(replace(a.Bryzbm,CHAR(13),''),char(10),'')  as myzipcode  , replace(replace(replace(a.Brlxdh,CHAR(13),''),char(10),''),',',';')  as myphone  ,a.Byzh deplomanumber ,replace(replace(a.Zyqkdm ,char(13),''),char(10),'') professionalsituation  ,replace(replace(replace(a.yddh,CHAR(13),''),char(10),''),',',';')  mobile  ,a.Zjlxdm ducumenttype ,a.Sfzh idcard ,replace(replace(replace(a.Brtxdz,char(10),'') ,char(13),'') ,',',';') myaddress,replace(replace(replace(a.email,CHAR(13),''),char(10),''),',',';') Email    from %lv1%..xsjbqkb  a inner join %lv1%..xsb b on a.Xh=b.xh  "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

