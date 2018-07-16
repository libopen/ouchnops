start=$(date +%s.%N)


unzip stucourse/studystatus183.zip -d stucourse/
awk -F, '$1~/^320|^511|^321/  {print $0>"stucourse/elc_studystatus.dat"}' stucourse/elc_studystatus.csv 
cd stucourse
cat elc_studystatus.ctl elc_studystatus.dat >exec_studystatus.ctl
zip studystatus.zip exec_studystatus.ctl
read -s -n1 -p "Press any key to continue ... "
scp studystatus.zip libin@202.205.161.135:/backup/ftpdata/
dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur


