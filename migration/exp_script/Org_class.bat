set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

set va1= " select distinct 1 as classid,a.Nd +a.Xqdm as batchcode,a.Xxdm as LearningcenterCode,a.Bdm as classcode,replace(REPLACE(Bmc,' ',''),',','') as classname ,a.Xslbdm as studentcategory,rtrim(a.Zydm) as spycode,right(LEFT(a.Gzh ,7),1) as professionallevel ,a.Kddm as ExamSiteCode,left(replace(REPLACE(a.Bzr,' ',''),',',''),5) as classteacher,a.Nd +'-'+a.Xqdm+'-01' as CreateTime  from %lv1%..bjxxb a    "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

