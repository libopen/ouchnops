start=$(date +%s.%N)

unzip stucourse/elc183.zip -d stucourse/

awk -F, '{if (substr($5,1,3)=="320") {print $0>"stucourse/elc_elc320.dat"} if (substr($5,1,3)=="511") {print $0>"stucourse/elc_elc511.dat"} if (substr($5,1,3)=="321") {print $0>"stucourse/elc_elc321.dat"}}' stucourse/elc_elc.csv 
rm stucourse/elc_elc.csv
cat stucourse/elc_elc511.ctl stucourse/elc_elc511.dat > stucourse/exec_elc511.ctl
cat stucourse/elc_elc320.ctl stucourse/elc_elc320.dat > stucourse/exec_elc320.ctl
cat stucourse/elc_elc321.ctl stucourse/elc_elc321.dat > stucourse/exec_elc321.ctl
cd stucourse
zip  elc.zip exec_elc*.ctl 
scp elc.zip libin@202.205.161.135:/backup/ftpdata/


dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur


