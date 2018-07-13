rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select 1  sn, xh,Ylxxdm,Ylzydm,Zrxxdm,Zrzydm,Sqnd,Sqxq,replace(Ydyy ,',','£¬') Ydyy,Zyshbz Zyshbz,replace(Zybtyyy ,',','£¬')Zybtyyy,cast(Zcsxshbz as int) Zcsxshbz,cast(Zrsxshbz as int)  Zrsxshbz,replace(Zcsxbtyyy ,',','£¬')Zcsxbtyyy,cast(Zrbxdshbz as int)  Zrbxdshbz,replace(Zrsxbtyyy ,',','£¬') Zrsxbtyyy,cast(Zcbxdshbz as int) Zcbxdshbz,replace(Zcbxdbtyyy ,',','£¬')Zcbxdbtyyy,replace(Zrbxdbtyyy ,',','£¬') Zrbxdbtyyy,cast(Zrfxshbz as int) Zrfxshbz,replace(zrfxbtyyy ,',','£¬')zrfxbtyyy,cast(Zcfxshbz as int) Zcfxshbz,rtrim(replace(Zcfxbtyyy ,',','£¬')) Zcfxbtyyy,Sxh,Bbh,Pt,Zrbdm,Ylbdm,rtrim(Sshyh),case when isdate(Sshsj)=0 then null else CONVERT(varchar(10),cast(Sshsj as datetime) ,120) end Sshsj,rtrim(Fxshyh),case when isdate(Fxshsj)=0 then null else CONVERT(varchar(10),cast(Fxshsj as datetime) ,120) end  Fxshsj,rtrim(Jxdshyh),case when isdate(Jxdshsj)=0 then null else CONVERT(varchar(10),cast(Jxdshsj as datetime) ,120) end Jxdshsj,rtrim(Sqyh),case when isdate(Sqsj)=0 then null else CONVERT(varchar(10),cast(Sqsj as datetime) ,120) end  Sqsj,rtrim(Zrfxshyh),case when isdate(Zrfxshsj)=0 then null else CONVERT(varchar(10),cast(Zrfxshsj as datetime) ,120) end Zrfxshsj,rtrim(Zrjxdshyh),case when isdate(Zrjxdshsj)=0 then null else CONVERT(varchar(10),cast(Zrjxdshsj as datetime) ,120) end Zrjxdshsj,Fbbz,Ylgzh,rtrim(Xgzh),'end' from  %lv1%..xjydb  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%


