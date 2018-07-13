rem ##temp1 选在原数据库执行角本 相似课.sql
set lv2=cps1
set dbip=10.96.142.103
set dbuser=sa
set dbpwd=abc123
set expPath=d:\


set va1="select 1, a.batchcode ,a.TCPCOde ,a.Mkh ,b.Kcid ,a.zh ,null   from ##temp1 a inner join  (select right(a.Nd,2)+a.Xqdm+a.Xslxdm +a.Zyccdm+a.Zydm  as TCPCOde ,a.Nd+a.Xqdm as batchcode,c.mkh, c.Xskczh ,c.Kcid from %lv2%..zygzsyndb a inner join %lv2%..zygzb b on a.Gzh =b.Gzh  inner join %lv2% ..xskcb c on a.Gzh =c.Gzh ) b on a.TCPCOde =b.TCPCOde and a.Mkh =b.Mkh and a.batchcode =b.batchcode and a.Xskczh =b.Xskczh  order by a.zh  
set va2=%expPath%EAS_TCP_SimilarCourses.csv
bcp %va1%  queryout %va2% -c -t, -r\n    -S%dbip% -U%dbuser% -P%dbpwd%

