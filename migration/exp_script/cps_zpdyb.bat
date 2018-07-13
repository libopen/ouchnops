set lv1=%1  
set lv2=%2  
set lv3=%3  
set lv4=%4  
set lv5=%5  

set va1= "select ltrim(b.Xxdm) xxdm , a.Xh,replace(replace(rtrim(a.zslsh) ,char(13)+char(10),'') ,',','-'),'end'     from %lv1%..zpdyb a inner join %lv1%..xsb b on a.Xh=b.xh "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%


