rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select b.Xxdm, 1 sn,a.Xh ,a.Dzzczh ,a.Xwzh,rtrim(a.Yxkml),a.Bynd ,a.Byxq,a.Bybz ,case when a.Xwbz=1 then 2 when a.Xwbz=3 then 1 else 0 end as Xwbz ,a.yzyccdm ,replace(a.ybysj,'/',''),a.Zplj ,a.Zpljdybz ,case when isdate(a.Bz1)=0 then null else CONVERT(varchar(10),cast(a.Bz1 as datetime) ,120) end as bz1 ,convert(varchar(30),a.Ybyxx) Ybyxx,replace(convert(varchar(30),a.Ylzy),char(10)+char(13),'') ylzy,'end'  from %lv1%..xsbyb a left join %lv1%..xsb b on a.Xh=b.Xh  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

