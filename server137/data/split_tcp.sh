start=$(date +%s.%N)


unzip tcp/tcp183.zip -d tcp/

awk -F, '{if ($2=="201809"  ) {print $0>"tcp/tcp_guidance1.dat"}}' tcp/tcp_guidance.csv 
awk -F, '{if ($2=="201809"  ) {print $0>"tcp/tcp_module1.dat"}}' tcp/tcp_module.csv
awk -F, '{if ($3=="201809"  ) {print $0>"tcp/tcp_modulecourses1.dat"}}' tcp/tcp_modulecourses.csv
awk -F, '{if ($2=="201809"  ) {print $0>"tcp/tcp_conversioncourse.dat"}}' tcp/tcp_conversioncourse.csv
cd tcp
cat tcp_guidance1.ctl tcp_guidance1.dat >exec_guidance1.ctl
cat tcp_module1.ctl tcp_module1.dat >exec_module1.ctl
cat tcp_modulecourses1.ctl tcp_modulecourses1.dat >exec_modulecourses1.ctl
cat tcp_conversioncourse.ctl tcp_conversioncourse.dat >exec_conversioncourse.ctl
cat tcp_dicmodule.ctl tcp_modulebase.csv >exec_dicmodule.ctl
zip tcp.zip exec*.ctl
read -s -n1 -p "Press any key to continue ... "
scp tcp.zip libin@202.205.161.135:/backup/ftpdata/
dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur


