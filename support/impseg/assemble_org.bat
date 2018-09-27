echo "auditrule"
cd /d d:/server183/support
REM c:/python34/python.exe expCpsSingle.py Org_class zssj impseg\csv
python.exe expCpsSingle.py Org_BaseInfo zssj impseg\csv
rem START CMD /C  "ECHO if use center db ,put the csv to 137 and filter it && PAUSE"
pause