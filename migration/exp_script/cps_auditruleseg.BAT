rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select  1,a.Xtnkccc ,a.Xtnkcid ,a.Xtnkcmc ,a.Xtnxf ,a.Xtwzymc ,a.Xtnkccc ,rtrim(a.Xtwkcmc) , rtrim(b.Xtykclymc) ,a.Bzdw, a.Zsyxq ,(select rtrim(xxdm) from %lv1%..xxdmb where LEN(xxdm)=3 and xxdm<>'010' ) as orgcode from %lv1%..mxmkshgzb a left join %lv1%..xtykclydmb b on a.Xtwkclx=b.Xtykclydm  "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

