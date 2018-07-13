set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

set va1= " select 1 refid ,a.Zdnd +a.Zdxq  as batchcode,rtrim(replace(a.Hzgxdm,' ','')) as collegeid,rtrim(a.Zydm) as spycode,isnull(rtrim(a.Bxkpjf),'0') as RCA ,replace(a.Bxkzdf,' ','0')  as RCLS,replace(a.Xxkpjf,' ','0') as EAS,replace(isnull(a.Xxkzdf,0),' ','0') as ELS,replace(a.Lwcj,' ','') as PaperGrade,replace(a.Bxkbl,' ','') as byProporton ,replace(a.Bxkblfz,' ','') as ScalledScore,replace(REPLACE(bz, CHAR(13) + CHAR(10), ''),',',' ') as remark from %lv1%..xwshgzb a  order by a.Hzgxdm ,a.Zdnd ,a.Zdxq   "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

