declare 
 l_tcpCode EAS_TCP_IMPLEMENTATION.TCPCODE %type;
 l_OrgCode EAS_TCP_IMPLEMENTATION.ORGCODE %type;
begin

for v_r in (
  select column_value as tcpcode,'511' as orgcode from table(splitstr
('180901210080100',',')) where exists(select * from eas_tcp_guidance where tcpcode= column_value and state='1')
--and tcpcode='180901411020102' 
)
loop
 l_tcpCode := v_r.tcpcode;
 l_Orgcode := v_r.orgcode;
  DBMS_OUTPUT.PUT_LINE(l_Orgcode || '--' || l_tcpcode);
   merge into EAS_TCP_Implementation a
     using(
   
   select sys_guid() SN,'0' as ImpState,sysdate as CreateTime
                 ,B.BATCHCODE ,B.TCPCODE ,B.MINGRADCREDITS ,B.SCHOOLSYSTEM
                 ,B.MINEXAMCREDITS ,B.EXEMPTIONMAXCREDITS ,B.EDUCATIONTYPE ,B.DEGREECOLLEGEID ,B.DEGREESEMESTER
                 ,A.SEGMENTCODE orgcode,A.STUDENTTYPE ,A.PROFESSIONALLEVEL ,A.SPYCODE,B.EasDegSN
      from EAS_Spy_OpenSpySegment a inner join EAS_TCP_GUIDANCE b 
      on A.SPYCODE =B.SPYCODE and A.STUDENTTYPE =B.STUDENTTYPE and A.PROFESSIONALLEVEL =B.PROFESSIONALLEVEL
      where A.OPENSTATE ='1' and  a.segmentcode=l_orgcode
      and b.tcpcode=l_tcpcode
      ) b on (a.orgcode=b.orgcode and a.tcpcode=b.tcpcode)
    when not matched then
     INSERT 
     (
      SN,ImpState,CreateTime
      ,BatchCode, TCPCode, MinGradCredits  ,SchoolSystem
      ,MinExamCredits,ExemptionMaxCredits,EducationType,DegreeCollegeID,DegreeSemester
      ,OrgCode ,StudentType,ProfessionalLevel,SpyCode,EasDegSN
     )
     values(b.SN,b.ImpState,b.CreateTime
      ,b.BatchCode,b. TCPCode,b. MinGradCredits  ,b.SchoolSystem
      ,b.MinExamCredits,b.ExemptionMaxCredits,b.EducationType,b.DegreeCollegeID,b.DegreeSemester
      ,b.OrgCode ,b.StudentType,b.ProfessionalLevel,b.SpyCode,b.EasDegSN);
      
     dbms_output.put_line('add: EAS_TCP_Implementation:' ||  SQL%ROWCOUNT); 
      
      
    merge into EAS_tcp_implmodulecourse a
       using (
       select   B.BATCHCODE ,B.TCPCODE,C.SEGMENTCODE ,A.MODULECODE ,A.COURSEID ,A.COURSENATURE
         ,A.EXAMUNITTYPE ,A.Credit,A.HOUR ,'1' isdegreecourse
       ,A.ISEXTENDEDCOURSE ,A.ISSIMILAR  from eas_tcp_modulecourses a inner join EAS_TCP_GUIDANCE b on a.tcpcode=b.tcpcode
       inner join EAS_Spy_OpenSpySegment c on B.SPYCODE =C.SPYCODE and B.STUDENTTYPE =C.STUDENTTYPE and B.PROFESSIONALLEVEL =C.PROFESSIONALLEVEL
       where
         C.OPENSTATE ='1' and  a.coursenature<>1 and  c.segmentcode=l_orgcode
         and b.tcpcode=l_tcpcode
         and exists(select * from EAS_TCP_DegreeCurriculums where collegeid=B.DEGREECOLLEGEID and batchcode=B.DegreeSemester and courseid=a.courseid)
        ) b
        on (a.segmentcode=b.segmentcode and a.tcpcode=b.tcpcode and a.modulecode=b.modulecode and a.courseid=b.courseid)
        when not matched then 
        insert  (sn                 ,batchcode     ,tcpcode ,segmentcode ,modulecode     ,courseid,coursenature
      ,modifiedcoursenature,examunittype,credit,hour,isdegreecourse
      ,isExtendedcourse,issimilari,createtime)
      values(sys_guid()              ,b.batchcode     ,b.tcpcode ,b.segmentcode ,b.modulecode   ,b.courseid,b.coursenature
      ,b.coursenature,b.examunittype,b.credit,b.hour,b.isdegreecourse
      ,b.isExtendedcourse,b.issimilar,sysdate);
       
     dbms_output.put_line('add: EAS_tcp_implmodulecourse:' ||  SQL%ROWCOUNT);
       
     merge into EAS_TCP_ImplOnRule a
      using(     
      select 
      B.BATCHCODE ,B.TCPCODE
     ,c.c21 ModuleTotalCredits ,c.c11 TotalCredits
     ,A.SEGMENTCODE
      from EAS_Spy_OpenSpySegment a
      inner join EAS_TCP_GUIDANCE b on A.SPYCODE =B.SPYCODE and A.STUDENTTYPE =B.STUDENTTYPE and A.PROFESSIONALLEVEL =B.PROFESSIONALLEVEL
      left  join (
       select sum(A.CenterCompulsoryCourseCredit+SegmentCompulsoryCourseCredit) as c21,  tcpcode,sum(A.CenterCompulsoryCourseCredit) as c11
            from EAS_TCP_GuidanceOnModuleRule A where a.tcpcode=l_tcpcode group by tcpcode) c  on B.TCPCODE =C.TCPCODE
            where A.OPENSTATE ='1'  and  a.segmentcode=l_orgcode
      and b.tcpcode=l_tcpcode 
      )b on (a.segmentcode=b.segmentcode and a.tcpcode=b.tcpcode)
       when not matched then
            insert (SN
        ,Batchcode,TCPCode
        ,ModuleTotalCredits,TotalCredits
        ,SegmentCode)
        values(seq_TCP_ImplOnRule.nextval
     ,B.BATCHCODE ,B.TCPCODE
     ,b.ModuleTotalCredits ,b.TotalCredits
     ,b.SEGMENTCODE);
     
    dbms_output.put_line('add: EAS_TCP_ImplOnRule:' ||  SQL%ROWCOUNT);  
     --select seq_TCP_ImplModuRule.nextVal from dual
     
     merge into EAS_TCP_ImplOnModuleRule a
     using( 
     select 
    B.BATCHCODE ,B.TCPCODE
    ,A.SEGMENTCODE
    ,C.MODULECODE,C.CENTERCOMPULSORYCOURSECREDIT RequiredTotalCredits ,C.CENTERCOMPULSORYCOURSECREDIT +C.SEGMENTCOMPULSORYCOURSECREDIT ModuleTotalCredits,0 SCSegmentTotalCredits, 0 SCCenterTotalCredits
        from EAS_Spy_OpenSpySegment a
      inner join EAS_TCP_GUIDANCE b on A.SPYCODE =B.SPYCODE and A.STUDENTTYPE =B.STUDENTTYPE and A.PROFESSIONALLEVEL =B.PROFESSIONALLEVEL
      inner join EAS_TCP_GuidanceOnModuleRule c on B.TCPCODE =C.TCPCODE
      where A.OPENSTATE ='1' and  a.segmentcode=l_orgcode
      and b.tcpcode=l_tcpcode 
      
      ) b on (a.tcpcode=b.tcpcode and a.segmentcode=b.segmentcode and a.modulecode=b.modulecode)
      when not matched then
      insert  ( SN
    ,BatchCode,TCPCode
    ,SegmentCode
    ,ModuleCode,RequiredTotalCredits,ModuleTotalCredits,SCSegmentTotalCredits,SCCenterTotalCredits)
    values(
    seq_TCP_ImplModuRule.nextVal
    ,b.BatchCode,b.TCPCode
    ,b.SegmentCode
    ,b.ModuleCode,b.RequiredTotalCredits,b.ModuleTotalCredits,b.SCSegmentTotalCredits,b.SCCenterTotalCredits);
    dbms_output.put_line('add: EAS_TCP_ImplOnModuleRule:' ||  SQL%ROWCOUNT); 
end loop;
end;