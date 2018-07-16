start=$(date +%s.%N)



#unzip score/score183.zip -d score/



awk -F, '{if (( $2!~/^201701/)) {print $0>"score/exmm_xkscore330.dat"}}' score/exmm_xkscore330.csv 
awk -F, '{if (( $2!~/^201701/)) {print $0>"score/exmm_paperscore330.dat"}}' score/exmm_paperscore330.csv 


read -s -n1 -p "Press any key to continue ... "
dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur


