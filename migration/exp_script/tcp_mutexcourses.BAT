set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

set va1= "  select 1 sn ,tt2.batchcode ,tt2.TCPCode ,tt2.Mkh ,tt1.zh ,tt2.Kcid  from  (select hckczh ,MAX(rid) as zh from  (select hckczh ,row_number()  OVER (ORDER BY sn ASC) rid,TCPCode,Kcid,batchcode,mkh from  (select a.Nd +a.Xqdm as batchcode ,right(a.Nd,2)+a.Xqdm+a.Xslxdm +a.Zyccdm+a.Zydm  as TCPCode  ,right(a.Nd,2)+a.Xqdm+a.Xslxdm +a.Zyccdm+a.Zydm+b.Hckczh hckczh ,b.Kcid ,right(a.Nd,2)+a.Xqdm+a.Xslxdm +a.Zyccdm+a.Zydm+b.Sxh as sn,b.Mkh   from %lv1%..hckcb b inner join %lv1%..zygzsyndb a on a.Gzh =b.Gzh ) as bb) as t1 group by hckczh ) as tt1  inner join (  select hckczh ,TCPCode,Kcid,batchcode,mkh from  (select a.Nd +a.Xqdm as batchcode ,right(a.Nd,2)+a.Xqdm+a.Xslxdm +a.Zyccdm+a.Zydm  as TCPCode   ,right(a.Nd,2)+a.Xqdm+a.Xslxdm +a.Zyccdm+a.Zydm+b.Hckczh hckczh ,b.Kcid ,right(a.Nd,2)+a.Xqdm+a.Xslxdm +a.Zyccdm+a.Zydm+b.Sxh as sn,b.Mkh   from %lv1%..hckcb b inner join %lv1%..zygzsyndb a on a.Gzh =b.Gzh ) as t2) as tt2 on tt1.hckczh =tt2.hckczh    "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

