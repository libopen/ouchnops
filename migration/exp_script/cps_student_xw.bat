set lv1=%1  
set lv2=%2  
set lv3=%3  
set lv4=%4  
set lv5=%5  

set va1= "select ltrim(a.Xxdm) +RTRIM(a.Xh) as studentid,a.Zygznd +a.Zygzxq as batchcode,a.Xh,replace(a.Xm,',','.') ,a.gzh , a.Xxdm ,a.Bdm ,rtrim(a.Zydm) zydm,a.Zyccdm ,a.Xslxdm ,a.Xslxdm +a.Zyccdm as studenttype ,b.Yxkml as orginalCategory,a.Xjztdm ,a.Nd+'-'+a.Xqdm+'-01' as admissionTime,null as createtime  from %lv1%..xsb a  left join %lv1%..xsbyb b on a.xh=b.xh where a.zydm in (select zydm from %lv1%..zydmb where Zymc like '%%���̹���%%' or Zymc like '%%��ѧ%%' or Zymc like '%%��������ѧ%%' or Zymc like '%%�������ѧ�뼼��%%' or Zymc like '%%���ѧ%%'   ) and a.Zyccdm='2' and Xjztdm in ('7','1') "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

