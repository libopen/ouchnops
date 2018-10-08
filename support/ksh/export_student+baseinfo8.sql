SELECT 
   a.STUDENTcode,a.fullname,BATCHCODE
   , b.birthdate 
   ,b.idcard,c.dicname as xb
   ,d.dicname as mz,b.ethnic
    
   
FROM OUCHNSYS.EAS_SCHROLL_STUDENT a
inner join eas_schroll_studentbasicinfo  b
on a.studentcode=b.studentcode
left join eas_dic_gender c on b.gender=c.diccode
left join eas_dic_ethnicname d on b.ethnic=d.diccode
 
where a.batchcode in ('201809','201803')