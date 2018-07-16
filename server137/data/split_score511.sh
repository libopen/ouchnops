start=$(date +%s.%N)



unzip score/score511183.zip -d score/



awk -F, '{if ($5=="201702") {print $0>"score/exmm_composescore5111702.dat"}}' score/exmm_composescoreseg.csv 

rm score/exmm_composescoreseg.csv
sed -i 's/\r/,end/g' score/exmm_composescore5111702.dat

cat score/exmm_composescore511.ctl score/exmm_composescore5111702.dat > score/exec_composescore5111702.ctl

cd score
zip  score511.zip exec_composescore5111702.ctl 
read -s -n1 -p "Press any key to continue ... "
scp score511.zip libin@202.205.161.135:/backup/ftpdata/
dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur


