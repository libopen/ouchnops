cd /d d:/server183/support/impseg
copy .\ctl\bkcourse_basicinfo.ctl+.\csv\course_basicinfo.csv .\exec\exec_course.ctl
REM copy .\ctl\eas_tcp_leacourse.ctl+.\csv\tcp_leacourse*csv .\exec\exec_leacourse.ctl
REM copy .\ctl\eas_tcp_segmentcourses.ctl + .\csv\tcp_segcourse*csv .\exec\exec_segcourse.ctl
REM copy .\ctl\eas_tcp_segmsemecourses.ctl + .\csv\tcp_segmsemecourses*csv .\exec\exec_segmsemecourses.ctl
REM copy .\ctl\eas_tcp_learcentsemecour.ctl + .\csv\tcp_learcentsemecour*csv .\exec\exec_learcentsemecour.ctl

REM cd /d d:/support/impseg/exec
REM 7z a course.zip exec_course.ctl exec_leacourse.ctl exec_learcentsemecour.ctl exec_segcourse.ctl exec_segmsemecourses.ctl
REM scp2 course.zip libin@202.205.161.135:/backup/ftpdata/
REM pause