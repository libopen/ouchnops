import datetime
import redis
import time
from  sqlalchemy import create_engine,MetaData,Table,Column,ForeignKey,func,Integer,String,Sequence,func
from  sqlalchemy.ext.automap import automap_base
from  sqlalchemy.orm import sessionmaker


def getMaxClass(classcode):
                  sql = 'select nvl(max(substr(classcode,length(classcode)-2,3)),0) from eas_org_classinfo  where classcode like :classcode '          
                  result = engine.execute(sql,classcode=classcode+'%')
                  resultnum=0 
                  for row in result:
                         resultnum=int(row[0])+1
                  print(resultnum,classcode)
                  return (3-len(str(resultnum)))*'0'+str(resultnum)
   

def AddNewClass(batchcode,spycode,segmentcode,learningcentercode):
        i=1
        for tcprow in session.query(tcp).filter_by(batchcode=batchcode).\
                                     filter_by(spycode = spycode):
                  scode = batch[2:4]+str(learningcentercode)+tcprow.studenttype+tcprow.professionallevel
                  retclass= session.query(classinfo).filter_by(spycode=tcprow.spycode).\
                                                           filter_by(studentcategory=str(tcprow.studenttype)+str(tcprow.professionallevel)).\
                                                           filter_by(learningcentercode=learningcentercode).\
                                                           filter_by(batchcode=batchcode).first()
                  classname='分部'+str(segmentcode)+':'+batch[2:6]
                  if retclass is None:
                       newclasscode = scode+getMaxClass(scode)
                       print('add new class %s'%(newclasscode,))

                       retspy = session.query(spyinfo).filter_by(spycode=spycode).first()
                       if retspy is not None:
                          classname=classname+retspy.spyname
                          seq=Sequence('org_class_seq')
                          nextid = engine.execute(seq)
                          dt = func.to_date(datetime.datetime.now,'yyyy-mm-dd H:M:S')
                          dt2 ='20'+ time.strftime('%y/%m/%d',time.localtime())
                          #print(nextid)
                          newclass = classinfo(classid=nextid,batchcode=batchcode,learningcentercode=learningcentercode,classcode=newclasscode,classname=classname,studentcategory=str(tcprow.studenttype)+str(tcprow.professionallevel),spycode=spycode,professionallevel=tcprow.professionallevel,examsitecode=learningcentercode,classteacher='',createtime=func.now())
                          session.add(newclass)
                          #session.flush()
                          session.commit()
                          
                  else :
                       classname=retclass.classname
                                            
                  print('classname : %s  '  % (classname,))
  

def AddStudent2redis():
    # this date will into redis and delete his select course
    sql = 'select studentcode from eas_schroll_student where to_number(substr(learningcentercode,1,3))=440 and rownum<20000'
    for row in engine.execute(sql):
        redis.sadd('newstudents',row.studentcode)
    return redis.scard('newstudents')


