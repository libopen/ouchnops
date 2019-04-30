import xlrd
import csv
import os,uuid
import sys ,datetime
from progressbar import printProgress
import pandas as pd
import numpy as np
def newPaperCode(oldCode):
        try:
                if oldCode!='':
                        top2=oldCode[:2]
                        if (top2=='27') or (top2=='49') :
                            return "4{}".format(oldCode)
                        elif int(top2)<20:
                            return "1{}".format(oldCode)
                        elif int(top2)>49:
                            return "5{}".format(oldCode)
                        else:
                            return "2{}".format(oldCode)
        except:
                raise ValueError
                
def getRedis(val,code='utf'):
    if val=='':
        return ('','')
    else :
      key=val
      if type(val)==float:
         key='%d'%val
      elif type(val)==int:
         key='%d'%val
      else:
         if is_number(val):
            key=val.split('.')[0]
            if key=='100':
               key='++'
      #print(key)
      if re.get(key)is None:
         reval=''
      else :
         if code=='utf':
            reval= re.get(key).decode('utf-8')
         else :
            reval= re.get(key).decode('gb2312')
      return (key,reval)

def getstuinfoDic(csvfile='stuinfo.txt'):
    # read student.csv convert to dict
    dict={}
    reader=csv.DictReader(open(csvfile,'r'))
    for line in reader:
        dict[line['STUDENTCODE']]=line
    return dict
def getscoreDic(csvfile='scorecode.txt'):
    # read student.csv convert to dict
    dict={}
    reader=csv.DictReader(open(csvfile,'r'))
    for line in reader:
        dict[line['DICCODE']]=line['DICSCORE']
    return dict

def is_number(s):
        try:
                float(s)
                return True
        except ValueError:
                pass
    
        try:
                import unicodedata
                unicodedata.numeric(s)
                return True
        except (TypeError,ValueError):
                pass
        return False

def removelast(str):
        return str[:-2] if str[-2:]=='.0' else str
 
def expElc(csvname,xlsfile):
       #filename is format that is name such as elc90* or signup90* or score90* 
       #deal with numeric
        studict=getstuinfoDic()
        col_elc=['学号','教学点代码','课程ID','选课年度','选课学期','考试单位类型','选课次数']
        batlist={"秋季":"09","春季":"03","秋":"09","春":"03"}
        examunitlist={"中央":"1","省":"2"}
        rnNum =[0,1,2,3,4,5] # deal \n
        intnum=[11,12,13,14,15,16,17,23,24]
        blknum=[18,19,20,21,22]
    
    
        with open(csvname,'w',newline='',encoding='gb2312') as csvfile:
                wr =  csv.writer(csvfile,quoting=csv.QUOTE_NONE,quotechar='',escapechar='\\')
                wb = xlrd.open_workbook(xlsfile)
                tmpCol2=""
                tmpCol3=""
                tmpCol4=""
                tmpCol5=""
        
        
                for sh in wb.sheets():
                        if sh.nrows==0 :
                                print("{} is empty".format(sh.name))
                                continue
                        # deal with mutilplines
                        # from the second line 
                        # is columns order is current?
                        bColOrder=True
                        rowcollist=sh.row_values(0)
                        for i in range(len(col_elc)):
                                if rowcollist[i] not in str(col_elc[i]).split(','):
                                        bColOrder=False
                                        print ("sheet:{} {}'s number:{} column,{} is not match {}".format(xlsfile,sh.name,i,col_elc[i],rowcollist[i]))
                                        break
                        if bColOrder==False:# if Column's order is not current then break and get next sheet
                                continue
              
                        lins = [x for x in range(1,sh.nrows)]
                        iTotal=0
                        iValid=0
                        for rownum in lins:
                 
                                bvalid=True                
                                csvlist=["1" for x in range(20)]
                                #all conver to string and remove return char and             
                                rowlist =[str(item).replace('\n',' ').replace(',',' ').strip() for item in sh.row_values(rownum)  ]
                                
                                #get info by redis
                                #stuinfo = getRedis(rowlist[0])
                                # find studentcode in studict 
                                if removelast(rowlist[0]) not in studict.keys():
                                        bvalid=False
                                        print("{}:{},{},{}, no find".format(sh.name,rownum,rowlist[0],rowlist[1]))
                                else:
                                        #dic = eval(stuinfo[1])
                                        #print("{},{}".format(rowlist[0],is_number(rowlist[0])))
                                        csvlist[1]="{}{}".format(rowlist[3][:4],batlist[rowlist[4]]) #batchcode
                                        csvlist[2]=removelast(rowlist[0]) #studentcode
                                        csvlist[3]=str(removelast(rowlist[2])).zfill(5)  #courseid                                        
                                        dic=studict[removelast(rowlist[0])]
                                        csvlist[4]=dic['LEARNINGCENTERCODE']#learningcentercode
                                        csvlist[5]=dic['CLASSCODE'] #classcode
                                        csvlist[7]='elximp' #operator
                                        csvlist[9]='' #operatetime
                                        csvlist[10]='elximp' #operator
                                        csvlist[12]='' #comfirmtime
                                        csvlist[13]=removelast(rowlist[6]) #current
                                        csvlist[14]=dic['SPYCODE']
                                        csvlist[17]=dic['STUDENTID']
                                        csvlist[18]=uuid.uuid4()
                                        csvlist[19]='end'
                                       
                                iTotal+=1
                                if bvalid==True:
                                        iValid+=1
                                        wr.writerow(csvlist)
                        print("{}:Totla{},valid{}".format(sh.name,iTotal,iValid))
        csvfile.close()

def score2round(score):
    try:
        if score!='':
            if score[0] in '1234567890':
                return str(int(float(score)+0.5))
            else:
                return removelast(score)
        else:
            return ''
    except:
        print(score)
      
 
def expScore(csvname,xlsfile,papercodetype='4'):
       # get date from score***xls to create composescore
       #filename is format that is name such as elc90* or signup90* or score90* 
       #deal with numeric
        studict=getstuinfoDic()   
        scoredic=getscoreDic()
        col_score=['学号','课程ID','考试代码','考试类别代码','试卷号','试卷成绩代码','形考成绩代码','形考比例','综合成绩代码','教学点代码','考试单位类型','考试次数']
        
        batlist={"秋季":"09","春季":"03"}
        examunitlist={"中央":"1","省":"2","国开":"1","省开":"2"}
        rnNum =[0,1,2,3,4,5] # deal \n
        intnum=[11,12,13,14,15,16,17,23,24]
        blknum=[18,19,20,21,22]
    
    
        with open(csvname,'w',newline='',encoding='gb2312') as csvfile:
                wr =  csv.writer(csvfile,quoting=csv.QUOTE_NONE,quotechar='',escapechar='\\')
                wb = xlrd.open_workbook(xlsfile)
                tmpCol2=""
                tmpCol3=""
                tmpCol4=""
                tmpCol5=""
        
        
                for sh in wb.sheets():
                        if sh.nrows==0:
                                print("{} is empty".format(sh.name))
                                continue # return top to get next sheet
                        # deal with mutilpline
                        # from the second line
                        #begin to process 
                        bColOrder=True
                        rowcollist=sh.row_values(0) #get the column's name from the first row
                        for i in range(len(col_score)):
                                rowcollist[i]=rowcollist[i].replace('\n','')
                                if  rowcollist[i] not in str(col_score[i]).split(','):
                                        bColOrder=False
                                        print ("sheet:{} {}'s number:{} column,{} is not match {}".format(xlsfile,sh.name,i,col_score[i],rowcollist[i]))
                                        break
                        if bColOrder==False:  # if the order of column is not current ,return to get next sheet
                                continue

                        lins = [x for x in range(1,sh.nrows)]
                        iTotal=0
                        iValid=0
                        totalLines=len(lins) # total rows
                        printProgress(0,totalLines,prefix='Process',suffix='Complete',barLength=50)
                        for rownum in lins:
                                #print("rownum:{}".format(rownum))
                                bvalid=True
                                csvlist=["" for x in range(23)]
                                            
                                rowlist =[str(item).replace('\n',' ').replace(',',' ').strip() for item in sh.row_values(rownum)]
                                #print("{},{}".format(rownum,rowlist))
                                # get current student's info dicts
                                if removelast(rowlist[0]) not in studict.keys():
                                        bvalid=False
                                        print("{}:{},{}:{} no find".format(sh.name,rownum+1,rowlist[0],rowlist[9]))

                                else:
                                        #dic = eval(infodic[1])
                                        # get current student's info dicts
                                        dic_current=studict[removelast(rowlist[0])]
                                        csvlist[0]="1" # SN
                                        csvlist[1]=dic_current['LEARNINGCENTERCODE'][:3] #segmentcode
                                        csvlist[2]=dic_current['LEARNINGCENTERCODE'][:5] #collegecode
                                        #get info by dic
                                        
                                        csvlist[3]=dic_current['CLASSCODE'] #classcode
                                        csvlist[4]=rowlist[2].rstrip('0').rstrip('.') #examPlanCode
                                        csvlist[5]=str(rowlist[3].rstrip('0').rstrip('.')).zfill(2) #ExamCategory
                                        csvlist[6]=examunitlist[rowlist[10]]
                                        csvlist[7]=str(removelast(rowlist[1])).zfill(5) #courseid
                                        if papercodetype=='4':
                                                oldpapercode=str(removelast(rowlist[4])) # if papercode 's lenght is 3 or 4
                                                if len(oldpapercode)<4:
                                                        oldpapercode=oldpapercode.zfill(4)
                                                try:
                                                        csvlist[8]=newPaperCode(oldpapercode) if len(oldpapercode)==4 else oldpapercode
                                                except(ValueError):
                                                        print("papercode error: line number {}".format(rownum+1))
                                                        pass
                                                        
                                        else:    
                                                csvlist[8]=str(removelast(rowlist[4])).zfill(5)
                                        csvlist[9]=dic_current['LEARNINGCENTERCODE'] #learningcentercode
                                        csvlist[10]=removelast(rowlist[0]) #studentcode
                                        scorelist=()
                                        #print("{key}{val}".format(key=rowlist[5],val=getRedis(rowlist[5])))
                                     
                                        #get score by scoredic
                                        #print (rowlist[5])
                                        if rowlist[5]!='' and str(rowlist[5]).upper()!='NULL':
                                                csvlist[12]=score2round(rowlist[5])# PaperScoreCode
                                                csvlist[11]=scoredic[csvlist[12]] #PaperScore
                                        if rowlist[6]!=''  and str(rowlist[6]).upper()!='NULL':
                                                csvlist[14]=score2round(rowlist[6]) #xkscorecode
                                                try:
                                                        csvlist[13]=scoredic[csvlist[14]] #XKscore
                                                except:
                                                        print("score error line:{}".format(rownum+1))
                                                        pass
                                        #xk scale
                                        valscale='0'
                                        #print (rowlist[7]) 
                                        if is_number(rowlist[7]):
                                                if float(rowlist[7])<=1.0:
                                                        valscale='%d'%(float(rowlist[7])*100)
                                                else:
                                                        valscale='%d'%float(rowlist[7])
                                        else :
                                                valscale=rowlist[7].rstrip('%')
                                        csvlist[15]=valscale  #xkscale
                                        # composescore
                                        if rowlist[8]!=''  and str(rowlist[8]).upper()!='NULL':
                                                csvlist[17]=score2round(rowlist[8])           #composescorecode
                                                try:
                                                        csvlist[16]=scoredic[csvlist[17]] #composescore
                                                except:
                                                        print("composescore error line:{}".format(rownum+1))
                                                        pass
                    
                    #csvlist[18] #composeDate
                    #csvlist[19] #publistdate
                                        csvlist[20]="1"
                                        csvlist[21]="1"
                                        csvlist[22]="end"
                                iTotal+=1
                                printProgress(iTotal,totalLines,prefix='Process',suffix='Complete',barLength=50)
                                #print(iTotal)
                                if bvalid==True:
                                        iValid+=1
                                        wr.writerow(csvlist)
                        print("{}:Totla{},valid{}".format(sh.name,iTotal,iValid))
 
def expSignup(csvname,xlsfile,papercodetype='4'):
       # get date from score***xls to create composescore
       #filename is format that is name such as elc90* or signup90* or score90* 
       #deal with numeric
        studict=getstuinfoDic()
        col_sign=['学号','考试代码','课程ID','学校代码,教学点代码','考试单位类型','考试类别,考试类别代码','试卷代码,试卷号']
        
        batlist={"秋季":"09","春季":"03"}
        examunitlist={"中央":"1","省":"2","国开":"1","省开":"2"}
        
    
        with open(csvname,'w',newline='',encoding='gb2312') as csvfile:
                wr =  csv.writer(csvfile,quoting=csv.QUOTE_NONE,quotechar='',escapechar='\\')
                wb = xlrd.open_workbook(xlsfile)
             
             
                for sh in wb.sheets():
                        if sh.nrows==0:
                                print("{} is empty".format(sh.name))
                                continue
                        # deal with mutilplines
                        # from the second line 
                        bColOrder=True
                        rowcollist=sh.row_values(0)
                        for i in range(len(col_sign)):
                                if  rowcollist[i] not in str(col_sign[i]).split(','):
                                        bColOrder=False
                                        print ("sheet:{} {}'s number:{} column,{} is not match {}".format(xlsfile,sh.name,i,col_sign[i],rowcollist[i]))
                                        break
                        if bColOrder==False:
                                continue
                        lins = [x for x in range(1,sh.nrows)]
                        iTotal=0
                        iValid=0
                        for rownum in lins:
                                bvalid=True
                                csvlist=["" for x in range(27)]
                                rowlist =[str(item).replace('\n',' ').replace(',',' ').strip() for item in sh.row_values(rownum)]
                                #print("{},{}".format(rownum,rowlist))

                                if removelast(rowlist[0]) not in studict.keys():
                                        bvalid=False
                                        print("{}:{},{},{} no find".format(sh.name,rownum,rowlist[0],rowlist[3]))
                                else:
                                                                        # get current student's dict by first row 
                                        dic_current=studict[removelast(rowlist[0])]
                                        csvlist[0]="1" # SN
                                        csvlist[1]=rowlist[1][:6] #exambatchcode
                                        csvlist[2]=rowlist[1][:6] #exambatchcode
                                        csvlist[3]=rowlist[5]     #ExamCategory
                                        # csvlist[4] accessmode
                                        # csvlist[5] examsitecode
                                        # csvlist[6] examsessionunit
                                        if  rowlist[6]!='':
                                                if papercodetype=='4':  
                                                        try:
                                                                csvlist[7]=newPaperCode(removelast(str(rowlist[6]))) #exampapercode
                                                        except(ValueError):
                                                                print("papercode error line number{}".format(rownum+1))
                                                                pass
                                                else: 
                                                        csvlist[7]=str(removelast(rowlist[6])).zfill(5)
                                   
                                        #csvlist[8] # exampapermemo
                                        csvlist[9]=str(removelast(rowlist[2])).zfill(5) #courseid
                                        #csvlist[10] tcpcode
                                        csvlist[11]=removelast(dic_current['LEARNINGCENTERCODE'])[:3] #segmentcode
                                        csvlist[12]=removelast(dic_current['LEARNINGCENTERCODE'])[:5] #collegecode
                                        csvlist[13]=removelast(dic_current['LEARNINGCENTERCODE'])     #learningcentercode
                                        #get info by redis      
                                        csvlist[14]=dic_current['CLASSCODE'] #classcode
                                        csvlist[15]=removelast(rowlist[0]) #studentcode
                                        csvlist[16]=examunitlist[rowlist[4]] #examunit
                                        csvlist[17]='elximp'
                                        #csvlist[18] applicatedate
                                        #csvlist[19] signuptype
                                        csvlist[20]='1' # isconfirm
                                        #csvlist[21] confirmreason
                                        #csvlist[22] confirmer
                                        #csvlist[23] confirmdate
                                        #csvlist[24] feecertificate
                                        #csvlist[25] elc_refid
                                        #csvlist[26]=getRedis(rowlist[2],'gb')[1]
                                         
                                        
                                        #print("{key}{val}".format(key=rowlist[5],val=getRedis(rowlist[5])))
                                 
                              
                                iTotal+=1
                                if bvalid==True:
                                        iValid+=1
                                        wr.writerow(csvlist)
                        print("{}:Totla{},valid{}".format(sh.name,iTotal,iValid))
    
