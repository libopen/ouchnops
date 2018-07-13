set lv1=%1  
set lv2=%2  
set lv3=%3  
set lv4=%4  
set lv5=%5  

set va1= "select a.Xh,a.Xjztdm ,'end'     from %lv1%..xsb a  where a.Xjztdm='2'  "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%


