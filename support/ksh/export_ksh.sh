
awk -F, '{print "update eas_schroll_student set examno=\047"$2"\047 where studentcode=\047"$1"\047 ;"}' ksh.csv 
