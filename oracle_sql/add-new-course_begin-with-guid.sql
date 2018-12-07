CREATE TABLE OUCHNSYS.EAS_TCP_EXECMODULECOURSE1
(
  SN                   VARCHAR2(40 BYTE)        NOT NULL,
  BATCHCODE            VARCHAR2(6 BYTE)         NOT NULL,
  TCPCODE              VARCHAR2(15 BYTE)        NOT NULL,
  SEGMENTCODE          VARCHAR2(10 BYTE)        NOT NULL,
  LEARNINGCENTERCODE   VARCHAR2(10 BYTE)        NOT NULL,
  MODULECODE           VARCHAR2(2 BYTE)         NOT NULL,
  COURSEID             VARCHAR2(10 BYTE)        NOT NULL,
  COURSENATURE         VARCHAR2(2 BYTE)         NOT NULL,
  EXAMUNITTYPE         VARCHAR2(10 BYTE)        NOT NULL,
  CREDIT               NUMBER(7,2)              NOT NULL,
  HOUR                 NUMBER(7,2),
  SUGGESTOPENSEMESTER  NUMBER(2),
  PLANOPENSEMESTER     NUMBER(2)                NOT NULL,
  ISDEGREECOURSE       NUMBER(1),
  ISSIMILAR            NUMBER(1),
  CREATETIME           DATE                     NOT NULL
)


select * from eas_tcp_modulecourses where courseid='04391'

select * from eas_tcp_guidance where not exists( 
select * from eas_tcp_module where modulecode='04' and tcpcode=eas_tcp_guidance.tcpcode)

---1 .find all 04 and not 04391 add 
----1.confirm not exist 04391 in eas_tcp_modulecourse
with t1 as (select * from eas_tcp_module where modulecode='04' and batchcode<>'201809')
select * from eas_tcp_modulecourses a 
where exists(select * from t1 where modulecode=a.modulecode and tcpcode=a.tcpcode )
and courseid='04391'
---2 add newcourse in eas_tcp_modulecourse1
 --truncate table eas_tcp_modulecourses1
 
 
 INSERT into eas_tcp_modulecourses1 (
  SN, MODULECODE, BATCHCODE, TCPCODE, COURSEID, 
  COURSENAME, COURSENATURE, ORGCODE, CREDIT, HOUR, 
  OPENEDSEMESTER, EXAMUNITTYPE, ISEXTENDEDCOURSE, ISDEGREECOURSE, ISSIMILAR, 
  ISMUTEX, CREATETIME)
 with t1 as (select * from eas_tcp_modulecourses where courseid='04391' and tcpcode='180901456060710')
 ,t2 as (select sys_guid() as sn,'04' as modulecode,batchcode,tcpcode from eas_tcp_module  where modulecode='04' and batchcode<>'201809')
 --select '04', t2.batchcode,t2.tcpcode,t1.courseid from t1 cross join t2
 select t2.sn,t2.modulecode,t2.batchcode,t2.tcpcode,t1.courseid,
 t1.coursename,'3' as coursenature ,t1.orgcode,2 as credit,t1.hour,
 1 as openedsemester,1 as examunittype,t1.isextendedcourse,t1.isdegreecourse,t1.issimilar,t1.ismutex,to_date('2018-12-01 23:59:59','yyyy-mm-dd hh24:mi:ss') 
 from t1 cross join t2 
 
 
 --4008
 
 --3 merge eas_tcp_modulecourses
 MERGE INTO OUCHNSYS.EAS_TCP_MODULECOURSES A USING
 OUCHNSYS.EAS_TCP_MODULECOURSES1 B
ON (A.tcpcode = B.tcpcode and a.modulecode=b.modulecode and a.courseid=b.courseid)
WHEN NOT MATCHED THEN 
INSERT (
  SN, MODULECODE, BATCHCODE, TCPCODE, COURSEID, 
  COURSENAME, COURSENATURE, ORGCODE, CREDIT, HOUR, 
  OPENEDSEMESTER, EXAMUNITTYPE, ISEXTENDEDCOURSE, ISDEGREECOURSE, ISSIMILAR, 
  ISMUTEX, CREATETIME)
