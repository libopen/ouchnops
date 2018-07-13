rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select NEWID() as SN,b.batchcode ,b.TCPCode, b.orgCode,a.Mkh as ModuleCode     ,a.Kcid as CourseID,a.Kcxzdm     as CourseNature,a.Kcxzdm     as ModifiedCourseNature, a.ksdwlxdm as ExamUnitType,     a.ksdwlxdm as ModifiedExamUnitType     ,a.Xf as Credit ,null as hour,0 as IsDegreeCourse ,0 as IsExecutiveCourse ,0 as IsExtendedCourse             ,0 as     isSimilarl ,null as ExtendedSource, b.Nd+'-'+b.Xqdm+'-01' as CreateTime                     from %lv1%..mkkcb a                     inner join         (select distinct     a.nd,a.xqdm,'1' qybz, RIGHT(a.nd,2)+ltrim(a.Xqdm)+ltrim(right(a.gzh,11)) as tcpcode ,a.Gzh ,a.nd+ltrim(a.Xqdm) batchcode,right(LEFT(a.gzh,6),2) as xslxdm,RIGHT(left(a.gzh,7),1) zyccdm,RIGHT(a.gzh,8) as zydm ,(select rtrim(xxdm) from %lv1%..xxdmb where LEN(xxdm)=3 and xxdm<>'010'     ) as Orgcode from %lv1%..zygzsyndb a)     b on a.Gzh =b.Gzh                             inner join                     %lv1%..kczb d on a.kcid=d.kcid                     where a.kcxzdm in('2','3') and a .kczt='0'      "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