def getScore(rekey):
        scorelist=['' for x in range(3)]
        reScore = redis.Redis(host='10.96.142.109',port=6380,db=8)
        score = reScore.hget('maxscore',rekey)
        if score is not None:
                scorelist=score.decode('utf-8').split(',')
                return scorelist
    

def expStatus(csvname,impcsvfile):
     
        reScore = redis.Redis(host='10.96.142.109',port=6380,db=8)
        reSign = redis.Redis(host='10.96.142.109',port=6380,db=7)
        with open(csvname,'w',newline='',encoding='gb2312') as csvfile:
                wr =  csv.writer(csvfile,quoting=csv.QUOTE_NONE,quotechar='',escapechar='\\')
                #progress 
                
                impcsv=open(impcsvfile,'r')
                csvline = len(impcsv.readlines())
                impcsv=open(impcsvfile,'r')
                
                reader = csv.reader(impcsv,delimiter=',')
                i=0
                printProgress(i,csvline,prefix='Process',suffix='Complete',barLength=50)
         
                for row in reader:
                        exprow=[1 for x in range(9)]
                        exprow[1]=row[0] #studentcode
                        exprow[2]=row[1] #courseid
                        #get score
                        score = reScore.hget('maxscore',''.join(row))
                        #print("{}:{}".format(''.join(row),score))
                        if score is not None:
                                scorelist=score.decode('utf-8').split(',')
                                if float(scorelist[0])>59:
                                        exprow[3]='4' #studystatus
                                exprow[5]=scorelist[0]#score
                                exprow[6]=scorelist[1]  #scorecode
                                exprow[7]=scorelist[2]  #scoretype
                        #get signnum
                        sign = reSign.get(''.join(row))
                        if sign is not None:
                                exprow[4]=sign.decode('utf-8')
                        wr.writerow(exprow)
                        i +=1
                        printProgress(i,csvline,prefix='Process',suffix='Complete',barLength=50) 
   
                impcsv.close()   
             
             
