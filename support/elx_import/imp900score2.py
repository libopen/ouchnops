import xlrd
import csv
import os,uuid
import sys ,datetime
from progressbar import printProgress
import pandas as pd
import numpy as np

####################### common tools#################
class Csv2Dict:
        def __init__(self,dic_key,csvfile):
                self._dic_key=dic_key
                self._csvfile=csvfile
                self._dict = {}
        
        
        def init_dict(self):
                #import pdb
                #pdb.set_trace()
                dict={}
                reader=csv.DictReader(open(self._csvfile,'r'))
                for line in reader:
                        dict[line[self._dic_key]]=line
                self._dict = dict
 
        def getItemByKey(self,dickey,itemkey):
               if dickey in self._dict:
                  return self._dict[dickey][itemkey],True
               else:
                  return dickey,False
####  tools used to  convert the different  text in cell to standard format in table       
class tools:
        @staticmethod
        def is_number(s):
        # judge the string is number
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
        
        @staticmethod
        def removelast(val):
        #remove the last char of the string
                if len(str(val))>2 :
                   return val[:-2] if val[-2:]=='.0' else val
                else:
                   return val


        @staticmethod        
        def getRedis(re,val,code='utf'):    
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
        
        @staticmethod
        def score2round(score):
#            import pdb;pdb.set_trace()
            try:
                if score!='':
                    if score[0] in '1234567890':
                        return str(int(float(score)+0.5))
                    else:
                        return tools.removelast(str(score))
                else:
                    return ''
            except:
                print("Wrong input score:{}".format(score))
#************ ouchn process *********************
        @staticmethod
        def papercode5(code4):
        # change code from four to five by standard
#                import pdb
#                pdb.set_trace()
                try:
                        bOK = True
                        if len(code4) ==4:
                                top2=code4[:2]
                                if (top2=='27') or (top2=='49') :
                                        return "4{}".format(code4)
                                elif int(top2)<20:
                                        return "1{}".format(code4)
                                elif int(top2)>49:
                                        return "5{}".format(code4)
                                else:
                                        return "2{}".format(code4)
                        elif len(code4) == 5:
                              return code4
                        else:
                              return code4
                except:
                              return  'error at papercode'
        @staticmethod 
        def examunit(examunitcode):
              examunitlist={"中央":"1","省":"2","国开":"1","省开":"2"}
              try:
                 return  examunitlist[examunitcode]
              except:
                 return 'error at  examunit'

        @staticmethod 
        def term(term):
              termdict= {"秋季":"09","春季":"03","秋":"09","春":"03"}
              try:
                 return termdict[term]
              except :
                 return 'error in term'

        @staticmethod
        def segmentcode(code):
              return str(code)[:3]

        @staticmethod
        def collegecode(code):
              return str(code)[:5]

        @staticmethod
        def code2score(code):
              scoredict  = dict({"$$":0, "&-":30, "&&":60, "*-":30, "**":60, ".1":20, ".2":40, ".3":60, ".4":80, ".5":100, "++":100, "+0":20, "+1":40, "+2":60, "+3":70, "+4":80, "+5":90, "==":0, "0":0, "00":0, "01":1, "02":2, "03":3, "04":4, "05":5, "06":6, "07":7, "08":8, "09":9, "1":1, "-1":0, "10":10, "11":11, "12":12, "13":13, "14":14, "15":15, "16":16, "17":17, "18":18, "19":19, "2":2, "-2":0, "20":20, "21":21, "22":22, "23":23, "24":24, "25":25, "26":26, "27":27, "28":28, "29":29, "3":3, "-3":0, "30":30, "31":31, "32":32, "33":33, "34":34, "35":35, "36":36, "37":37, "38":38, "39":39, "4":4, "-4":0, "40":40, "41":41, "42":42, "43":43, "44":44, "45":45, "46":46, "47":47, "48":48, "49":49, "5":5, "-5":60, "50":50, "51":51, "52":52, "53":53, "54":54, "55":55, "56":56, "57":57, "58":58, "59":59, "6":6, "60":60, "61":61, "62":62, "63":63, "64":64, "65":65, "66":66, "67":67, "68":68, "69":69, "7":7, "-7":60, "70":70, "71":71, "72":72, "73":73, "74":74, "75":75, "76":76, "77":77, "78":78, "79":79, "8":8, "80":80, "81":81, "82":82, "83":83, "84":84, "85":85, "86":86, "87":87, "88":88, "89":89, "9":9, "90":90, "91":91, "92":92, "93":93, "94":94, "95":95, "96":96, "97":97, "98":98, "99":99, "100":100})
              #process code is float 
              newcode = (tools.score2round(code) if tools.is_number(code) else code)
             
              return (scoredict[newcode] if newcode in scoredict else '')

        @staticmethod
        def fixScoreCode(scorecode):
              # 1. float -->score2round 2. nondigit 
              return (tools.score2round(scorecode) if tools.is_number(scorecode) else scorecode)

        @staticmethod
        def percentage(val):
               if tools.is_number(val) == True:
                  return '%d'%(float(val)*100) if float(val)<=1.0 else '%d'%float(val)
               else:
                  return str(val).rstrip('%')

        @staticmethod
        def ouchn_tools(action,newvalue):
#              import pdb
#              pdb.set_trace()
                 #********Branching Using Dictionaries*********************
                 # newvalue will be process by special method in class tools
              functions = dict(score2 = tools.score2round,papercode = tools.papercode5,
                               examunit = tools.examunit,segmentcode = tools.segmentcode,collegecode = tools.collegecode,
                               term = tools.term,percentage=tools.percentage,code2score=tools.code2score,
                               fixscorecode = tools.fixScoreCode)
              return functions[action](newvalue)
               

#################### define  class :  cell,row in Excel
class baseCell:
         def __init__(self,table_colname,excel_colname,table_position,cellvalue='',ismatch=False,cellprocess='normal',isexport=True):
               self.table_colname = table_colname
               self.excel_colname = excel_colname
               self.table_position = table_position
               self.cellprocess   = cellprocess  # represent the cellvalue will be process by some action
               self._elxcol_position = 0
               self._cellvalue = cellvalue
               self._ismatch = ismatch  # if _ismatch is 1 ,it will be matched with excel file column header
               self._isexport = isexport # if _isexport = Ture ,this cellvalue will be add in csvlist to export
           
               

         @property
         def elxcol_position(self):
              return self._elxcol_position
         
         #elx file current cell column number
         @elxcol_position.setter
         def elxcol_position(self,new_position):
               self._elxcol_position = new_position
         
         @property
         def cellvalue(self):
              return self._cellvalue

         @cellvalue.setter
         def cellvalue(self,newvalue):
                 #********Branching Using Dictionaries*********************
                 # newvalue will be process by special method in class tools
               # first remove last space and .0 
              val  = tools.removelast(str(newvalue).strip())
              # lambda <args> : <return Value> if <condition > ( <return value > if <condition> else <return value>)
              checkaction = lambda action,val:tools.ouchn_tools(action,val) if action !='normal' else val
              self._cellvalue = checkaction(self.cellprocess,val)
       
         @property
         def ismatch(self):
               return self._ismatch

         @property
         def isexport(self):
               return self._isexport
         

class termCell(baseCell):
         @property
         def cellvalue(self):
             return self._cellvalue

         @cellvalue.setter
         def cellvalue(self,newvalue):
              termdict= {"秋季":"09","春季":"03","秋":"09","春":"03"}
              try:
                termvalue = termdict[newvalue]
                self._cellvalue = termvalue
              except: 
                raise('no standard termvalue')


         
          #we'll define the csv table names and positions of every columns name
class baseElxRow:
         # base class for Elc,signup,comparescore
         def __init__(self):
               pass

         # configlist :construct  basecell list       
         def init(self,configlist):         
                #tip: table_colname is upper
                self._celllist=[baseCell(table_colname=str(cell[0]).upper(),excel_colname=cell[1],table_position=i,cellvalue=cell[2],ismatch=cell[3],cellprocess=(cell[4] if cell[4]!='' else 'normal'),isexport=cell[5]) for i,cell in enumerate(configlist)]

         def setpositionInExcel(self,elxrow):
