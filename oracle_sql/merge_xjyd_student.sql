---import 

select * from eas_schroll_student a where exists(select * from cps_student where studentid=a.studentcode)
----backup old 
merge into eas_schroll_student a 
using cps_student b on (a.studentcode=b.studentid)
when matched then
update  set learningcentercode=b.learningcentercode,classcode=b.classcode,spycode=b.spycode,tcpcode=b.newtcpcode