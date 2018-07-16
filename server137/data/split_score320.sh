start=$(date +%s.%N)



unzip score/score320183.zip -d score/



awk -F, '{if ($5=="201702") {print $0>"score/exmm_composescore3201702.dat"}}' score/exmm_composescoreseg.csv 

rm score/exmm_composescoreseg.csv
sed -i 's/\r/,end/g' score/exmm_composescore3201702.dat

cat score/exmm_composescore320.ctl score/exmm_composescore3201702.dat > score/exec_composescore3201702.ctl

cd score
zip  score320.zip exec_composescore3201702.ctl 
read -s -n1 -p "Press any key to continue ... "
scp score320.zip libin@202.205.161.135:/backup/ftpdata/
dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur


