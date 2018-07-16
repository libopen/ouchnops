echo "tcpcenter"
cd /d d:/server183/support
python.exe expCpsSingle.py tcp_guidance zssj impseg\csv
python.exe expCpsSingle.py tcp_module zssj impseg\csv
python.exe expCpsSingle.py tcp_conversioncourse zssj impseg\csv
python.exe expCpsSingle.py tcp_modulecourses zssj impseg\csv
python.exe expCpsSingle.py tcp_modulebase zssj impseg\csv


cd /d d:/server183/support/impseg/csv
tcp183.bat
scp2 tcp183.zip libin@202.205.161.137:/home/libin/data/tcp/

