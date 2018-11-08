echo "kczb"
cd /d d:/server183/support 
python.exe expCpsSingle.py spy_basicinfo zssj impseg\csv
python.exe expCpsSingle.py spy_openspycen zssj impseg\csv
REM c:/python34/python.exe expCpsSingle.py spy_openspyseg center impseg\csv
REM c:/python34/python.exe expCpsSingle.py spy_openspylea center impseg\csv


cd /d impseg/csv
spy183.bat
scp2 spy183.zip libin@202.205.161.137:/home/libin/data/spy/

pause