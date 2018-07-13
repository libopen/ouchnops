set lv1=%1  
set lv2=%2  
set lv3=%3  
set lv4=%4  
set lv5=%5  

set va1= "select  ltrim(a.Xxdm) +RTRIM(a.Xh) as studentid,a.Xh,right(a.zygznd,2)+rtrim(a.zygzxq)+right(rtrim(a.gzh),11) as tcpcode , a.Xxdm ,a.Bdm ,rtrim(a.Zydm) zydm,a.Zyccdm ,a.Xslxdm ,a.Xslxdm +a.Zyccdm as studenttype ,rtrim(b.Yxkml) as orginalCategory,a.Xjztdm ,a.Nd+'-'+a.Xqdm+'-01' as admissionTime,a.Nd+a.Xqdm as batchcode,replace(replace(rtrim(a.Xm) ,char(13)+char(10),'') ,',','-'),'end'     from %lv1%..nxsb a  left join %lv1%..xsbyb b on a.xh=b.xh  "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%


