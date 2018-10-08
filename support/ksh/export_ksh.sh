# 比较相同学号但考试号不同的转为sql输出
######## 使用18-5-xuexin.csv 包含考试号的dbf             且已经排序
 
######## 使用18-5-ouchn.csv 包含考试号来源于ouchn库的数据且已经排序

#比较-->　筛选考试号不同的-->　导出
join -1 1 -2 1 -t , -o 1.1 1.2 2.2  18-5-xuexin.csv 18-5-ouchn.csv | awk -F, '{if ($2!=$3) {print  "update eas_schroll_student set examno=\047"$2"\047 where studentcode=\047"$1"\047 ;"}}'>exec_update_ksh.sql


