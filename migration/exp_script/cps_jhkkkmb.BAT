rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select  Sjdm,Ksdm,Gxbz,Kslbdm,Kssjcd,Sfydtk,Sfsytq,Sfsycd,Sfpkc,Wzykcbz,Kcdybz,ksdy,Khfsdm,Sxh,Bbh,zjm,Sfyzgt,Sfyxsdxk,Sfyxfxlcj,Sfyxjxdlcj,Sfyxfxlxkcj,Sfyxjxdlxkcj,'010',Sjhmc from %lv1%..jhkkkmb  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