def expStatus2(csvname,statuscsv,scorecsv):
        #dfstatus = pd.read_csv(statuscsv,header=None,dtype=object,name=['studentcode','courseid'])
        dfstatus =pd.read_csv(statuscsv,header=None,dtype={'studentcode':str,'courseid':str},names=['studentcode','courseid'])
        df2=pd.read_csv(scorecsv,header=None,dtype={'studentcode':str,'courseid':str,'score':np.float64,'scorecode':str,'scoretype':str},names=['studentcode','courseid','score','scorecode','scoretype'])
        idx = df2.groupby(['studentcode','courseid'])['score'].transform(max)==df2.score
        df3=df2[idx]
        #df3['iid']=df3.index
        df3.reset_index(level=0,inplace=True) #first column 'name is index to index's clone
        idx2=df3.groupby(['studentcode','courseid'])['index'].transform(max)==df3['index']
        dflast=df3[idx2]
        expdf=pd.merge(dfstatus,dflast,on=['studentcode','courseid'],how='left')
        expdf['scorestatus']=expdf.score.apply(lambda value:4 if value>59 else 1)
        expdf[['studentcode','courseid','scorestatus','score','scorecode','scoretype']].to_csv(csvname,index=False)   
        #df.columns=['studentcode','courseid']
        #df[2]=df[1].apply(lambda value:'0'*(5-len(str(value)))+str(value))
        #df.courseid=df.courseid.astype(str)
        #df.courseid=df.courseid.apply(lamdba value:'0'*(5-len(value))+value)
        
