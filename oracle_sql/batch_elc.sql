--320,321,330,511,805,901,-905,905
--select distinct substr(learningcentercode,1,3) from eas_schroll_student where batchcode='201809' and professionallevel='2'
--and substr(learningcentercode,1,1)='9'
/*
insert into eas_elc_studentelcinfo320 (refid,sn,batchcode,studentcode,courseid,learningcentercode,classcode,isplan,operator,elcstate,
OPERATETIME,
CONFIRMOPERATOR,
CONFIRMSTATE,
CONFIRMTIME,
CURRENTSELECTNUMBER,
SPYCODE,
ISAPPLYEXAM,
ELCTYPE,
STUDENTID,
ISCONVERSION)
select seq_elc_studentelc320.nextval,rowid,'201809',studentcode,'04391',learningcentercode,classcode,
case when professionallevel='2' then '0' else '1' end,'imp20181130','1',sysdate,'imp20181130','1',
sysdate,1,spycode,'0','4',studentid,0 from 
eas_schroll_student where batchcode='201809' and learningcentercode like '320%'
and not exists(select * from eas_elc_studentelcinfo320 where studentcode=eas_schroll_student.studentcode and courseid='04391');

update eas_elc_studentelcinfo320 set CONFIRMSTATE='1' ,CONFIRMTIME=sysdate where courseid='04391' and confirmstate='0';
*/

update eas_elc_studentelcinfo909 set ISAPPLYEXAM='1'  where courseid='04391' and operator='imp20181130';

insert into eas_elc_studentstudystatus (sn,studentcode,courseid,studystatus,sour)
select seq_elc_studentstudystatus.nextval,studentcode,courseid,'1','imp20181130'
from  eas_elc_studentelcinfo909 where not exists(select * from eas_elc_studentstudystatus
where studentcode=eas_elc_studentelcinfo909.studentcode and courseid=eas_elc_studentelcinfo909.courseid)
 and operator='imp20181130'and courseid='04391';

/*
with t1 as (select studentcode,courseid from eas_elc_studentelcinfo321 where courseid='04391' and operator='imp20181130')
select * from eas_elc_studentstudystatus a1 where exists(select * from t1 where t1.studentcode=a1.studentcode
and a1.courseid=t1.courseid) and sour<>'imp20181130'
*/

------ delete enrollmentstatus !=1
select distinct substr(learningcentercode,1,3)  from eas_schroll_student where batchcode='201809' and enrollmentstatus in ('2','5')
321
511
805
320
909
330

---truncate table eas_elc_studentelcinfotemp
insert into  eas_elc_studentelcinfotemp 
with t1 as (
select * from eas_elc_studentelcinfo902 a where courseid='04391' and  operator='imp20181130'
union
select * from eas_elc_studentelcinfo321 a where courseid='04391' and  operator='imp20181130'
union
select * from eas_elc_studentelcinfo511 a where courseid='04391' and  operator='imp20181130'
union
select * from eas_elc_studentelcinfo805 a where courseid='04391' and  operator='imp20181130'
union
select * from eas_elc_studentelcinfo320 a where courseid='04391' and  operator='imp20181130'
union
select * from eas_elc_studentelcinfo909 a where courseid='04391' and  operator='imp20181130'
union
select * from eas_elc_studentelcinfo330 a where courseid='04391' and  operator='imp20181130'
union
select * from eas_elc_studentelcinfo905 a where courseid='04391' and  operator='imp20181130'
)

select * from t1 a where 
 exists(select * from eas_schroll_student where studentcode=a.studentcode and batchcode='201809' and enrollmentstatus in ('2','5')) 
 
 
 ---321 :162
 delete from eas_elc_studentelcinfo321 where exists(select * from eas_elc_studentelcinfotemp where studentid=eas_elc_studentelcinfo321.studentid 
 and sn=eas_elc_studentelcinfo321.sn)
 
 delete from eas_elc_studentstudystatus where exists(select * from eas_elc_studentelcinfotemp where studentcode=eas_elc_studentstudystatus.studentcode 
 and courseid=eas_elc_studentstudystatus.courseid and learningcentercode like '321%')
 
 ---511:56
 delete from eas_elc_studentelcinfo511 where exists(select * from eas_elc_studentelcinfotemp where studentid=eas_elc_studentelcinfo511.studentid 
 and sn=eas_elc_studentelcinfo511.sn)
 
 delete from eas_elc_studentstudystatus where exists(select * from eas_elc_studentelcinfotemp where studentcode=eas_elc_studentstudystatus.studentcode 
 and courseid=eas_elc_studentstudystatus.courseid and learningcentercode like '511%')
 
 
  ---805:9
 delete from eas_elc_studentelcinfo805 where exists(select * from eas_elc_studentelcinfotemp where studentid=eas_elc_studentelcinfo805.studentid 
 and sn=eas_elc_studentelcinfo805.sn)
 
 delete from eas_elc_studentstudystatus where exists(select * from eas_elc_studentelcinfotemp where studentcode=eas_elc_studentstudystatus.studentcode 
 and courseid=eas_elc_studentstudystatus.courseid and learningcentercode like '805%')
 
 ---320:2
 delete from eas_elc_studentelcinfo320 where exists(select * from eas_elc_studentelcinfotemp where studentid=eas_elc_studentelcinfo320.studentid 
 and sn=eas_elc_studentelcinfo320.sn)
 
 delete from eas_elc_studentstudystatus where exists(select * from eas_elc_studentelcinfotemp where studentcode=eas_elc_studentstudystatus.studentcode 
 and courseid=eas_elc_studentstudystatus.courseid and learningcentercode like '320%')
 
---909:2
 delete from eas_elc_studentelcinfo909 where exists(select * from eas_elc_studentelcinfotemp where studentid=eas_elc_studentelcinfo909.studentid 
 and sn=eas_elc_studentelcinfo909.sn)
 
 delete from eas_elc_studentstudystatus where exists(select * from eas_elc_studentelcinfotemp where studentcode=eas_elc_studentstudystatus.studentcode 
 and courseid=eas_elc_studentstudystatus.courseid and learningcentercode like '909%')
 

---330:288
 delete from eas_elc_studentelcinfo330 where exists(select * from eas_elc_studentelcinfotemp where studentid=eas_elc_studentelcinfo330.studentid 
 and sn=eas_elc_studentelcinfo330.sn)
 
 delete from eas_elc_studentstudystatus where exists(select * from eas_elc_studentelcinfotemp where studentcode=eas_elc_studentstudystatus.studentcode 
 and courseid=eas_elc_studentstudystatus.courseid and learningcentercode like '330%')
 
