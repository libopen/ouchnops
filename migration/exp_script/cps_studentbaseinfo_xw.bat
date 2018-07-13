set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

set va1= " select   ltrim(b.Xxdm) +RTRIM(b.Xh) as studentid ,a.Xh StudentCode ,a.Xbdm Gender  ,a.Mzdm  Ethnic ,a.Zzmmdm Politicsstatus ,a.Hyzkdm Maritalstatus ,rtrim(a.Jgdm) HomeTown  , CONVERT(varchar(10),a.Csrq ,120) birghday  ,a.Whcddm  education  ,CONVERT(varchar(10),a.Cjgzsj ,120) workingtime ,a.Hkxzdm hukou ,a.Sfzh idnumber ,rtrim(a.Fbdm) distribution ,a.Xflydm tuition  ,a.Zkzh admissionnumber   ,replace(replace(a.Gzdw ,char(13),'') ,',',';')  workunit ,replace(replace(a.Dwdz ,char(13),'') ,',',';') workaddress ,a.Dwyzbm workzipcode ,replace(replace(a.Dwdh ,char(13),'') ,',',';')   workphone  ,replace(replace(a.Brtxdz ,char(13),'') ,',',';') myaddress  ,replace(a.Bryzbm,CHAR(13),'')  as myzipcode  ,replace(replace(a.Brlxdh ,char(13),'') ,',',';')  as myphone  ,replace(replace(a.Email ,char(13),'') ,',',';') Email  ,a.Byzh deplomanumber ,replace(a.Zyqkdm ,char(13),'') professionalsituation   ,replace(replace(a.yddh ,char(13),'') ,',',';')  mobile  ,a.Zjlxdm ducumenttype ,a.Sfzh idcard ,c.Yzyccdm  originalspylevel ,replace(c.Ylzy,',','-')  originalspy  ,case when isdate(replace(replace(c.Ybysj ,char(13),'') ,'/',''))=0 then null else convert(varchar,cast(replace(replace(c.Ybysj ,char(13),'') ,'/','') as datetime),120) end  as  oriainalgraduatetime  ,replace(c.Ybyxx ,',','') originalgraduateschool  ,null createtime  from %lv1%..xsjbqkb  a inner join %lv1%..xsb b on a.Xh=b.xh left join %lv1%..xsbyb c on a.Xh=c.xh where b.zydm in (select zydm from %lv1%..zydmb where Zymc like '%%工商管理%%' or Zymc like '%%法学%%' or Zymc like '%%汉语言文学%%' or Zymc like '%%计算机科学与技术%%' or Zymc like '%%会计学%%'   ) and b.Zyccdm='2' and b.Xjztdm in ('7','1')   "
bcp %va1%  queryout %lv2% -c -t, -r\n    -S%lv3% -U%lv4% -P%lv5%

