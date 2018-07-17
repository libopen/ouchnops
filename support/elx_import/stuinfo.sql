----select studentcode,studentid,learningcentercode,classcode,spycode from eas_schroll_student where learningcentercode like '320%'


-----for studentphoto
with t1 as (select studentcode from eas_grad_audit where batchcode in('201701','201707') and segmentcode in('321','320','511'))
select a.studentcode idnumber,a.studentcode,a.studentid,a.batchcode,a.professionallevel,a.studenttype from eas_schroll_student a inner join eas_schroll_studentbasicinfo b 
on a.studentcode=b.studentcode where a.studentcode in ('1451101250554','1451101451325') 
union
select upper(b.idnumber) as idnumer,a.studentcode,a.studentid,a.batchcode,a.professionallevel,a.studenttype from eas_schroll_student a inner join eas_schroll_studentbasicinfo b 
on a.studentcode=b.studentcode where exists(select * from t1 where studentcode =a.studentcode)
and a.studentcode not in ('1451101250554','1451101451325')  
--and rownum<10 



----


select a.studentcode idnumber,a.studentcode,a.studentid,a.batchcode,a.professionallevel,a.studenttype from eas_schroll_student a inner join eas_schroll_studentbasicinfo b 
on a.studentcode=b.studentcode 
where b.idnumber='511128197901174812'