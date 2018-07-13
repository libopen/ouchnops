delete BKCOURSE_BASICINFO  where courseid='04000';

MERGE INTO eas_COURSE_BASICINFO A 
using  BKCOURSE_BASICINFO B
ON (A.SN = B.SN)
WHEN NOT MATCHED THEN 
INSERT (
  SN, COURSEID, COURSENAME, ABBREVIATION, MNEMONIC, 
  COURSELEVEL, COURSETYPE, ORGCODE, DEPARTMENT, TEACHER, 
  CREDIT, HOURTYPE, HOUR, SUBJECT, CATEGORIES, 
  STATE, APPLICATIONTIME, AUDITTIME, CREATETIME, MODIFYOPERATOR, 
  MODIFYDATETIME, ISVALIDCREDIT)
VALUES (
  B.SN, B.COURSEID, B.COURSENAME, B.ABBREVIATION, B.MNEMONIC, 
  B.COURSELEVEL, B.COURSETYPE, B.ORGCODE, B.DEPARTMENT, B.TEACHER, 
  B.CREDIT, B.HOURTYPE, B.HOUR, B.SUBJECT, B.CATEGORIES, 
  B.STATE, B.APPLICATIONTIME, B.AUDITTIME, B.CREATETIME, B.MODIFYOPERATOR, 
  B.MODIFYDATETIME, B.ISVALIDCREDIT);
  
  
  
MERGE INTO eas_COURSE_BASICINFO A 
using  BKCOURSE_BASICINFO B
ON (A.courseid = B.courseid )
WHEN MATCHED THEN 
update set state=b.state
where a.state<>b.state


COMMIT;