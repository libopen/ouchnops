rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1="select 1 as SN,LEFT(a.xxdm,3) as segmentorgcode,a.xxdm as learningcenterorgcode,a.zydm,a.xslxdm as studenttype,a.zyccdm as professionallevel,a.Zyzt as openstate,CONVERT(varchar(10),a.pzsj,120) as createtime from %lv1%..jxdzyszb0505 a where a.xslxdm is not null"
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

