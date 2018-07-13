rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select distinct 1 sn ,'010' org, b.Zydm , b.Xslxdm+b.Zyccdm xslb,a.Kcid,rtrim(a.Sjdm) ,case when isnumeric(isnull(a.SjdmB,''))=0 then null else a.sjdmb end ,'end'    from %lv1%..mkkcb a inner join %lv1%..zygzb b on a.Gzh =b.Gzh    inner join %lv1%..kskmb c on a.Sjdm =c.Sjdm  where     (len(isnull(a.Sjdm,''))+LEN(isnull(a.sjdmb,'')))=8 or (len(isnull(a.Sjdm,''))+LEN(isnull(a.sjdmb,'')))=4     "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

