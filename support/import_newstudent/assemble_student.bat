echo "auditrule"
cd /d d:/server183/support  rem this is the path of file expCpsSingle.py 
python.exe expCpsSingle.py SchRoll_student zssj1 impnewstudent2017\csv
REM pause
python.exe expCpsSingle.py SchRoll_studentBaseInfo zssj1 impnewstudent2017\csv
python.exe expCpsSingle.py cps_student zssj1 impnewstudent2017\csv
python.exe expCpsSingle.py Org_class zssj1 impnewstudent2017\csv
python.exe expCpsSingle.py cps_gradstudent zssj1 impnewstudent2017\csv
