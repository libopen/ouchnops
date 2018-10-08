# 合并本，专到一个文件并排序
######## dbf 文件导出使用　expksh.py 导出字段的位置固定
#cat 18ben.csv 18zhuan.csv|sort -k1 > 18-8-xuexin.csv
# toad 导出教务系统的记录处理并排序　注意导出的编码为utf-8 
########导出用角本export_student+baseinfo8.sql
#sort -k1 /backup/ftpdata/support/ksh/student_real-8.txt > 18-8-ouchn.csv
#比较前先确认各字段的位置
#　head 18-8-xuexin.csv 18-8-ouchn.csv

#比较将各个字段排列后导出分别为：
#－－－－－－－－－－－－－姓名-----，证件号-- ，性别--- ，民族----,出生日期--入学年度
#join -1 1 -2 1 -t , -o 1.1 1.5 2.2 1.3,2.5 1.6 2.6 1.8 2.7 1.7 2.4 1.4 2.3 18-8-xuexin.csv 18-8-ouchn.csv >18-8-equal.csv
# 分别对不同字段对比并导出
#比较日期不同：方法，将系统日期（不规则格式）按／转化为数组，分别比较年，但月，日的只比较最后一位　$10,$11
#身份证最后一位字母不区分大小写
awk -F, '{ split($11,arr,"/");if ((arr[1]!=substr($10,1,4))|| 
(substr(arr[2],length(arr[2]),1)!=substr($10,6,1)) || 
(substr(arr[3],length(arr[3]),1)!=substr($10,8,1))) 
                                                    {print "CSRQ:",$0}
                        if($2!=$3)                  {print "XM  :",$0} 
                        if(tolower($4)!=tolower($5)) {print "SFZH:",$0} 
                        if($6!=$7)                  {print "XB  :",$0} 
                        if($8!=$9)                  {print "MZ  :",$0}}' 18-8-equal.csv                 


