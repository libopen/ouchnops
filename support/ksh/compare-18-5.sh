# from TOAD 导出的数据最后一列会包含回车键，需要去除，否则会影响join 
awk -F, -v OFS=',' '{print substr($0,1,length($0)-1)}' /backup/ftpdata/support/ksh/student_real-5.txt|sort -k1 >/home/libin/mypython/ksh/18-5-ouchn.csv
cat 18ben.csv 18zhuan.csv|awk -F, -v OFS=',' '{print $1,$2,$9}' |sort -k1 > 18-5-xuexin.csv
echo 'only in ouchn and not in xuexin if xuein not exist then $6==""'
join -1 1 -2 1 -t "," -o 1.1 1.2 1.3 1.4 1.5 2.2 2.3 18-5-ouchn.csv 18-5-xuexin.csv -a 1 |awk -F, -v OFS=',' '{if($6=="") {print $0}}'>18-not-in-xuexin.csv