def expNetExam(csvname,xlsfile):
       #filename is format that is name such as elc90* or signup90* or score90* 
       #deal with numeric
        scoredic=getscoreDic()
        col_elc=['kssj','wkkm','cjdm','xh','dwdm']
        batlist={"秋季":"09","春季":"03","秋":"09","春":"03"}
        examunitlist={"中央":"1","省":"2"}
        rnNum =[0,1,2,3,4,5] # deal \n
        intnum=[11,12,13,14,15,16,17,23,24]
        blknum=[18,19,20,21,22]
    
    
        with open(csvname,'w',newline='',encoding='gb2312') as csvfile:
                wr =  csv.writer(csvfile,quoting=csv.QUOTE_NONE,quotechar='',escapechar='\\')
                wb = xlrd.open_workbook(xlsfile)
                tmpCol2=""
                tmpCol3=""
                tmpCol4=""
                tmpCol5=""
        
        
                for sh in wb.sheets():
                        if sh.nrows==0 :
                                print("{} is empty".format(sh.name))
                                continue
                        # deal with mutilplines
                        # from the second line 
                        # is columns order is current?
                        bColOrder=True
                        rowcollist=sh.row_values(0)
                        for i in range(len(col_elc)):
                                if str(rowcollist[i]).lower() not in str(col_elc[i]).split(','):
                                        bColOrder=False
                                        print ("sheet:{} {}'s number:{} column,{} is not match {}".format(xlsfile,sh.name,i,col_elc[i],rowcollist[i]))
                                        break
                        if bColOrder==False:# if Column's order is not current then break and get next sheet
                                continue
              
                        lins = [x for x in range(1,sh.nrows)]
                        iTotal=0
                        iValid=0
                        for rownum in lins:
                 
                                bvalid=True                
                                csvlist=["1" for x in range(7)]
                                #all conver to string and remove return char and             
                                rowlist =[str(item).replace('\n',' ').replace(',',' ').strip() for item in sh.row_values(rownum)  ]
                                
                                #get info by redis
                                #stuinfo = getRedis(rowlist[0])
                                # find studentcode in studict 
                                if  1!=1:#暂时不判断学号是否存在#removelast(rowlist[0]) not in studict.keys():
                                        bvalid=False
                                        print("{}:{},{},{}, no find".format(sh.name,rownum,rowlist[0],rowlist[1]))
                                else:
                                        #dic = eval(stuinfo[1])
                                        #print("{},{}".format(rowlist[0],is_number(rowlist[0])))
                                        #csvlist[0]                        SN
                                        csvlist[1]=removelast(rowlist[0]) #unifBatchCode
                                        csvlist[2]=removelast(rowlist[1]) #subjectcode
                                        csvlist[3]=removelast(rowlist[3])  #studentcode
                                        csvlist[4]=scoredic[rowlist[2]]  #score
                                        csvlist[5]=removelast(rowlist[2]) #scorecode
                                        #csvlist[6] #IsRecord
                                       
                                iTotal+=1
                                if bvalid==True:
                                        iValid+=1
                                        wr.writerow(csvlist)
                        print("{}:Totla{},valid{}".format(sh.name,iTotal,iValid))
        csvfile.close()        