def CreateNewStudentcode(batchcode,spycode,learningcentercode,totalnumber):
        for tcprow in session.query(tcp).filter_by(batchcode=batchcode).\
                                     filter_by(spycode = spycode):
            #for every tcp and of every learningcenter add totalnumber new items
              codeTemple = batchcode[2:4]+learningcentercode[:3]+tcprow.studenttype+tcprow.professionallevel

              #find class 
              classcode=''
              studentcategory=tcprow.studenttype+tcprow.professionallevel
              curclass= session.query(classinfo).filter_by(batchcode=batchcode).\
                                               filter_by(learningcentercode=learningcentercode).\
                                               filter_by(spycode=spycode).\
                                               filter_by(studentcategory=studentcategory).first()
              if curclass is None:
                  print('%s %s %s class not exists'%(batchcode,learningcentercode,spycode))
              else:
                  #print('classname %s'%(curclass.classname))
                  classcode=curclass.classcode


              for i in range(0,10):
               #if not exists dict.key then add new
                  if codeTemple in hsStudentCode:    
                      stunum=hsStudentCode[codeTemple]+1
                  else:
                      hsStudentCode[codeTemple]=1
                      stunum=1
              
                  hsStudentCode[codeTemple]=stunum
                  newStudentCode=str(codeTemple)+(5-len(str(stunum)))*'0'+str(stunum)
                  #print('tcpTemple %s ,tcpcode: %s learningcentercode %s studentcode:%s'%(codeTemple,tcprow.tcpcode,learningcentercode,newStudentCode))
                  thisstudent=session.query(student).filter_by(studentcode=newStudentCode).first()
                  #  search one by newstudentcode if exists then change this 
                  #  
                  if thisstudent is None: 
                      #print(' %s is not exists'%(newStudentCode,))
                      #find a student from redis
                      oldstudentcode=redis.spop('newstudents')
                      oldstudent=session.query(student).filter_by(studentcode=oldstudentcode.decode('utf-8')).first()
                      if oldstudent is None:
                         print(' %s is not exists'%(oldstudentcode.decode('utf-8'),))
                      else:
                         print('studentcode[%s] is change to new '%(oldstudentcode.decode('utf-8'),))
                         oldstudent.studentcode=newStudentCode
                         oldstudent.batchcode = batchcode
                         oldstudent.tcpcode = tcprow.tcpcode
                         oldstudent.learningcentercode=learningcentercode
                         oldstudent.classcode=classcode
                         oldstudent.spycode = spycode
                         oldstudent.professionallevel=tcprow.professionallevel
                         oldstudent.studenttype=tcprow.studenttype
                         oldstudent.studentcategory=str(tcprow.studenttype)+str(tcprow.professionallevel)
                         oldstudent.enrollmentstatus='1'
                         oldstudent.createtime=func.now()
                         oldstudentbasic=session.query(studentinfo).filter_by(studentid=oldstudent.studentid).first()
                         if oldstudentbasic is not None:
                            oldstudentbasic.studentcode=newStudentCode
                            oldstudentbasic.createtime=func.now()
                         session.flush()
                         session.commit()
                         
                  else:
                     
                      print('studentcode[%s] is exists'%(thisstudent.studentcode,))
                      studentid = thisstudent.studentid   
                      print('delete elc %s'%(thisstudent.studentcode,))
                      for rowelc in session2.query(studentelc).filter_by(studentcode=thisstudent.studentcode):
                          session2.delete(rowelc)
                          session2.flush()
                      session2.commit()
                      thisstudent.batchcode = batchcode
                      thisstudent.tcpcode = tcprow.tcpcode
                      thisstudent.learningcentercode=learningcentercode
                      thisstudent.classcode=classcode
                      thisstudent.spycode = spycode
                      thisstudent.professionallevel=tcprow.professionallevel
                      thisstudent.studenttype=tcprow.studenttype
                      thisstudent.studentcategory=str(tcprow.studenttype)+str(tcprow.professionallevel)
                      thisstudent.enrollmentstatus='1'
                      thisstudent.createtime=func.now()
                      thisstudentbasic=session.query(studentinfo).filter_by(studentid=studentid).first()
                      if thisstudentbasic is not None:
                         thisstudentbasic.studentcode=thisstudent.studentcode
                         thisstudentbasic.createtime=func.now()
                      session.flush()                     
                      session.commit()
                      
                      
               
    
    

#add class and modify exists data of student to new 
a = datetime.datetime.now()
hsStudentCode={}
redis = redis.Redis(host='10.96.142.109',port=6380,db=1)

engine = create_engine('oracle://ouchnsys:abc123@202.205.161.18:1521/orcl')
tables = ['eas_tcp_guidance','eas_schroll_student','eas_org_classinfo','eas_spy_basicinfo','eas_schroll_studentbasicinfo']
metadata=MetaData()
metadata.reflect(engine,only=tables) 
Base=automap_base(metadata=metadata)
Base.prepare()

engine2 = create_engine('oracle://ouchnsys:abc123@202.205.161.20:1521/orcl')
tables2 = ['eas_elc_studentelcinfo','eas_elc_studentstudystatus']
metadata2=MetaData()
metadata2.reflect(engine2,only=tables2) 
Base2=automap_base(metadata=metadata2)
Base2.prepare()

tcp = Base.classes.eas_tcp_guidance
student= Base.classes.eas_schroll_student
classinfo= Base.classes.eas_org_classinfo
spyinfo=Base.classes.eas_spy_basicinfo
studentinfo=Base.classes.eas_schroll_studentbasicinfo

studentelc=Base2.classes.eas_elc_studentelcinfo
studentstudy=Base2.classes.eas_elc_studentstudystatus

batchlist = ['201309','201403','201409']
spylist =['08060523','08060500','08070308','02010405']
#spylist =['03010113']

DBsession = sessionmaker(bind=engine)
session = DBsession()
DBsession2= sessionmaker(bind=engine2)
session2 = DBsession2()

#AddStudent2redis()
for segcode in range(953,981):
    print ('segcode: %s '%(segcode,))
    for batch in batchlist:
        for spy in spylist:
            DBsession = sessionmaker(bind=engine)
            session = DBsession()
            DBsession2= sessionmaker(bind=engine2)
            session2 = DBsession2()

            # AddNewClass(batch,spy,'912','9100001')
            # for segcode in range(910,981): 
            #AddNewClass(batch,spy,str(segcode),str(segcode)+'0100')
            CreateNewStudentcode(batch,spy,str(segcode)+'0100',10)
            session.close()
            session2.close()
         #pass                       
#session.commit()
#session.close()
b=datetime.datetime.now()
c =b-a
print(divmod(c.days*86400+c.seconds,60))









