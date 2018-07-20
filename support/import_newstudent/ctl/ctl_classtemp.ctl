options(bindsize=65536000,readsize=80000000,rows=10000)
load data
CHARACTERSET ZHS16GBK 
infile *
BADFILE  './eas_org_classinfo_temp.bad'
DISCARDFILE './eas_org_classinfo_temp.dsc'
truncate into table EAS_Org_ClassInfo_temp
fields terminated by ','
trailing nullcols
(
ClassID  "org_class_Seq.nextval",
BatchCode  "TRIM(:BatchCode)",
LearningCenterCode  "TRIM(:LearningCenterCode)",
ClassCode  "TRIM(:ClassCode)",
ClassName  "TRIM(:ClassName)",
StudentCategory  "TRIM(:StudentCategory)",
SpyCode  "TRIM(:SpyCode)",
ProfessionalLevel  "TRIM(:ProfessionalLevel)",
ExamSiteCode  "TRIM(:ExamSiteCode)",
ClassTeacher  "TRIM(:ClassTeacher)",
CreateTime  DATE "yyyy-mm-dd" NULLIF (CreateTime="NULL")
)
begindata