#              import pdb
#              pdb.set_trace()
              isOK = True
              nomatchcol = ''
              for cell in self._celllist:
                  if cell.ismatch == True: # if this column head must be matched with standard header
                     IsFind = False
                     for i,val in enumerate(elxrow):
                          if cell.excel_colname == val:
                             IsFind = True
                             cell.elxcol_position = i
                             break  # colname has found ,do next
                     if IsFind == False:
                        isOK = False
                        #import pdb; pdb.set_trace()
                        #print("{} is not finded".format(cell.excel_colname))
                        nomatchcol="{}-{}".format(cell.table_colname,cell.excel_colname)
                        break    # stop doing, break out
                        

              return isOK,nomatchcol

         def __repr__(self):
              collist = ','.join(str("{}:{}:{}-{}".format(e.table_colname,e.table_position,e.elxcol_position,e.cellvalue)) for e in self._celllist)
              
              return collist

         def row2csvlist(self):
             # because celllist is sort ,it only get table_position!=-1 
#             i = 0
#             csvlist=[]
##             import pdb
##             pdb.set_trace()
#             for i in range(len(self._celllist)-1):
#                if self._celllist[i].table_position == -1:
#                   break
#                else:
#                  csvlist.append(self._celllist[i].cellvalue)
#             
#             csvlist.append('end')

              # optimize 
              csvlist = [cell.cellvalue for cell in self._celllist if cell.isexport == True]  
              csvlist.append('end')
              return csvlist

         def getcsvlist(self,elxrow):
             for cell in self._celllist:
                 if cell.ismatch == True:
                     cell.cellvalue = elxrow[cell.elxcol_position]

         # used for find cell by table_header_name
         def getCellByname(self,tablename):
#                curr = None
#                for cell in self._celllist:
#                     if cell.table_colname == tablename:
#                        curr =  cell
#                        break
                celllist = [cell for cell in self._celllist if cell.table_colname == str(tablename).upper()]
                return celllist[0]

#### class used for export studentelcinfo 
class ElcElxRow(baseElxRow):  # subclass of baseElxRow
         def __init__(self):
             tu=[('refid','refid'       ,'1',False,'',True),
             ('batchcode','选课年度','',True,'',True),
             ('studentcode','学号'  ,'',True,'',True),
             ('courseid','课程ID'   ,'',True,'',True),
             ('learningcentercode','教学点代码','',True,'',True),
             ('classcode','classcode','',False,'',True),
             ('isplan'   ,'isplan'   ,'1',False,'',True),
             ('operator','operator'  ,'elximp',False,'',True),
             ('elcstate','elcstate'  ,'1',False,'',True),
             ('operatetime','operatetime','',False,'',True),
             ('confirmoperator','confirmoperator','elximp',False,'',True),
             ('confirmstate','confirmstate','1',False,'',True),
             ('confirmtime','confirmtime','',False,'',True),
             ('currentselectnumber','选课次数','',True,'',True),
             ('spycode','spycode','',False,'',True),
             ('isapplyexam','isapplyexam','1',False,'',True),
             ('elctype','elctype','1',False,'',True),
             ('studentid','studentid','',False,'',True),
             ('sn','sn','',False,'',True),
             ('selectterm','选课学期','',True,'term',False)]
             self.init(tu) 

         def init(self,configlist):
              # call superclass init construte _celllist
              super(ElcElxRow,self).init(configlist)
              studentDict = Csv2Dict(dic_key = 'STUDENTCODE',csvfile = 'stuinfo.txt')
              studentDict.init_dict()
              self._studentDict =  studentDict
              
         def getcsvlist(self,elxrow):
             # rewrite some columns cell vaue 
             # throught studentdict find studentid,spycod
             # subclass call parent class method
             bOK = True
             super(ElcElxRow,self).getcsvlist(elxrow)
             cell_student            =self.getCellByname("studentcode")
             dictkey = cell_student.cellvalue
             cell_term               =self.getCellByname("selectterm")
             try:
                 for cell in self._celllist:
                     if  cell.table_colname.lower() in ('learningcentercode','classcode','spycode','studentid'):
                           cellValue,bFind= self._studentDict.getItemByKey(dictkey,str(cell.table_colname).upper()) 
                           if bFind == True:
                              cell.cellvalue = cellValue
                           else:
                             # if there is not match item ,break down
                              print("{},studentkey not exist".format(cellValue))
                              bOK = False 
                              break
                     if  cell.table_colname.lower() in ('sn'):
                           cell.cellvalue = uuid.uuid4()
                     if cell.table_colname.lower() == 'batchcode':
                           cell.cellvalue = cell.cellvalue+cell_term.cellvalue 
             
             except:
                 return False    
                                  
             return bOK

