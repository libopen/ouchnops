select studentid,fullname,'end' end from eas_schroll_student where fullname like '% %'


select length(fullname),fullname from eas_schroll_student where studentid='80111000980101406416'

update eas_schroll_student set fullname=replace(fullname,' ','') where studentid='80111000980101406416'

truncate table cps_student

insert into cps_student(fullname,studentid)
with t1 as (select fullname,studentid from eas_schroll_student where
regexp_like (fullname ,'[[:space:]]'))
--select fullname,studentid,asciistr(fullname) from t1 where not regexp_like (fullname,'[A-Za-z0-9]+')
----345 
select fullname,studentid from t1 where not regexp_like (fullname,'[A-Za-z0-9]+')
and asciistr(substr(fullname,length(fullname),1))<>'\3000'

merge into eas_schroll_student a 
using(
with t1 as (select fullname,studentid from eas_schroll_student where
regexp_like (fullname ,'[[:space:]]'))
--select fullname,studentid,asciistr(fullname) from t1 where not regexp_like (fullname,'[A-Za-z0-9]+')
----345 
select fullname,studentid,asciistr(fullname) from t1 where not regexp_like (fullname,'[A-Za-z0-9]+')
and asciistr(substr(fullname,length(fullname),1))<>'\3000'    ---filter last space
) b on (a.studentid=b.studentid)
when matched then
update set fullname=replace(fullname,' ','')


select a.fullname,b.fullname from eas_schroll_student a inner join cps_student b on a.studentid=b.studentid

commit;