VALUES (
  B.SN, B.MODULECODE, B.BATCHCODE, B.TCPCODE, B.COURSEID, 
  B.COURSENAME, B.COURSENATURE, B.ORGCODE, B.CREDIT, B.HOUR, 
  B.OPENEDSEMESTER, B.EXAMUNITTYPE, B.ISEXTENDEDCOURSE, B.ISDEGREECOURSE, B.ISSIMILAR, 
  B.ISMUTEX, b.createtime)
 ---4008

---4. add to eas_tcp_guidanceonrule
---that is not in eas_tcp_guidanceonrule
select  tcpcode from eas_tcp_modulecourses1 where not exists(select * from eas_tcp_guidanceonrule where tcpcode=eas_tcp_modulecourses1.tcpcode)


merge into eas_tcp_guidanceonrule a
using 
(select eas_tcp_modulecourses1.tcpcode from eas_tcp_modulecourses1 inner join 
eas_tcp_modulecourses on eas_tcp_modulecourses1.sn=eas_tcp_modulecourses.sn
 ) b on (a.tcpcode=b.tcpcode)
when matched then
update  set totalcredits=a.totalcredits+2, moduletotalcredits=a.moduletotalcredits+2

---5 add to eas_tcp_guidanceormodulerule
merge into eas_tcp_guidanceonmodulerule a
using(
select eas_tcp_modulecourses1.tcpcode,eas_tcp_modulecourses1.modulecode from eas_tcp_modulecourses1 inner join 
eas_tcp_modulecourses on eas_tcp_modulecourses1.sn=eas_tcp_modulecourses.sn) b on (a.tcpcode=b.tcpcode and a.modulecode=b.modulecode)
when matched then
update  set totalcredits=a.totalcredits+2, requiredtotalcredits=a.requiredtotalcredits+2

---------------------------end--------------------------

---II . begin implement confirm the tcpcode will be added 
----      1.guidance have module 04 
with t1 as (select distinct segmentcode,tcpcode from eas_tcp_implmodulecourse where modulecode='04' and batchcode<>'201809')
select count(*) from t1
  
where exists(select * from t1 where modulecode=a.modulecode and tcpcode=a.tcpcode )
and courseid='04391'

---2 add newcourse in eas_tcp_implmodcou_temp
 --truncate table eas_tcp_implmodcou_temp
 
---my composite  
with t1 as (select batchcode,tcpcode,orgcode as segmentcode  from eas_tcp_implementation where batchcode<>'201809'
)
,t2 as (select '04' as modulecode,'04391' as courseid,'3' as coursenature,'1' as examunittype,2 as credit,null as hour,
'0' as isdegreecourse,'0' as isextendedcourse,'0' as issimilar,null as extendedsource
,to_date('2018-12-01 23:59:59','yyyy-mm-dd hh24:mi:ss') as createtime from dual)

,t3 as (select * from t1 cross join t2 )
,t4 as (select tcpcode from eas_tcp_module where batchcode<>'201809' and modulecode='04')
select count(*) from t3 where  exists(select * from t4 where tcpcode=t3.tcpcode)
---11491 
----有哪些实施性专业规则课程表中目前没有选修改课呢
with t1 as (select tcpcode,modulecode from eas_tcp_module where batchcode<>'201809' and modulecode='04')
,t2 as (select batchcode,tcpcode,orgcode  from eas_tcp_implementation where batchcode<>'201809')
,shouldhave as (select t1.tcpcode,t2.batchcode,t2.orgcode from t2 inner join t1 on t1.tcpcode=t2.tcpcode)
--select count(*) from shouldhave
,existed as (select distinct segmentcode,modulecode,tcpcode from eas_tcp_implmodulecourse where modulecode='04')
select * from shouldhave a where not exists(select * from existed where segmentcode=a.orgcode and tcpcode=a.tcpcode) 
and orgcode='330' and rownum<2
----example: 170306454030800
---

  merge into eas_tcp_implmodcou_temp a
       using (
       with t1 as (select batchcode,tcpcode,orgcode as segmentcode  from eas_tcp_implementation where batchcode<>'201809'
)
,t2 as (select '04' as modulecode,'04391' as courseid,'3' as coursenature,'1' as examunittype,2 as credit,null as hour,
'0' as isdegreecourse,'0' as isextendedcourse,'0' as issimilari,null as extendedsource
,to_date('2018-12-01 23:59:59','yyyy-mm-dd hh24:mi:ss') as createtime from dual)

,t3 as (select * from t1 cross join t2 )
,t4 as (select tcpcode from eas_tcp_module where batchcode<>'201809' and modulecode='04')
select batchcode     ,tcpcode , segmentcode ,modulecode     ,courseid,coursenature
      ,examunittype,credit,hour,isdegreecourse
      ,isExtendedcourse,issimilari,createtime from t3 where  exists(select * from t4 where tcpcode=t3.tcpcode)
        ) b
        on (a.segmentcode=b.segmentcode and a.tcpcode=b.tcpcode and a.modulecode=b.modulecode and a.courseid=b.courseid)
        when not matched then 
        insert  (sn                 ,batchcode     ,tcpcode ,segmentcode ,modulecode     ,courseid,coursenature
      ,modifiedcoursenature,examunittype,credit,hour,isdegreecourse
      ,isExtendedcourse,issimilari,createtime)
      values(sys_guid()              ,b.batchcode     ,b.tcpcode ,b.segmentcode ,b.modulecode   ,b.courseid,b.coursenature
      ,b.coursenature,b.examunittype,b.credit,b.hour,b.isdegreecourse
      ,b.isExtendedcourse,b.issimilari,b.createtime);
 
--3 add eas_tcp_implmodulecourse
 
 merge into eas_tcp_implmodulecourse a
       using eas_tcp_implmodcou_temp b
        on (a.segmentcode=b.segmentcode and a.tcpcode=b.tcpcode and a.modulecode=b.modulecode and a.courseid=b.courseid)
        when not matched then 
        insert  (sn                 ,batchcode     ,tcpcode ,segmentcode ,modulecode     ,courseid,coursenature
      ,modifiedcoursenature,examunittype,credit,hour,isdegreecourse
      ,isExtendedcourse,issimilari,createtime)
      values(b.sn              ,b.batchcode     ,b.tcpcode ,b.segmentcode ,b.modulecode   ,b.courseid,b.coursenature
      ,b.modifiedcoursenature,b.examunittype,b.credit,b.hour,b.isdegreecourse
      ,b.isExtendedcourse,b.issimilari,b.createtime);
 
 
 ---4. add to eas_tcp_implonrule
---that is not in eas_tcp_implonrule
select  tcpcode,segmentcode from eas_tcp_implmodcou_temp a where not exists(select * from eas_tcp_implonrule 
where tcpcode=a.tcpcode)



merge into eas_tcp_implonrule a
using(
select a.tcpcode,a.segmentcode from eas_tcp_implmodcou_temp a inner join 
eas_tcp_implmodulecourse b on a.sn=b.sn) b on (a.tcpcode=b.tcpcode and a.segmentcode=b.segmentcode )
 when matched then
 update  set moduletotalcredits=a.moduletotalcredits+2
             ,totalcredits=a.totalcredits+2
 
 ---5 add to eas_tcp_implonmodulerule
 merge into eas_tcp_implonmodulerule a
 using(
select a.tcpcode,a.segmentcode,a.modulecode from eas_tcp_implmodcou_temp a inner join 
eas_tcp_implmodulecourse b on a.sn=b.sn) b on (a.tcpcode=b.tcpcode and a.segmentcode=b.segmentcode and a.modulecode=b.modulecode )
  when matched then
  update set RequiredTotalCredits=a.RequiredTotalCredits+2,
             moduleTotalCredits =a.moduletotalcredits+2,
             SCCenterTotalCredits=a.SCCentertotalcredits+2
             
-----------------end

-----1 exec
---- exists have 04391
select * from eas_tcp_execmodulecourse where courseid='04391'             

with t1 as (select batchcode,tcpcode, segmentcode ,learningcentercode from eas_tcp_execution where batchcode<>'201809'
)
,t2 as (select '04' as modulecode,'04391' as courseid,'3' as coursenature,'1' as examunittype,2 as credit,null as hour,
'0' as isdegreecourse,'0' as issimilar,1 as planopensemester
,to_date('2018-12-01 23:59:59','yyyy-mm-dd hh24:mi:ss') as createtime from dual)
,t3 as (select * from t1 cross join t2 )
,t4 as (select tcpcode from eas_tcp_module where batchcode<>'201809' and modulecode='04')
select count(*) from t3 where  exists(select * from t4 where tcpcode=t3.tcpcode)

