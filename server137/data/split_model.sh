start=$(date +%s.%N)



awk -F, '{if (substr($5,1,3)=="805") {print $0>"stucourse/elc_elc805.dat"} if (substr($5,1,3)=="330") {print $0>"stucourse/elc_elc330.dat"}}' stucourse/elc_elc.csv 
awk -F, '{if ($1=="805" || $1=="330") {print $0>"stucourse/elc_studystatus.dat"}}' stucourse/elc_studystatus.csv 




awk -F, '{if (substr($2,1,3)=="805" || substr($2,1,3)=="330") {print $0>"score/exmm_netexamscore.dat"}}' score/exmm_netexamscore.csv
awk -F, '{if ($2=="805" || $2=="330") {print $0>"score/exmm_societyscore.dat"}}' score/exmm_societyscore.csv 

awk -F, '{if ($6=="805" || $6=="330") {print $0>"expt/cps_exemptapply.dat"}}' expt/cps_exemptapply.csv
awk -F, '{if ($2=="805") {print $0>"score/exmm_composescore805.dat"} if ($2=="330") {print $0>"score/exmm_composescore330.dat"}}' score/exmm_composescore.csv 
awk -F, '{if (substr($5,1,3)=="805" || substr($5,1,3)=="330") {print $0>"student/cps_studentinfomodify.dat"}' student/cps_studentinfomodify010.csv 

dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur


