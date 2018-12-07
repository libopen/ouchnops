
insert into temp_tcplist(orgcode,tcpcode) values('320','170901411020310')
 

------- step 1 : 
merge into temp_tcplist a 
using(
with t1 as (select column_value as courseid from table(splitstr('03154,01803',',')))
,t2 as (select segmentcode,tcpcode,sn,examunittype from eas_tcp_implmodulecourse a where exists(select * from t1 where courseid=a.courseid) and examunittype='1' )
select * from t2  

) b
on (a.tcpcode=b.tcpcode and a.orgcode=b.segmentcode)
when not matched then 
insert (orgcode,tcpcode)
values(b.segmentcode,b.tcpcode)


with t1 as (select column_value as courseid from table(splitstr('03154,01803',',')))
,t2 as (select * from eas_tcp_implmodulecourse a where exists(select * from t1 where courseid=a.courseid) )
select * from t2 where exists(select * from temp_tcplist where tcpcode=t2.tcpcode and orgcode=t2.segmentcode)

-----step 2 save oldrule.txt


select * from eas_tcp_implonrule a where exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.segmentcode)

--- step 3 save oldmrule.txt
select * from eas_tcp_implonmodulerule a where exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.segmentcode)


---step 4: update  
merge into eas_tcp_implmodulecourse a 
using(
with t1 as (select column_value as courseid from table(splitstr('03154,01803',',')))
,t2 as (select segmentcode,tcpcode,sn,courseid,examunittype from eas_tcp_implmodulecourse a where exists(select * from t1 where courseid=a.courseid) and examunittype='1')
select * from t2

) b on (a.sn=b.sn)
when matched then
update set examunittype='2'



---step 5 recompute rule and mrule and compare the different of two files

merge into eas_tcp_implonmodulerule a
using(
with t1 as (
select b.BatchCode , a.SegmentCode ,a.TCPCode ,b.ModuleCode ,b.CourseID ,b.CourseNature ,b.ExamUnitType,b.Credit    from
  (select distinct TCPCode ,a.orgcode SegmentCode  from EAS_TCP_Implementation a )  a
 inner join EAS_TCP_ModuleCourses b on a.TCPCode =b.TCPCode where b.CourseNature ='1'
 and exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.segmentcode ))
 ,t2 as (
 select b.BatchCode , b.SegmentCode ,b.TCPCode ,b.ModuleCode ,b.CourseID ,b.CourseNature,b.ExamUnitType ,b.Credit   from EAS_TCP_ImplModuleCourse  
   b where exists(select * from temp_tcplist where tcpcode=b.tcpcode and orgcode=b.segmentcode))
  
,t3 as (
select * from t1
 union all 
 select * from t2)
  
select  BatchCode ,SegmentCode ,TCPCode ,modulecode
,SUM(case when examunittype=1 then Credit else 0 end) s0
,SUM(Credit ) s1 
,SUM(case when CourseNature=2 and examunittype=2 then Credit else 0 end) s2
  ,SUM(case when CourseNature=2 and examunittype=1 then Credit else 0 end) s3
   from t3
 group by batchcode,segmentcode,tcpcode,ModuleCode 
 union 
 
 select a.BatchCode ,b.orgcode SegmentCode ,a.TCPCode ,a.modulecode,0,0,0,0  from eas_tcp_module a inner join temp_tcplist b on a.tcpcode=b.tcpcode  
 where  
  not exists(select * from t3 where tcpcode=a.tcpcode and modulecode=a.modulecode)
  ) b on (A.BATCHCODE=b.batchcode and a.tcpcode=b.tcpcode and a.modulecode=b.modulecode and a.segmentcode=b.segmentcode)
  when matched then
  update set RequiredTotalCredits=s0,
             moduleTotalCredits =s1,
             SCSegmentTotalCredits=s2,
             SCCenterTotalCredits=s3
   when not matched then
      insert  ( SN
    ,BatchCode,TCPCode
    ,SegmentCode
    ,ModuleCode,RequiredTotalCredits,ModuleTotalCredits,SCSegmentTotalCredits,SCCenterTotalCredits)
    values(
    seq_TCP_ImplModuRule.nextVal
    ,b.BatchCode,b.TCPCode
    ,b.SegmentCode
    ,b.ModuleCode,b.s0,b.s1,b.s2,b.s3);          
              
             

 ----------------step6: recompute eas_tcp_implonrule
 merge into eas_tcp_implonrule a 
 using(
 with t1 as (
select b.BatchCode , a.SegmentCode ,a.TCPCode ,b.ModuleCode ,b.CourseID ,b.CourseNature ,b.ExamUnitType,b.Credit    from
  (select distinct TCPCode ,a.orgcode SegmentCode  from EAS_TCP_Implementation a )  a
 inner join EAS_TCP_ModuleCourses b on a.TCPCode =b.TCPCode where b.CourseNature ='1'
 and exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.segmentcode ))
 ,t2 as (
 select b.BatchCode , b.SegmentCode ,b.TCPCode ,b.ModuleCode ,b.CourseID ,b.CourseNature,b.ExamUnitType ,b.Credit   from EAS_TCP_ImplModuleCourse  
   b where exists(select * from temp_tcplist where tcpcode=b.tcpcode and orgcode=b.segmentcode))
,t3 as (
select * from t1
 union all 
 select * from t2)

select  BatchCode ,SegmentCode ,TCPCode
 ,SUM(Credit ) s1
 ,SUM(case when examunittype=1 then Credit else 0 end) s2
   from t3
 group by batchcode,segmentcode,tcpcode
 ) b on( A.BATCHCODE=b.batchcode and a.tcpcode=b.tcpcode and a.segmentcode=b.segmentcode)
 when matched then
 update  set moduletotalcredits=s1
             ,totalcredits=s2
  when not matched then
            insert (SN
        ,Batchcode,TCPCode
        ,ModuleTotalCredits,TotalCredits
        ,SegmentCode)
        values(seq_TCP_ImplOnRule.nextval
     ,B.BATCHCODE ,B.TCPCODE
     ,b.s1 ,b.s2
     ,b.SEGMENTCODE);
     
 -----step 7 save rule.txt


select * from eas_tcp_implonrule a where exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.segmentcode)

--- step 8 save oldmrule.txt
select * from eas_tcp_implonmodulerule a where exists(select * from temp_tcplist where tcpcode=a.tcpcode and orgcode=a.segmentcode)

-----
