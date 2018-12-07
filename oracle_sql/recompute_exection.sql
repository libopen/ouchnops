-----step 2 save oldexecrule.txt
insert into temp_tcplist(orgcode,tcpcode) values('8051800','170301203010100')

select * from eas_tcp_execonrule a where exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.learningcentercode) order by sn

--- step 3 save oldexecmrule.txt
select * from eas_tcp_execonmodulerule a where exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.learningcentercode) order by sn


----

merge into eas_tcp_execonrule a
using (
with t1 as (
select a.BatchCode ,a.segmentcode ,a.LearningCenterCode , a.TCPCode ,b.ModuleCode ,b.CourseID ,b.CourseNature ,b.ExamUnitType ,b.Credit 
 from EAS_TCP_Execution  a inner join EAS_TCP_ModuleCourses b on a.TCPCode =b.TCPCode 
where b.CourseNature =1 and exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.learningcentercode ))
,t2 as 
(
select a.BatchCode ,a.segmentcode ,a.LearningCenterCode , a.TCPCode ,b.ModuleCode ,b.CourseID ,b.CourseNature ,b.ExamUnitType ,b.Credit 
 from EAS_TCP_Execution  a inner join EAS_TCP_ImplModuleCourse b on a.TCPCode =b.TCPCode and a.segmentcode=B.SEGMENTCODE 
where b.CourseNature =2 and exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.learningcentercode ))
,t3 as
(  

 select b.BatchCode , b.SegmentCode , b.LearningCenterCode  ,b.TCPCode ,b.ModuleCode ,b.CourseID ,b.CourseNature,
 b.ExamUnitType ,b.Credit   from EAS_TCP_ExecModuleCourse  b 
 where  exists(select * from temp_tcplist where tcpcode=b.tcpcode and orgcode=b.learningcentercode ))
 ,t4 as ( 
 select * from t1
 union all
 select * from t2
 union all
 select * from t3)
 
 select BatchCode ,SegmentCode,LearningCenterCode  ,TCPCode 
 ,SUM(case when examunittype=1 then Credit else 0 end) s1
 ,SUM(Credit )s2 
 from t4
  group by batchcode,segmentcode,LearningCenterCode ,tcpcode

) b on (a.batchcode=b.batchcode and a.tcpcode=b.tcpcode and a.learningcentercode=b.learningcentercode)
when matched then
update set TotalCredits=s1,
           ModuleTotalCredits=s2
           
when not matched then
insert (sn,batchcode,tcpcode,segmentcode,learningcentercode,TotalCredits, ModuleTotalCredits)
values( seq_TCP_execOnRule.nextval,b.batchcode,b.tcpcode,b.segmentcode,b.learningcentercode,s1,s2)          
           
------

merge into eas_tcp_execonmodulerule a
using (
with t1 as (
select a.BatchCode ,a.segmentcode ,a.LearningCenterCode , a.TCPCode ,b.ModuleCode ,b.CourseID ,b.CourseNature ,b.ExamUnitType ,b.Credit 
 from EAS_TCP_Execution  a inner join EAS_TCP_ModuleCourses b on a.TCPCode =b.TCPCode 
where b.CourseNature =1 and exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.learningcentercode ))
,t2 as 
(
select a.BatchCode ,a.segmentcode ,a.LearningCenterCode , a.TCPCode ,b.ModuleCode ,b.CourseID ,b.CourseNature ,b.ExamUnitType ,b.Credit 
 from EAS_TCP_Execution  a inner join EAS_TCP_ImplModuleCourse b on a.TCPCode =b.TCPCode and a.segmentcode=B.SEGMENTCODE 
where b.CourseNature =2 and exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.learningcentercode ))
,t3 as
(  

 select b.BatchCode , b.SegmentCode , b.LearningCenterCode  ,b.TCPCode ,b.ModuleCode ,b.CourseID ,b.CourseNature,
 b.ExamUnitType ,b.Credit   from EAS_TCP_ExecModuleCourse  b 
 where  exists(select * from temp_tcplist where tcpcode=b.tcpcode and orgcode=b.learningcentercode ))
 ,t4 as ( 
 select * from t1
 union all
 select * from t2
 union all
 select * from t3)
 ,t5 as (select  batchcode,segmentcode,LearningCenterCode ,tcpcode from eas_tcp_execution b where 
  exists(select * from temp_tcplist where tcpcode=b.tcpcode and orgcode=b.segmentcode ))
 
 select  batchcode,segmentcode,LearningCenterCode ,tcpcode,ModuleCode 
 ,SUM(case when examunittype=1 then Credit else 0 end) s1
 ,SUM(Credit )s2 
 from t4
  group by batchcode,segmentcode,LearningCenterCode ,tcpcode,ModuleCode 
 union all
 select a.BatchCode ,b.SegmentCode ,b.learningcentercode,a.TCPCode ,a.modulecode,0,0  from eas_tcp_module a inner join t5 b on a.tcpcode=b.tcpcode  
 where  
  not exists(select * from t4 where tcpcode=a.tcpcode and modulecode=a.modulecode and learningcentercode=b.learningcentercode)
) b on (a.batchcode=b.batchcode and a.tcpcode=b.tcpcode and a.learningcentercode=b.learningcentercode and a.modulecode=b.modulecode)
when matched then
update set RequiredTotalCredits=s1,
           ModuleTotalCredits=s2    
when not matched then
insert ( SN,BatchCode,SegmentCode,LearningCenterCode,TCPCode,ModuleCode,RequiredTotalCredits,ModuleTotalCredits)
values(   seq_TCP_execOnModuRule.nextval,b.batchcode,b.segmentcode,b.learningcentercode,b.tcpcode,b.ModuleCode,b.s1,b.s2)              


------
-----step 2 save oldexecrule.txt


select * from eas_tcp_execonrule a where exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.learningcentercode) order by sn

--- step 3 save oldexecmrule.txt
select * from eas_tcp_execonmodulerule a where exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.learningcentercode) order by sn
