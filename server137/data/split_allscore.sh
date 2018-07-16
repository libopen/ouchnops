start=$(date +%s.%N)



awk -F, '{if (substr($5,1,3)=="410") {print $0>"stucourse/elc_elc410.dat"} if (substr($5,1,3)=="511") {print $0>"stucourse/elc_elc511.dat"} if (substr($5,1,3)=="321") {print $0>"stucourse/elc_elc321.dat"}}' stucourse/elc_elc.csv 
awk -F, '{if ($1=="410" || $1=="511" || $1=="321" ) {print $0>"stucourse/elc_studystatus.dat"}}' stucourse/elc_studystatus.csv 




#awk -F, '{if (substr($2,1,3)=="410" || substr($2,1,3)=="511" || substr($2,1,3)=="321") {print $0>"score/exmm_netexamscore.dat"}}' score/exmm_netexamscore.csv
#awk -F, '{if ($2=="805" || $2=="330") {print $0>"score/exmm_societyscore.dat"}}' score/exmm_societyscore.csv 

#awk -F, '{if ($6=="805" || $6=="330") {print $0>"expt/cps_exemptapply.dat"}}' expt/cps_exemptapply.csv
awk -F, '{if ($2=="410") {print $0>"score/exmm_composescore410.dat"} if ($2=="321") {print $0>"score/exmm_composescore321.dat"} if ($2=="511") {print $0>"score/exmm_composescore511.dat"}}' score/exmm_composescore.csv 
#awk -F, '{if (substr($5,1,3)=="805" || substr($5,1,3)=="330") {print $0>"student/cps_studentinfomodify.dat"}' student/cps_studentinfomodify010.csv 

dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur


