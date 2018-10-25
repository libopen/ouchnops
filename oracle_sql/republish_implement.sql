---/320,90*,511,321,330,805/
declare 
 l_tcpCode EAS_TCP_IMPLEMENTATION.TCPCODE %type;
 l_OrgCode EAS_TCP_IMPLEMENTATION.ORGCODE %type;
 l_learningcentercode EAS_TCP_EXECUTION.learningcentercode %type; 
begin
--select * from 
for v_r in (
 select distinct learningcentercode ,tcpcode,substr(learningcentercode,1,3) orgcode from eas_schroll_student a where batchcode='201809' ---check
and substr(a.learningcentercode,1,3)='805' and not exists(select * from eas_tcp_execution                 ---check
where learningcentercode=a.learningcentercode and tcpcode=a.tcpcode)
and exists(select * from eas_tcp_implementation where orgcode=substr(a.learningcentercode,1,3) and tcpcode=a.tcpcode and impstate='1')
--and tcpcode='180901411020102' and learningcentercode='3200901'
)
loop
 l_tcpCode := v_r.tcpcode;
 l_Orgcode := v_r.orgcode;
 l_learningcentercode := v_r.learningcentercode;
 DBMS_OUTPUT.PUT_LINE(l_learningcentercode || '--' || l_tcpcode);
    
    insert into Eas_tcp_execution(
                 BATCHCODE,SEGMENTCODE,TCPCODE
                ,MINGRADCREDITS,MINEXAMCREDITS,EXEMPTIONMAXCREDITS
                ,EDUCATIONTYPE,STUDENTTYPE,PROFESSIONALLEVEL,SPYCODE
                ,SCHOOLSYSTEM,DEGREECOLLEGEID,degreeSemester
                ,learningcentercode
                ,SN,ExcState,CreateTime,EasDegSN)
           select  A.BATCHCODE ,A.ORGCODE ,A.TCPCODE
           ,A.MINGRADCREDITS ,A.MINEXAMCREDITS ,A.EXEMPTIONMAXCREDITS
           ,A.EDUCATIONTYPE ,A.STUDENTTYPE ,A.PROFESSIONALLEVEL ,A.SPYCODE
           ,A.SCHOOLSYSTEM ,A.DEGREECOLLEGEID ,A.DEGREESEMESTER
           ,B.LEARNINGCENTERORGCODE
           ,sys_guid() as SN,'0' as  ExcState ,sysdate as  CreateTime,A.EasDegSN
           from EAS_TCP_IMPLEMENTATION a
           inner join EAS_SPY_OpenSpyLearningCenter b on A.ORGCODE =B.SEGMENTORGCODE and A.STUDENTTYPE =B.STUDENTTYPE and A.PROFESSIONALLEVEL =B.PROFESSIONALLEVEL
           and A.SPYCODE =B.SPYCODE and B.OPENSTATE ='1'
           where a.tcpcode=l_tcpCode and orgcode=l_OrgCode and b.LEARNINGCENTERORGCODE=l_learningcentercode
           and not exists(select * from Eas_tcp_execution where tcpcode=l_tcpCode and LEARNINGCENTERCODE=B.LEARNINGCENTERORGCODE);
           dbms_output.put_line('add: Eas_tcp_execution:' ||  SQL%ROWCOUNT);

      /* /* 执行规则e : EAS_TCP_ExecModuleCourse */
               -------
      insert into EAS_TCP_ExecModuleCourse(sn,batchcode,tcpcode,segmentcode,learningcentercode,modulecode,courseid,coursenature,examunittype,credit,hour,suggestopensemester,planopensemester,isdegreecourse,issimilar,createtime)
      with t1 as ( select a.tcpcode,b.learningcenterOrgcode  as  learningcentercode,A.ORGCODE as segmentcode  from EAS_TCP_IMPLEMENTATION a 
                    inner join EAS_SPY_OpenSpyLearningCenter b on
                A.ORGCODE =B.SEGMENTORGCODE and A.STUDENTTYPE =B.STUDENTTYPE and A.PROFESSIONALLEVEL =B.PROFESSIONALLEVEL and A.SPYCODE =B.SPYCODE
                where B.OPENSTATE ='1' and A.TCPCODE =l_tcpCode and A.ORGCODE =l_OrgCode  and b.learningcenterorgcode=l_learningcentercode)
       ,t2 as (select sys_guid() sn, A.BATCHCODE ,A.TCPCODE ,A.SEGMENTCODE ,t1.learningcentercode,A.MODULECODE ,A.COURSEID ,A.COURSENATURE ,A.EXAMUNITTYPE ,A.CREDIT ,A.HOUR,C.OPENEDSEMESTER as suggestopensemester,C.OPENEDSEMESTER as planopensemester  ,a.ISDEGREECOURSE,A.ISSIMILARI,sysdate as createtime
                   from EAS_TCP_implModuleCourse a inner join t1 on a.tcpcode=t1.tcpcode and A.SEGMENTCODE =t1.segmentcode
                   inner join eas_tcp_modulecourses c on A.TCPCODE =C.TCPCODE and A.COURSEID =C.COURSEID and A.MODULECODE =C.MODULECODE
                   where  A.COURSENATURE ='3' and  (A.ISEXECUTIVECOURSE =1 or A.ISDEGREECOURSE =1))
            select * from t2
            where not exists(select sn,batchcode,tcpcode,segmentcode,learningcentercode,modulecode,courseid,coursenature,examunittype,credit,hour,suggestopensemester,planopensemester,isdegreecourse,issimilar,createtime
             from EAS_TCP_ExecModuleCourse where learningcentercode=t2.learningcentercode and tcpcode=t2.tcpcode and courseid=t2.courseid);

          dbms_output.put_line('add :EAS_TCP_ExecModuleCourse:' ||  SQL%ROWCOUNT);
          
          
                     /* EAS_TCP_ExecOnRule */
            --模块总学分11. 总部必修+ 12 分部必修（分部必修总部考试+分部必修分部考试）+13 分部选修的执行课
         --总部考试  21 总部必修总部考试+22分部必修总部考试+23选修总部考试
         --避免出现null+12+3=null情况,对sum后的结果使用nvl(,0)
            insert into EAS_TCP_ExecOnRule(
              BatchCode,SegmentCode,TCPCode
              ,LearningCenterCode
              ,ModuleTotalCredits,TotalCredits
              ,SN)
             select A.BATCHCODE ,A.ORGCODE ,A.TCPCODE
              ,B.LEARNINGCENTERORGCODE
              ,nvl(c1.c11,0)+nvl(c2.c12,0)+nvl(c3.c13,0) ,nvl(c1.c21,0)+nvl(c2.c22,0)+nvl(c3.c23,0)
              ,seq_TCP_ExecOnRule.nextval
               from EAS_TCP_IMPLEMENTATION a
               inner join EAS_SPY_OpenSpyLearningCenter b on A.ORGCODE =B.SEGMENTORGCODE and A.STUDENTTYPE =B.STUDENTTYPE and A.PROFESSIONALLEVEL =B.PROFESSIONALLEVEL
               and A.SPYCODE =B.SPYCODE and B.OPENSTATE ='1'  and b.learningcenterorgcode=l_learningcentercode
               left join  -- 指导性必修
               (
                select   tcpcode,sum(a.CenterCompulsoryCourseCredit) as c11 ,sum(CenterCompulsoryCourseCredit) as c21
            from EAS_TCP_GuidanceOnModuleRule A where tcpcode=l_tcpCode  group by tcpcode) c1
            on a.tcpcode=c1.tcpcode
                left join (
                select   tcpcode,sum(a.SCSegmentTotalCredits+a.SCCenterTotalCredits) as c12 ,sum(SCCenterTotalCredits) as c22
            from EAS_TCP_implOnModuleRule A where tcpcode=l_tcpCode and A.SEGMENTCODE =l_OrgCode  group by tcpcode) c2
            on a.tcpcode=c2.tcpcode
               left join   -- 实施性执行
               (select tcpcode
            ,sum(a.credit)  as c13
            ,sum(case when  examunittype='1' then a.credit else 0 end) as c23
            from EAS_TCP_implModuleCourse a where tcpcode=l_tcpCode and A.SEGMENTCODE =l_OrgCode  and (A.ISEXECUTIVECOURSE ='1' or A.ISDEGREECOURSE ='1') and A.COURSENATURE ='3' group by tcpcode) c3
            on a.tcpcode=c3.tcpcode

            where a.tcpcode=l_tcpCode and orgcode=l_OrgCode
            and not exists(select * from EAS_TCP_ExecOnRule where tcpcode=A.TCPCODE and learningcentercode=B.LEARNINGCENTERORGCODE );

            dbms_output.put_line('add Eas_tcp_execOnRule:' ||  SQL%ROWCOUNT);

   /*EAS_TCP_ExecOnModuleRule*/
            ---- 总部考试总学分＝ 指导性模块总部必修总部考试 s11 + 实施性模块分部必修总部考试s12+ 分部选修总部考试的执行课 s13
         ----模块总学分     =   指导性模块总部必修 s21 + 实施性模块分部必修s22+ 分部选修执行课 s23
         --避免出现null+12+3=null情况,对sum后的结果使用nvl(,0)
            insert into EAS_TCP_ExecOnModuleRule
             (BatchCode,SegmentCode,TCPCode
              ,LearningCenterCode,moduleCode
             , RequiredTotalCredits,ModuleTotalCredits
              ,SN
              )
         with t1 as (select   tcpcode,modulecode,CenterCompulsoryCourseCredit as TotalCredit ,CenterCompulsoryCourseCredit as TotalExamCredit
                from EAS_TCP_GuidanceOnModuleRule A where tcpcode=l_tcpCode )
       , t2 as (   select   tcpcode,modulecode,a.SCSegmentTotalCredits+a.SCCenterTotalCredits as TotalCredit ,SCCenterTotalCredits as TotalExamCredit
            from EAS_TCP_implOnModuleRule A where tcpcode=l_tcpCode and A.SEGMENTCODE =l_OrgCode   )
        ,t3 as ( select a.LearningCenterCode,a.tcpcode,modulecode
            ,sum(a.credit)  as TotalCredit
            ,sum(case when  examunittype='1' then a.credit else 0 end) as TotalExamCredit

            from EAS_TCP_ExecModuleCourse a where tcpcode=l_tcpCode and A.SEGMENTCODE =l_OrgCode 
            and a.LearningCenterCode=l_learningcentercode
            group by a.LearningCenterCode,a.tcpcode,modulecode  )
        ,t4 as ( select A.BATCHCODE ,A.ORGCODE ,A.TCPCODE ,B.LEARNINGCENTERORGCODE
                 from EAS_TCP_IMPLEMENTATION a
               inner join EAS_SPY_OpenSpyLearningCenter b on A.ORGCODE =B.SEGMENTORGCODE and A.STUDENTTYPE =B.STUDENTTYPE and A.PROFESSIONALLEVEL =B.PROFESSIONALLEVEL
               and A.SPYCODE =B.SPYCODE where  B.OPENSTATE ='1' and a.tcpcode=l_tcpCode and a.ORGCODE=l_OrgCode
               and b.learningcenterorgcode=l_learningcentercode
               )
       select t4.batchcode,t4.orgcode,t4.tcpcode
       ,t4.LEARNINGCENTERORGCODE,t1.modulecode
       ,nvl(t1.TotalExamCredit,0)+nvl(t2.TotalExamCredit,0)+nvl(t3.TotalExamCredit,0) as RequiredTotalCredits
       ,nvl(t1.totalcredit,0)+nvl(t2.totalcredit,0)+nvl(t3.totalCredit,0) as ModuleTotalCredits
       ,seq_TCP_execOnModuRule.nextval
       from t4 left join t1 on t4.tcpcode=t1.tcpcode   left join t2 on t1.tcpcode=t2.tcpcode and t1.modulecode=t2.modulecode
       left join t3 on t1.tcpcode=t3.tcpcode and t1.modulecode=t3.modulecode and t4.LearningCenterorgCode=t3.LearningCenterCode
       where not exists(select * from EAS_TCP_ExecOnModuleRule where tcpcode=t4.TCPCODE and modulecode=t1.MODULECODE and learningcentercode=t4.LEARNINGCENTERORGCODE );

            dbms_output.put_line('add EAS_TCP_ExecOnModuleRule:' ||  SQL%ROWCOUNT);
 
end loop;
end;
