rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

 set va1=" select newid() sn,b.Nd +b.Xqdm as batchcode ,b.SegmentCode,b.xxdm as LearningCenterCode,         b.TCPCode ,c.Byxf as MinGradCredits,c.Zyxf     as MinExamCredits,c.Mxmkzgxf as ExemptionMaxCredits,1 as educationType ,c.Xslxdm as StudentType ,c.Zyccdm as ProfessionLevel ,c.Zydm as spycode ,c.Xzdm as schoolSystem,rtrim(d.Hzgxdm) as DegreeCollegeid,d.Zdnd+d.zdxq as degreeSemester ,1 as ExcState,b.Nd +'-'+b.xqdm +'-01' as Createtime ,'imp' as Executor,b.Nd +'-'+b.xqdm +'-01' as ExecuteTime                 from (select distinct b.Xxdm,LEFT(b.xxdm,3) as segmentcode, a.nd,a.xqdm,     RIGHT(a.nd,2)+ltrim(a.Xqdm)+ltrim(right(a.gzh,11)) as tcpcode ,a.Gzh ,a.nd+ltrim(a.Xqdm) batchcode,right(LEFT(a.gzh,6),2) as xslxdm,RIGHT(left(a.gzh,7),1) zyccdm,RIGHT(a.gzh,8) as zydm from %lv1%..zygzsyndb a inner join %lv1%..xsb b on a.Gzh=b.Gzh and b.Zygznd=a.Nd and b.Zygzxq=a.Xqdm ) b                 inner join %lv1%..zygzb c on b.Gzh =c.Gzh                             left join %lv1%..xwshgzb d on c.Xw =d.Sxh               "
 bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

