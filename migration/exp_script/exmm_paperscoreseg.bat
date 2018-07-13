rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd %6segment
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5
set lv6=%6

 set va1=" select 1,Ksdm,Kslbdm,kcid,case when cast(LEFT(sjh,2) as int)=27 or cast(LEFT(sjh,2) as int)=49 then '4' else case when cast(LEFT(sjh,2) as int)<20 then '1' else case when cast(LEFT(sjh,2) as int)>49 then '5' else '2' end end end+sjh  sjh,xsb.Xh,Czdw,rtrim(zgcjlr1),rtrim(Zgcjlr2),rtrim(Kgcjlr1),rtrim(Kgcjlr2),rtrim(Zgcjlr1dm),rtrim(Zgcjlr2dm) ,rtrim(Kgcjlr1dm),rtrim(Kgcjlr2dm),sjcj,Sjcjdm,rtrim(kgcjlr1czy), isnull(CONVERT(varchar(10),Kgcjlr1czrq,120),'1900-1-1'),rtrim(Kgcjlr2czy), isnull(CONVERT(varchar(10),kgcjlr2czrq,120),'1900-1-1'),rtrim(Zgcjlr1czy), isnull(CONVERT(varchar(10),Zgcjlr1czrq,120),'1900-1-1'),rtrim(zgcjlr2czy), isnull(CONVERT(varchar(10),zgcjlr2czrq,120),'1900-1-1'),Kgcjjybz,zgcjjybz,'1' Lrbz,left(xsb.xxdm,3),left(xsb.xxdm,5),xsb.xxdm,'end' from %lv1%..sjcjb inner join %lv1%..xsb  on sjcjb.xh=xsb.xh"
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