---39349
merge into EAS_TCP_ExecModuleCourse1 a
using (
with t1 as (select batchcode,tcpcode, segmentcode ,learningcentercode from eas_tcp_execution where batchcode<>'201809')
,t2 as (select '04' as modulecode,'04391' as courseid,'3' as coursenature,'1' as examunittype,2 as credit,null as hour,
'0' as isdegreecourse,'0' as issimilar,1 as planopensemester,1 as suggestopensemester
,to_date('2018-12-01 23:59:59','yyyy-mm-dd hh24:mi:ss') as createtime from dual)
,t3 as (select * from t1 cross join t2 )
,t4 as (select tcpcode from eas_tcp_module where batchcode<>'201809' and modulecode='04')
select BatchCode,tcpcode,segmentcode
                 ,learningcentercode
                 ,modulecode,courseid,coursenature,examunittype
                 ,credit,hour,isdegreecourse,issimilar
                 ,planopensemester,suggestopensemester
                 ,sys_guid() as sn,createtime from t3 where  exists(select * from t4 where tcpcode=t3.tcpcode) 
                 --and learningcentercode='3300101' and rownum<2
                 ) b
on (a.learningcentercode=b.learningcentercode and a.tcpcode=b.tcpcode and a.modulecode=b.modulecode and a.courseid=b.courseid)
when not matched then               
 insert (BatchCode,tcpcode,segmentcode
                 ,learningcentercode
                 ,modulecode,courseid,coursenature,examunittype
                 ,credit,hour,isdegreecourse,issimilar
                 ,planopensemester,suggestopensemester
                 ,sn,createtime)
values(b.BatchCode,b.tcpcode,b.segmentcode
                 ,b.learningcentercode
                 ,b.modulecode,b.courseid,b.coursenature,b.examunittype
                 ,b.credit,b.hour,b.isdegreecourse,b.issimilar
                 ,b.planopensemester,b.suggestopensemester
                 ,b.sn,b.createtime)               
                 
                 
----39349
 merge into EAS_TCP_ExecModuleCourse a
       using EAS_TCP_ExecModuleCourse1 b
        on (a.learningcentercode=b.learningcentercode and a.tcpcode=b.tcpcode and a.modulecode=b.modulecode and a.courseid=b.courseid)
        when not matched then 
                 insert (BatchCode,tcpcode,segmentcode
                 ,learningcentercode
                 ,modulecode,courseid,coursenature,examunittype
                 ,credit,hour,isdegreecourse,issimilar
                 ,planopensemester,suggestopensemester
                 ,sn,createtime)
values(b.BatchCode,b.tcpcode,b.segmentcode
                 ,b.learningcentercode
                 ,b.modulecode,b.courseid,b.coursenature,b.examunittype
                 ,b.credit,b.hour,b.isdegreecourse,b.issimilar
                 ,b.planopensemester,b.suggestopensemester
                 ,b.sn,b.createtime)     
                 
---   39349 rows merged.              

merge into eas_tcp_execonrule a
using(
select a.tcpcode,a.learningcentercode from EAS_TCP_ExecModuleCourse1 a inner join 
EAS_TCP_ExecModuleCourse b on a.sn=b.sn) b on (a.tcpcode=b.tcpcode and a.learningcentercode=b.learningcentercode )
 when matched then
 update  set moduletotalcredits=a.moduletotalcredits+2
             ,totalcredits=a.totalcredits+2
---39349 rows merged.

merge into eas_tcp_execonmodulerule a
using(
select a.tcpcode,a.learningcentercode,a.modulecode from EAS_TCP_ExecModuleCourse1 a inner join 
EAS_TCP_ExecModuleCourse b on a.sn=b.sn) b on (a.tcpcode=b.tcpcode and a.learningcentercode=b.learningcentercode and a.modulecode=b.modulecode )
 when matched then
 update  set moduletotalcredits=a.moduletotalcredits+2
             ,requiredtotalcredits=a.requiredtotalcredits+2

--39330 rows merged.

with t1 as (select * from eas_tcp_execmodulecourse where courseid='04391')
select * from t1 where not exists(select * from eas_tcp_execonmodulerule where tcpcode=t1.tcpcode
and learningcentercode=t1.learningcentercode and modulecode=t1.modulecode)  