
start=$(date +%s.%N)

unzip student/student183.zip -d student/

awk -F, '$1!~/^320|^511|^321|^330|^805|^90/ {print $0>"student/SchRoll_student.dat"}' student/SchRoll_student.csv 
awk -F, '$1!~/^320|^511|^321|^330|^805|^90/ {print $0>"student/SchRoll_studentBaseInfo.dat"}' student/SchRoll_studentBaseInfo_main.csv 

cd student
cat schroll_student1.ctl SchRoll_student.dat >exec_student1.ctl
cat schroll_studentbasic1main.ctl SchRoll_studentBaseInfo.dat >exec_studentbasicinfomain.ctl
zip student.zip exec_student*.ctl
read -s -n1 -p "Press any key to continue ... "
dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur
