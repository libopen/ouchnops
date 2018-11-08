from  sqlalchemy import create_engine,MetaData,Table,Column,ForeignKey,func,Integer,String,Sequence,func
from  sqlalchemy.ext.automap import automap_base

class Easdb:
      "tables1 is db_base tables2 is db_appA or db_appB"
      tables1 = ['eas_tcp_guidance','eas_schroll_student','eas_org_classinfo','eas_spy_basicinfo','eas_schroll_studentbasicinfo']
      tables2 = ['eas_elc_studentelcinfo','eas_elc_studentstudystatus']
      dbclass=[]
      def __init__(self,connstr,dbid=1):
          self.connstr=connstr
          self.dbid   =dbid
          self.createalltable()


      def createalltable(self):
          metadata = MetaData()
          engine = create_engine(self.connstr)
          if 1==self.dbid:
             metadata.reflect(engine,only=self.tables1)
          else:
             metadata.reflect(engine,only=self.tables2)
          Base=automap_base(metadata=metadata)
          Base.prepare()
          self.dbclass = Base.classes
      
      def IsRightTable(self,tbname):
          IsRight = True
          if self.dbid==1:
             if tbname in Easdb.tables1:
                IsRight=True
             else:
                IsRight=False
          else:
             if tbname in self.tables2:
                IsRight=True
             else:
                IsRight=False
          return IsRight
     
      def get_TCP_GUIDANCE(self):
          if self.IsRightTable('eas_tcp_guidance'):
             return self.dbclass.eas_tcp_guidance;        
          else:
             return None


      def get_ORG_Class(self):
          if self.IsRightTable('eas_org_classinfo'):
             return self.dbclass.eas_org_classinfo;        
          else:
             return None
      
      def get_SPY_Basicinfo(self):
          if self.IsRightTable('eas_spy_basicinfo'):
             return self.dbclass.eas_spy_basicinfo;        
          else:
             return None

      def get_SCH_studentbase(self):
          if self.IsRightTable('eas_schroll_studentbasicinfo'):
             return self.dbclass.eas_schroll_studtbasicinfo;        
          else:
             return None