#### composescore class use for exporting composescore 
class ComposeElxRow(baseElxRow): #subclass of baseElxRow
         def __init__(self):
                # arrange the export csv column by ctl 
                # in every tuple 1:table_colname 2:excel_colname 3:default cell value 4:ismatch 5:cellvalue process method
                tu= [('sn','sn','1',False,'',True),
                  ('segmentcode','教学点代码','',True,'segmentcode',True),
                  ('collegecode','教学点代码','',True,'collegecode',True),
                  ('classcode','classcode','',False,'',True),
                  ('examplancode','考试代码','',True,'',True),
                  ('examcategorycode','考试类别代码','',True,'',True),
                  ('examunit','考试单位类型','',True,'examunit',True),
                  ('courseid','课程ID','',True,'',True),
                  ('exampapercode','试卷号','',True,'papercode',True),
                  ('learningcentercode','教学点代码','',True,'',True),
                  ('studentcode','学号','',True,'',True),
                  ('paperscore','试卷成绩代码','',True,'code2score',True),
                  ('paperscorecode','试卷成绩代码','',True,'fixscorecode',True),
                  ('xkscore','形考成绩代码','',True,'code2score',True),
                  ('xkscorecode','形考成绩代码','',True,'fixscorecode',True),
                  ('xkscale','形考比例','',True,'percentage',True),
                  ('composescore','综合成绩代码','',True,'code2score',True),
                  ('composescorecode','综合成绩代码','',True,'fixscorecode',True),
                  ('composedate','composedate','',False,'',True),
                  ('publishdate','publishdate','',False,'',True),
                  ('iscomplex','iscomplex','1',False,'',True),
                  ('ispublish','ispublish','1',False,'',True)]
                # conditional expression
                self.init(tu)     
            
         def init(self,configlist):
              #first call inti method in superclass then construct studentDict
              super(ComposeElxRow,self).init(configlist)
              studentDict = Csv2Dict(dic_key = 'STUDENTCODE',csvfile = 'stuinfo.txt')
              studentDict.init_dict()
              self._studentDict =  studentDict
              

         def getcsvlist(self,elxrow):
             bOK = True
             super(ComposeElxRow,self).getcsvlist(elxrow)
             cell_student            =self.getCellByname("studentcode")
             dictkey = cell_student.cellvalue
             try:
                 for cell in self._celllist:
                     if  cell.table_colname.lower() in ('classcode'):
                           cellValue,bFind= self._studentDict.getItemByKey(dictkey,str(cell.table_colname).upper()) 
                           if bFind == True:
                              cell.cellvalue = cellValue
                           else:
                              bOK = False       
                              print("{},studentkey not exist".format(cellValue))
                              break
             
             except:
                 return False    
                                  
             return bOK

