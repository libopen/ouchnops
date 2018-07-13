set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

set va1= " select   ltrim(b.Xxdm) +RTRIM(b.Xh) as studentid ,a.Xh StudentCode ,replace(replace(a.Brlxdh ,char(13),'') ,',',';')  as myphone ,replace(replace(a.Email ,char(13),'') ,',',';') Email  ,replace(replace(a.yddh ,char(13),'') ,',',';')  mobile    from %lv1%..xsjbqkb  a inner join %lv1%..xsb b on a.Xh=b.xh  "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

