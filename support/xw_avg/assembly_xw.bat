cd /d d:/server183/support
python.exe expCpsSingle.py cps_xw_avgscore mid xw_avg
rem python.exe expCpsSingle.py cps_xw_studentcourse mid xw_avg
cd /d d:/server183/support/xw_avg 
copy cps_xw_avgscore.ctl+cps_xw_avgscore.csv exec_cps_xw_avgscore.ctl
rem copy cps_xw_studentcourse.ctl+cps_xw_studentcourse.csv exec_cps_xw_studentcourse.ctl
pause