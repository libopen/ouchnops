rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select distinct b.sxh,a.tcpcode,b.Ksdm, b.kslbdm,b.Xslbdm,b.Zydm,b.Kcid,b.Kclxdm,b.Kcxzdm,b.Xf,b.Ksxq,b.glbmdm,b.Ksdwlxdm,b.zyksjdm, b.zyksjdmb, b.sksjdm, b.sksjdmb,b.Bbh,b.Sfsxjkc,b.orgcode from (select a.Orgcode, a.TCPCOde,a.Gzh ,a.xslbdm,a.zydm    from (select distinct  right(LEFT(a.gzh,6),2)+RIGHT(left(a.gzh,7),1) xslbdm,RIGHT(a.gzh,8) as zydm,   RIGHT(a.nd,2)+ltrim(a.Xqdm)+ltrim(right(a.gzh,11)) as tcpcode ,a.Gzh ,(select rtrim(xxdm) from %lv1%..xxdmb where LEN(xxdm)=3 and xxdm<>'010'     ) as Orgcode from %lv1%..zygzsyndb a) a inner join %lv1%..zygzb b on a.Gzh =b.Gzh ) a inner join (select  sxh,Gzh,Ksdm,rtrim(Kslbdm) kslbdm,Xslbdm,Zydm,Kcid,Kclxdm,Kcxzdm,Xf,Ksxq,rtrim(Glbmdm) as glbmdm,Ksdwlxdm,case when len(rtrim(Zyksjdm))=4 then rtrim(Zyksjdm) else '' end as zyksjdm,case when len(rtrim(ZyksjdmB))=4 then rtrim(ZyksjdmB) else '' end  as zyksjdmb,case when len(rtrim(Sksjdm))=4 then rtrim(Sksjdm) else '' end as sksjdm,case when len(rtrim(SksjdmB))=4 then rtrim(SksjdmB) else '' end as sksjdmb,Bbh,Sfsxjkc,(select rtrim(xxdm) from %lv1%..xxdmb where LEN(xxdm)=3 and xxdm<>'010' ) as orgcode from %lv1%..jhkkkcb ) b on a.Gzh=b.Gzh and a.xslbdm=b.Xslbdm and a.zydm=b.Zydm and a.Orgcode=b.orgcode  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

