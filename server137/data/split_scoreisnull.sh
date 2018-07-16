start=$(date +%s.%N)



unzip score/scoreisnull183.zip -d score/



awk -F, '{if ($2=="321" && $22=='0') {print $0>"score/exmm_composescore321null.dat"}}' score/exmm_composescore010.csv 

rm score/exmm_composescore010.csv
sed -i 's/\r/,end/g' score/exmm_composescore321null.dat

cat score/exmm_composescore321.ctl score/exmm_composescore321null.dat > score/exec_composescore321null.ctl

cd score
zip  score.zip exec_*null.ctl 
read -s -n1 -p "Press any key to continue ... "
scp score.zip libin@202.205.161.135:/backup/ftpdata/
dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur


