-----elc
select count(*) from eas_elc_studentelcinfotemp;


MERGE INTO OUCHNSYS.EAS_ELC_STUDENTELCINFO330 A USING ---checked
 EAS_ELC_STUDENTELCINFOtemp B
ON (A.BATCHCODE = B.BATCHCODE and a.STUDENTCODE=b.STUDENTCODE and a.COURSEID=b.COURSEID and a.LEARNINGCENTERCODE=b.LEARNINGCENTERCODE)
WHEN NOT MATCHED THEN 
INSERT (
  REFID, SN, BATCHCODE, STUDENTCODE, COURSEID, 
  LEARNINGCENTERCODE, CLASSCODE, ISPLAN, OPERATOR, ELCSTATE, 
  OPERATETIME, CONFIRMOPERATOR, CONFIRMSTATE, CONFIRMTIME, CURRENTSELECTNUMBER, 
  SPYCODE, ISAPPLYEXAM, ELCTYPE, STUDENTID, ISCONVERSION, 
  SOUR)
VALUES (
---checked
  SEQ_ELC_STUDENTELC330.nextval, B.SN, B.BATCHCODE, B.STUDENTCODE, B.COURSEID, 
  B.LEARNINGCENTERCODE, B.CLASSCODE, B.ISPLAN, 'libin20180403', B.ELCSTATE, 
  to_date('20180403','yyyy-mm-dd'), B.CONFIRMOPERATOR, B.CONFIRMSTATE, B.CONFIRMTIME, B.CURRENTSELECTNUMBER, 
  B.SPYCODE, B.ISAPPLYEXAM, B.ELCTYPE, B.STUDENTID, B.ISCONVERSION, 
  B.SOUR)
  where B.LEARNINGCENTERCODE like '330%'; ---checked

--12765 rows merged.

COMMIT;


-----signup

merge into eas_exmm_signuptemp a 
using eas_course_basicinfo b on (a.courseid=b.courseid)
when matched then
update set coursename=b.coursename,assessmode='12';
commit;

MERGE INTO OUCHNSYS.EAS_EXMM_SIGNUP330 A USING ---checked
EAS_EXMM_SIGNUPTEMP B
ON (A.EXAMPLANCODE = B.EXAMPLANCODE and a.EXAMCATEGORYCODE=b.EXAMCATEGORYCODE and a.EXAMPAPERCODE=b.EXAMPAPERCODE and a.courseid=b.courseid and a.studentcode=b.studentcode )
WHEN NOT MATCHED THEN 
INSERT (
  SN, EXAMBATCHCODE, EXAMPLANCODE, EXAMCATEGORYCODE, ASSESSMODE, 
  EXAMSITECODE, EXAMSESSIONUNIT, EXAMPAPERCODE, EXAMPAPERMEMO, COURSEID, 
  COURSENAME, TCPCODE, SEGMENTCODE, COLLEGECODE, LEARNINGCENTERCODE, 
  CLASSCODE, STUDENTCODE, EXAMUNIT, APPLICANT, APPLICATDATE, 
  SIGNUPTYPE, ISCONFIRM, CONFIRMREASON, CONFIRMER, CONFIRMDATE, 
  FEECERTIFICATE, ELC_REFID)
VALUES (
  SEQ_EXMM_SIGNUP330.nextval, B.EXAMBATCHCODE, B.EXAMPLANCODE, B.EXAMCATEGORYCODE, B.ASSESSMODE, ---checked
  B.EXAMSITECODE, B.EXAMSESSIONUNIT, B.EXAMPAPERCODE, B.EXAMPAPERMEMO, B.COURSEID, 
  B.COURSENAME, B.TCPCODE, B.SEGMENTCODE, B.COLLEGECODE, B.LEARNINGCENTERCODE, 
  B.CLASSCODE, B.STUDENTCODE, B.EXAMUNIT, 'libin20180403',to_date('20180403','yyyymmdd'), 
  1, B.ISCONFIRM, B.CONFIRMREASON, 'libin20180403', to_date('20180403','yyyymmdd'), 
  B.FEECERTIFICATE, B.ELC_REFID)
where b.SEGMENTCODE='330';  ---checked

COMMIT;


----composescore

MERGE INTO OUCHNSYS.EAS_EXMM_COMPOSESCORE330 A USING ---checked
 EAS_EXMM_COMPOSESCORETEMP B
ON (A.EXAMPLANCODE = B.EXAMPLANCODE and a.EXAMCATEGORYCODE=b.EXAMCATEGORYCODE and a.COURSEID=b.COURSEID and a.EXAMPAPERCODE=b.EXAMPAPERCODE and a.studentcode=b.studentcode)
WHEN NOT MATCHED THEN 
INSERT (
  SN, EXAMPLANCODE, EXAMCATEGORYCODE, EXAMUNIT, COURSEID, 
  EXAMPAPERCODE, SEGMENTCODE, COLLEGECODE, LEARNINGCENTERCODE, CLASSCODE, 
  STUDENTCODE, PAPERSCORE, PAPERSCORECODE, PAPERSCALE, XKSCORE, 
  XKSCORECODE, XKSCALE, MIDTERMSCORE, MIDTERMSCORECODE, MIDTERMSCALE, 
  COMPOSESCORE, COMPOSESCORECODE, COMPOSEDATE, ASSESSMODE, ISCOMPLEX, 
  NUMSIGNUP, ISPUBLISH, PUBLISHDATE, SIGN_SN, PAPER_SN, 
  XKS_SN, XKP_SN)
VALUES (
  SEQ_EXMM_STUDENTSCORE330.nextval, B.EXAMPLANCODE, B.EXAMCATEGORYCODE, B.EXAMUNIT, B.COURSEID,  ---checked
  B.EXAMPAPERCODE, B.SEGMENTCODE, B.COLLEGECODE, B.LEARNINGCENTERCODE, B.CLASSCODE, 
  B.STUDENTCODE, B.PAPERSCORE, B.PAPERSCORECODE, B.PAPERSCALE, B.XKSCORE, 
  B.XKSCORECODE, B.XKSCALE, B.MIDTERMSCORE, B.MIDTERMSCORECODE, B.MIDTERMSCALE, 
  B.COMPOSESCORE, B.COMPOSESCORECODE, to_date('20180403','yyyymmdd'), B.ASSESSMODE, B.ISCOMPLEX, 
  B.NUMSIGNUP, B.ISPUBLISH, to_date('20180403','yyyymmdd'), B.SIGN_SN, B.PAPER_SN, 
  B.XKS_SN, B.XKP_SN)
  where b.learningcentercode like '330%'; ---checked


COMMIT;



merge into eas_elc_studentstudystatus a 
using (with t1 as (select studentcode,courseid,max(composescore) as score from EAS_EXMM_COMPOSESCORE330 group by studentcode,courseid) ---checked
,t2 as (select max(b.sn) as sn
 from t1 inner join  EAS_EXMM_COMPOSESCORE330 b on t1.studentcode=b.studentcode and t1.courseid=b.courseid and t1.score=b.composescore  ---checked
 group by t1.studentcode,t1.courseid)
select b.sn, b.studentcode,b.courseid,b.composescore as score,b.composescorecode as scorecode,b.examunit as scoretype
,case when b.composescore>59 then 4 else 2 end studystatus,'330' as segmentcode,to_date('20180403','yyyymmdd') as operatedate from t2    ---checked
inner join  EAS_EXMM_COMPOSESCORE330 b on t2.sn=b.sn where exists(select * from eas_exmm_composescoretemp                                ---checked
where b.studentcode=studentcode and b.courseid=courseid)) b 
on (A.COURSEID =b.courseid and A.STUDENTCODE =b.studentcode)
when not matched then
insert  (sn,studentcode,courseid,score,scorecode,studystatus,scoretype,sour)
values(seq_elc_studentstudystatus.nextval,b.studentcode,b.courseid,b.score,b.scorecode,b.studystatus,b.scoretype,'20180403n')
when matched then
update set score=b.score,scorecode=b.scorecode ,scoretype=b.scoretype,studystatus=b.studystatus,sour='20180403m'
where b.score<>nvl(a.score,-1) and nvl(a.scoretype,'1') not in ('3','4','5','6');

commit;

merge into eas_elc_studentstudystatus  a
using(
select studentcode,courseid,learningcentercode,ELCTYPE from eas_elc_studentelcinfotemp a where not exists(select * from  eas_elc_studentstudystatus 
where studentcode=a.studentcode and courseid=a.courseid)) b on (a.studentcode=b.studentcode and a.courseid=b.courseid)
when not matched then
insert  (sn,studentcode,courseid,score,scorecode,studystatus,scoretype,sour)
values(seq_elc_studentstudystatus.nextval,b.studentcode,b.courseid,null,null,1,null,'20180403n')