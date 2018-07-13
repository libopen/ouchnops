rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="select     a.tcpcode         ,a.batchcode,a.Gzh as TCPName ,1 as educationtype,a.Xslxdm studenttype     , a.Zyccdm professionallevel ,a.Zydm spycode ,b.Byxf as Mingradcredits,b.Zyxf     as MinExamCredits ,b.Mxmkzgxf as ExemptionMaxCredits     ,b.Xzdm as schoolsystem, rtrim(c.Hzgxdm) as DegreeCollegeid ,c.Zdnd+c.zdxq as degreeSemester,b.Qybz as state     ,'imp' as creator ,a.Nd+a.Xqdm+'01' as createtime ,'imp' as enableUser,a.Nd+a.Xqdm+'01' as enabbletime                     from (select distinct a.nd,a.xqdm, RIGHT(a.nd,2)+ltrim(a.Xqdm)+ltrim(right(a.gzh,11)) as tcpcode ,a.Gzh ,a.nd+ltrim(a.Xqdm) batchcode,right(LEFT(a.gzh,6),2) as xslxdm,RIGHT(left(a.gzh,7),1) zyccdm,RIGHT(a.gzh,8) as zydm from %lv1%..zygzsyndb a  ) a inner join             %lv1%..zygzb b on a.Gzh =b.Gzh         left join %lv1%..xwshgzb c on b.Xw =c.Sxh        "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