#导出指导性专业规则模块课程
def expModuleCourse(csvname,xlsfile):
               #filename is format that is name such as modcourse
               #deal with numeric
                #文件列名
                col_head=['规则号','模块名','课程id','课程名称','课程类型','课程性质','学分','建议开设学期','考试单位','定义学校','互斥课标志','相似课标志']
                #模块名
                modulecodelist={"课程开放":"00","公共基础课":"01","专业基础课":"02","专业课":"03","通识课":"04","专业拓展课":"05","综合实践":"06","特色课":"07","专业核心课一":"08","公共英语课":"09","职业核心课":"10","专业/职业延展课":"11","通识文化课":"12","通用技术课":"13","职业延展课":"14","专业核心课":"15","思想政治课":"16","实践课":"17","公共基础课一":"20","公共基础课二":"21","专业基础课一":"22","专业基础课二":"23","专业课一":"24","专业课二":"25","专业课三":"26","通识课二":"27","专业拓展课一":"28","专业拓展课二":"29","职业核心课一":"30","实践课一":"31","职业核心课二":"32","职业核心课三":"33","职业核心课四":"34","职业核心课五":"35","专业核心课二":"36","专业方向课":"37","专业限选课":"38","专业选修课":"39","证书课":"40","二外课":"50","通识素质课程":"60","专业能力课程":"61","职业技能课程":"62","补修课及规则外选课":"99"}
                #课程类型
                coursenaturelist={"必修":"1","选修":"3"}
                #课程单位
                orgcodelist={"中央广播电视大学":"010","国家开放大学邮政学院":"909"}
                
                #考试单位性质
                examunitlist={"中央":"1","省":"2"}
                #是否互斥
                iflist={"无":"0","有":"１"}
                
                rnNum =[0,1,2,3,4,5] # deal \n
                intnum=[11,12,13,14,15,16,17,23,24] # deal is int data type
                blknum=[18,19,20,21,22] 
            
            
                with open(csvname,'w',newline='',encoding='gb2312') as csvfile:
                        wr =  csv.writer(csvfile,quoting=csv.QUOTE_NONE,quotechar='',escapechar='\\')
                        wb = xlrd.open_workbook(xlsfile)
                        
                
                
                        for sh in wb.sheets():
                                if sh.nrows==0 :
                                        print("{} is empty".format(sh.name))
                                        continue
                                # deal with mutilplines
                                # from the second line 
                                # is columns order is current?
                                bColOrder=True
                                rowcollist=sh.row_values(0)
                                for i in range(len(col_head)):
                                        if str(rowcollist[i]).lower() not in str(col_head[i]).split(','):
                                                bColOrder=False
                                                print ("sheet:{} {}'s number:{} column,{} is not match {}".format(xlsfile,sh.name,i,col_head[i],rowcollist[i]))
                                                break
                                if bColOrder==False:# if Column's order is not current then break and get next sheet
                                        continue
                      
                                lins = [x for x in range(1,sh.nrows)]
                                iTotal=0
                                iValid=0
                                for rownum in lins:
                         
                                        bvalid=True                
                                        csvlist=["" for x in range(17)]
                                        #all conver to string and remove return char and             
                                        rowlist =[str(item).replace('\n',' ').replace(',',' ').strip() for item in sh.row_values(rownum)  ]
                                        
                                        #get info by redis
                                        #stuinfo = getRedis(rowlist[0])
                                        # find studentcode in studict 
                                        if  removelast(rowlist[1]) not in modulecodelist.keys():#判断模块号是否存在#removelast(rowlist[0]) not in studict.keys():
                                                bvalid=False
                                                print("{}:{},{},{}, no find it's modulecode".format(sh.name,rownum,rowlist[0],rowlist[1]))
                                        else:
                                                #dic = eval(stuinfo[1])
                                                #print("{},{}".format(rowlist[0],is_number(rowlist[0])))
                                                csvlist[0]= uuid.uuid4()          #SN
                                                csvlist[1]=modulecodelist[removelast(rowlist[1])] #ModuleCode
                                                csvlist[2]="20{}".format(removelast(rowlist[0][:4])) #Batchcode
                                                csvlist[3]=removelast(rowlist[0])  #tcpcode
                                                csvlist[4]=removelast(rowlist[2])  #courseid
                                                csvlist[5]=removelast(rowlist[3]) #coursename
                                                csvlist[6]=coursenaturelist[removelast(rowlist[5])]        #coursenature
                                                csvlist[7]=orgcodelist[removelast(rowlist[9])] #orgcode
                                                intCredid=0
                                                if is_number(rowlist[6]):
                                                        intCredid='%d'%float(rowlist[6])
                                                else:
                                                        print("credit error line:{}".format(rownum+1))
                                                csvlist[8]=intCredid #credit
                                                Hour=''
                                                csvlist[9]=Hour  #Hour
                                                intSemester=0
                                                if is_number(rowlist[7]):
                                                        intSemester='%d'%float(rowlist[7])
                                                else:
                                                        print("OpenSemester error line{}".format(rownum+1))
                                                csvlist[10]=intSemester
                                                csvlist[11]=examunitlist[rowlist[8]]
                                                csvlist[12]=0 #isExtendedcourse
                                                csvlist[13]=0 #isdegreecourse
                                                csvlist[14]=iflist[removelast(rowlist[11])] #issimilar
                                                csvlist[15]=iflist[removelast(rowlist[10])] #ismutex
                                                csvlist[16]=str(datetime.date.today())
                                                        
                                                        
                                                
                                               
                                        iTotal+=1
                                        if bvalid==True:
                                                iValid+=1
                                                wr.writerow(csvlist)
                                print("{}:Totla{},valid{}".format(sh.name,iTotal,iValid))
                csvfile.close()    

def main():
        global re
        xlsfile = sys.argv[1]
        base= os.path.basename(xlsfile)
        basename=os.path.splitext(base)[0]
        if basename[:3]=='elc':           #选课数据
                expElc("./export/data_{}.csv".format(basename),xlsfile)
        elif basename[:6]=='score4': #add new composescore
                expScore("./export/data_{}.csv".format(basename),xlsfile,'4')
        elif basename[:6]=='score5': #add new composescore
                expScore("./export/data_{}.csv".format(basename),xlsfile,'5')    
        elif basename[:7]=='signup4': #add new signup 
                expSignup("./export/data_{}.csv".format(basename),xlsfile,'4')
        elif basename[:7]=='signup5': # add new in eas_elc_signup
                expSignup("./export/data_{}.csv".format(basename),xlsfile,'5')
        elif basename[:6]=='status':
                #expStatus("data_{}.csv".format(basename),xlsfile)
                expStatus2("./export/data_{}2.csv".format(basename),"status.csv","score_109.csv")
        elif basename[:3]=='wks':
                expNetExam("./export/data_{}.csv".format(basename),xlsfile)        
        elif basename[:9]=='newcourse':  #add new course in eas_tcp_modulecourse
                expModuleCourse("./export/data_{}.csv".format(basename),xlsfile)        
 
if __name__=='__main__':
        main()

