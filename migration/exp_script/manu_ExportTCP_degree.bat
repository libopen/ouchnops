set lv2=cps1
set dbip=10.96.142.103
set dbuser=sa
set dbpwd=abc123
set expPath=d:\

rem ##temp1 先在原数据库执行角本 学位.sql
set va1=" select * from ##DR  "
set va2=%expPath%EAS_TCP_DegreeRule.csv
bcp %va1%  queryout %va2% -c -t, -r\n    -S%dbip% -U%dbuser% -P%dbpwd%

set va1=" select 1 as sn, b.collegeid  as collegeid,b.refid,b.batchcode ,a.Yyspdm ,a.Zdcj ,null as createtime  from %lv2%..xwshyygzb a inner join ##DR b on a.Hzgxdm =b.collegeid and a.Zdnd +a.Zdxq =b.batchcode and a.Zydm =b.spycode" 
set va2=%expPath%EAS_TCP_DegreeEnglish.csv
bcp %va1%  queryout %va2%. -c -t, -r\n   -S%dbip% -U%dbuser% -P%dbpwd%

set va1="select 1 as sn, b.collegeid  as collegeid,b.refid,b.batchcode ,a.Cs ,replace(a.Cfgdqkdm,' ','') ,null as createtime  from %lv2%..xwshcfgzb a inner join ##DR b on a.Hzgxdm =b.collegeid and a.Zdnd +a.Zdxq =b.batchcode and a.Zydm =b.spycode  "
set va2=%expPath%EAS_TCP_PenaltyRule.csv
bcp %va1%  queryout %va2%. -c -t, -r\n   -S%dbip% -U%dbuser% -P%dbpwd%

set va1="select 1 as sn, b.refid,b.batchcode ,b.collegeid  as collegeid, a.Kcid ,case when c.Xf=null then d.Xf else c.Xf end , replace(c.Kcmc ,',',''),a.ksdwlxdm,a.Zdcj, null as createtime  from %lv2%..xwkcb a inner join ##DR b on a.Hzgxdm =b.collegeid and a.Zdnd +a.Zdxq =b.batchcode and a.Zydm =b.spycode left join %lv2%..kczb c on a.Kcid =c.Kcid   left join %lv2%..shkmb d on a.Kcid =d.Kmdm   where c.Xf is not null  order by c.Kcid   "
set va2=%expPath%EAS_TCP_DegreeCurriculums.csv
bcp %va1%  queryout %va2%. -c -t, -r\n   -S%dbip% -U%dbuser% -P%dbpwd%