#### class used for export signup 
class SignElxRow(baseElxRow):  # subclass of baseElxRow
         def __init__(self):
                tu=[('SN','SN','1',False,'',True),
                  ('EXAMBATCHCODE','考试代码','',True,'',True),
                  ('EXAMPLANCODE','考试代码','',True,'',True),
                  ('EXAMCATEGORYCODE','考试类别','',True,'',True),
                  ('ASSESSMODE','ASSESSMODE','',False,'',True),
                  ('EXAMSITECODE','EXAMSITECODE','',False,'',True),
                  ('EXAMSESSIONUNIT','EXAMSESSIONUNIT','',False,'',True),
                  ('EXAMPAPERCODE','试卷代码','',True,'papercode',True),
                  ('EXAMPAPERMEMO','EXAMPAPERMEMO','',False,'',True),
                  ('COURSEID','课程ID','',True,'',True),
                  ('TCPCODE','TCPCODE','',False,'',True),
                  ('SEGMENTCODE','学校代码','',True,'segmentcode',True),
                  ('COLLEGECODE','学校代码','',True,'collegecode',True),
                  ('LEARNINGCENTERCODE','学校代码','',True,'',True),
                  ('CLASSCODE','CLASSCODE','',False,'',True),
                  ('STUDENTCODE','学号','',True,'',True),
                  ('EXAMUNIT','考试单位类型','',True,'examunit',True),
                  ('APPLICANT','APPLICANT','elximp',False,'',True),
                  ('APPLICATDATE','APPLICATDATE','',False,'',True),
                  ('SIGNUPTYPE','SIGNUPTYPE','',False,'',True),
                  ('ISCONFIRM','ISCONFIRM','1',False,'',True),
                  ('CONFIRMREASON','CONFIRMREASON','',False,'',True),
                  ('CONFIRMER','CONFIRMER','',False,'',True),
                  ('CONFIRMDATE','CONFIRMDATE','',False,'',True),
                  ('FEECERTIFICATE','FEECERTIFICATE','',False,'',True),
                  ('ELC_REFID','ELC_REFID','',False,'',True),
                  ('COURSENAME','COURSENAME','',False,'',True)]
                # conditional expression
                self.init(tu) 

         def init(self,configlist):
              super(SignElxRow,self).init(configlist)
              studentDict = Csv2Dict(dic_key = 'STUDENTCODE',csvfile = 'stuinfo.txt')
              studentDict.init_dict()
              self._studentDict =  studentDict
              
         def getcsvlist(self,elxrow):
             # rewrite some columns cell vaue 
             # throught studentdict find studentid,spycod
             # subclass call parent class method
             bOK = True
             super(SignElxRow,self).getcsvlist(elxrow)
             cell_student            =self.getCellByname("STUDENTCODE")
             dictkey = cell_student.cellvalue
             try:
                 for cell in self._celllist:
                     if  cell.table_colname.lower() in ('classcode'):
                           cellValue,bFind= self._studentDict.getItemByKey(dictkey,str(cell.table_colname).upper()) 
                           if bFind == True:
                              cell.cellvalue = cellValue
                           else:
                              bOK = False
                              print("{},studentkey not exist".format(cellValue))
                              break
             
             except:
                 return False    
                                  
             return bOK



##### ouchn Excel ######
class ouchnExport:
         def __init__(self,elxname,appname):
             self._elxname  = elxname
             self._appname  = appname
             self._csvname  = "data_{}.csv".format(elxname)
                      
         def export2csv(self):
              # construct studentinfoDict
              import pdb
              pdb.set_trace()
              objRow = baseElxRow()
              with open(self._csvname,'w',newline='',encoding='gb2312') as csvfile :
                   csvwr =  csv.writer(csvfile,quoting=csv.QUOTE_NONE,quotechar='',escapechar='\\')
                   xlswb = xlrd.open_workbook(self._elxname)
                   # construct different ElxRow class by appname 
                   # different elxrow class instance will call its own getcsvlist method
                   if self._appname == 'elc':
                       objRow = ElcElxRow()
                   elif self._appname == 'signup':
                       objRow = SignElxRow()
                   elif self._appname == 'compose':
                       objRow = ComposeElxRow()
                       
                   for sh in xlswb.sheets():
                         # find the header row in every sheet
                         headrow = sh.row_values(0)
                         allline = 0
                         isMatch,strNotMatchcol = objRow.setpositionInExcel(headrow)
                         if isMatch == True: # match header and standard
                             for rownumber in range(1,sh.nrows): # begin with line 1
                                  if objRow.getcsvlist(sh.row_values(rownumber)) == True:
                                        csvwr.writerow(objRow.row2csvlist())
                                        allline += 1 
                         else: #find some not match colname
                             print("{} in sheet:{}".format(strNotMatchcol,sh.name))  
                         print("{}:total line={}".format(sh.name,allline))    
              csvfile.close()

        
def main()
        global re
        xlsfile = sys.argv[1]
        base= os.path.basename(xlsfile)
        basename=os.path.splitext(base)[0]
        if basename[:3]=='elc':           #选课数据
                expElc("./export/data_{}.csv".format(basename),xlsfile)
        elif basename[:5]=='score': #add new composescore
                objExp = ouchnExport(xlsfile,'compose')
                objExp.export2csv()
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

