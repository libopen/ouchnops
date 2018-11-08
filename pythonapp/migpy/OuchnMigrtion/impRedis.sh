awk -F',' '{print "LPUSH", "\"COURSEID\"","\""$2"\""}' eas_course_basicinfo.csv |redis-cli -h 10.96.142.109 -p 6380 -n 4
