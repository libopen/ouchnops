rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select NEWID() as sn, a.batchcode ,     a.TCPCode,LEFT(a.xxdm,3) as SegmentCode ,a.xxdm as LearningCenterCode     ,d.Mkh as Modulecode,d.Kcid         as courseid,d.Kcxzdm     as courseNature,d.Ksdwlxdm as ExamUnitType ,d.Xf as Credit     ,null as [hour],d.Ksxq     as SuggestOpenSemester,d.Ksxq as planOpenSemester,0 as isDegreeCourse,0     as isSimilar     ,a.nd +'-'+a.xqdm +'-01' as Createtime             from                             (select distinct b.Xxdm,LEFT(b.xxdm,3) as segmentcode, a.nd,a.xqdm,     RIGHT(a.nd,2)+ltrim(a.Xqdm)+ltrim(right(a.gzh,11)) as tcpcode ,a.Gzh ,a.nd+ltrim(a.Xqdm) batchcode,right(LEFT(a.gzh,6),2) as xslxdm,RIGHT(left(a.gzh,7),1) zyccdm,RIGHT(a.gzh,8) as zydm from %lv1%..zygzsyndb a inner join %lv1%..xsb b on a.Gzh=b.Gzh and b.Zygznd=a.Nd and b.Zygzxq=a.Xqdm     ) a      inner join %lv1%..mkkcb d on a.Gzh =d.Gzh inner join    %lv1%..kczb e on e.kcid=d.kcid   where d.kcxzdm in('3') and d .kczt='0' "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

