
start=$(date +%s.%N)

unzip student/student183.zip -d student/

awk -F, '$1~/^805|^330|^320|^511|^321/  {print $0>"student/cps_gradstudent.dat"}' student/cps_gradstudent.csv 
awk -F, '$1~/^320|^511|^321/ {print $0>"student/cps_student.dat"}' student/cps_student.csv 
awk -F, '$1!~/^320|^511|^321|^330|^805|^90/ {print $0>"student/SchRoll_student.dat"}' student/SchRoll_student.csv 
awk -F, '$1!~/^320|^511|^321|^330|^805|^90/ {print $0>"student/SchRoll_studentBaseInfo.dat"}' student/SchRoll_studentBaseInfo.csv 
#awk -F, '$1!~/^320|^511|^321|^330|^805|^90/ {print $0>"student/SchRoll_studentBaseInfo.dat"}' student/SchRoll_studentBaseInfo_main.csv 
awk -F, '$3~/^320|^511|^321/ {print $0>"student/schroll_absence.dat"}' student/schroll_absence.csv 
awk -F, '$5~/^320|^511|^321/ {print $0>"student/cps_studentinfomodify.dat"}' student/cps_studentinfomodify.csv 

cd student
cat cps_student.ctl cps_student.dat >exec_cpsstudent.ctl
cat cps_gradstudent.ctl cps_gradstudent.dat >exec_gradstudent.ctl
cat schroll_student1.ctl SchRoll_student.dat >exec_student1.ctl
cat schroll_studentbasic1.ctl SchRoll_studentBaseInfo.dat >exec_studentbasicinfo.ctl
cat eas_schroll_absence.ctl schroll_absence.dat >exec_absence.ctl
cat cps_studentinfomodify.ctl cps_studentinfomodify.dat > exec_studentinfomodify.ctl
zip student.zip exec*.ctl
read -s -n1 -p "Press any key to continue ... "
scp student.zip libin@202.205.161.135:/backup/ftpdata/
dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur
