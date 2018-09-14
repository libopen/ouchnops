'******************************************************************************
'* File:     List Tables.vbs
'* Purpose:  This VB Script shows how to display properties of the first 5 tables
'*           defined in the current active PDM using message box.
'* Title:    Display tables properties in message box
'* Category: Display tables properties
'* Version:  1.0
'* Company:  Sybase Inc. 
'******************************************************************************

Option Explicit

'-----------------------------------------------------------------------------
' Main function
'-----------------------------------------------------------------------------
' libin add 
dim objDict
set objDict=createobject("scripting.Dictionary")
objDict.Add "awardtypes" ,"�������ͱ�"
objDict.Add "baseinfo" ,"����ģ��?�������ݣ��������?����?ѧ�ƣ�"
objDict.Add "berkeleyspecialtys" ,"��Уרҵʵ��"
objDict.Add "classes" ,"�༶����"
objDict.Add "cooperationcollege" ,"������У��"
objDict.Add "course" ,"�γ���Ϣ��"
objDict.Add "courseadditional" ,"����-->רҵ����/��ѧ�ƻ�-->ָ����רҵ����-->-->�γ�ģ��-->�γ�"
objDict.Add "coursecontrol" ,"�γ�����ʱ�����"
objDict.Add "coursemodule" ,"����--ģ��γ�"
objDict.Add "courseselecteddetail" ,"ѡ������"
objDict.Add "courseselectperiod" ,"ѡ��ʱ��"
objDict.Add "degree" ,"ѧλ��Ϣ"
objDict.Add "degreeapplydate" ,"ѧλ����ʱ��"
objDict.Add "degreebatch" ,"ѧλ����"
objDict.Add "degreecourses" ,"ѧλ�γ̱�"
objDict.Add "degreeenglish" ,"ѧλӢ�����"
objDict.Add "degreeenglishs" ,"ѧλӢ��"
objDict.Add "degreepunishment" ,"�ͷ�����"
objDict.Add "degreerule" ,"ѧλ������Ϣ"
objDict.Add "department" ,"����"
objDict.Add "educationalsystem" ,"����--��������--ѧ��"
objDict.Add "educationbackg" ,"ѧ����Ϣ��"
objDict.Add "entrolscore" ,"����--��ѧ���Գɼ�"
objDict.Add "evaluatetype" ,"���۹���--����"
objDict.Add "evaluation" ,"���۹���--����2"
objDict.Add "evaluationanswer" ,"���ۼ�¼��"
objDict.Add "evaluationpart" ,"�Ҳ�����Ӧ��ʵ��"
objDict.Add "evaluationpartexam" ,"�Ҳ�����Ӧ��ʵ��"
objDict.Add "evaluationrecord" ,"�������ۼ�¼"
objDict.Add "examinee" ,"������Ϣ"
objDict.Add "exemptionapply" ,"����-->�����⿼-->��������--> �����⿼��������"
objDict.Add "exemptionapply_photo" ,""
objDict.Add "exemptionscore" ,"����-->�����⿼-->�����⿼�ɼ�ʵ��"
objDict.Add "exemptiontime" ,"�����⿼����ʱ��ʵ��"
objDict.Add "exemptiontype" ,"����-->�����⿼����"
objDict.Add "finalaudit" ,"ѧ���������"
objDict.Add "firstaudit" ,"��ѧ�ʸ�������"
objDict.Add "graduation" ,"��ҵ��������"
objDict.Add "graduationapplydate" ,"��ҵ����ʱ��"
objDict.Add "message" ,"��Ϣ"
objDict.Add "messagebody" ,"��Ϣ��"
objDict.Add "messagetype" ,"��Ϣ����"
objDict.Add "openspecialty" ,"����רҵ����"
objDict.Add "organization" ,"����ʵ��"
objDict.Add "orgxcoursescontrol" ,"����-->רҵ����/��ѧ�ƻ�-->ִ��רҵ����Ȩ��?ִ��רҵ����Ȩ��(��ѡ�޿γ̿��Ե���)"
objDict.Add "picture" ,"��Ƭʵ��"
objDict.Add "professionalcoursemodule" ,"ָ����רҵ����-->�γ�ģ��?�γ�ģ��ʵ��"
objDict.Add "professionalcoursemodule_courseadditional" ,""
objDict.Add "professionalcoursemodule_professionalsimilarcourse" ,""
objDict.Add "professionalrules" ,"רҵָ�������"
objDict.Add "professionalsimilarcourse" ,"ָ����רҵ����-->�γ�ģ�� -->���ƿγ�"
objDict.Add "professionaltime" ,"��ѧ�ƻ�--רҵ����ʱ�����"
objDict.Add "professionaltitle" ,"ְ����Ϣ��"
objDict.Add "punishmenttypes" ,"�ͷ����ͱ�"
objDict.Add "questionnaire" ,"���۹���--�ʾ�"
objDict.Add "recruitbacth" ,"����--��������--��������"
objDict.Add "recruitplanallot" ,""
objDict.Add "recruitplanbranch" ,"�����ƻ���������(��У)"
objDict.Add "recruitplanfill" ,""
objDict.Add "recruitplanset" ,"�����ƻ���ʵ��"
objDict.Add "recruittype" ,"����--��������--ѧ������ʵ��"
objDict.Add "schoolrollawardpunishmentapply" ,"ѧ����������"
objDict.Add "schoolrollawardpunishmentaudit" ,"ѧ��������������"
objDict.Add "schoolrollchangeapply" ,"ѧ����Ϣ�޸�"
objDict.Add "schoolrolltransactionapply" ,"ѧ���춯����"
objDict.Add "schoolrolltransactionaudit" ,""
objDict.Add "schoolrolltransactiontime" ,"ѧ���춯ʱ��"
objDict.Add "schoolrollupdatetime" ,"ѧ����Ϣ�䶯ʱ�����"
objDict.Add "score" ,"�ɼ�"
objDict.Add "senioritymanagement" ,"����-->�����⿼-->�����⿼�ʸ�"
objDict.Add "senioritymanagement_coursemodule" ,""
objDict.Add "senioritymanagement_specialtysbaseinfo" ,""
objDict.Add "sequence" ,""
objDict.Add "specialtysbaseinfo" ,"רҵ?������Ϣʵ��"
objDict.Add "student" ,"ѧ����"
objDict.Add "student_course" ,""
objDict.Add "studentchange" ,"ѧ����Ϣ������¼"
objDict.Add "studentinfochangerecord" ,"ѧ��������Ϣ�޸ļ�¼"
objDict.Add "studentnewinfo" ,"ѧ���޸����ݣ�����Ϣ��"
objDict.Add "studentnum" ,"ѧ���м��"
objDict.Add "studentoldinfo" ,"ѧ���޸�ԭ��Ϣ"
objDict.Add "studentphoto" ,"ѧ����Ƭ"
objDict.Add "t_course_teacher" ,""
objDict.Add "t_schedule" ,""
objDict.Add "teacher" ,"��ʦ��Ϣ��"
objDict.Add "teachercourse" ,"�γ̷�����ʦ��"
objDict.Add "teachercourse_berkeleyspecialtys" ,""
objDict.Add "teachercourse_specialtysbaseinfo" ,""
objDict.Add "teachercourse_teacher" ,""
objDict.Add "teachercourse_teacherrole" ,""
objDict.Add "teacherrole" ,"�γ���ʦȨ�ޱ�"
objDict.Add "teachertype" ,"��ʦ����"
objDict.Add "testscore" ,"���Գɼ�"
objDict.Add "testscorelogin" ,"���Գɼ��ܱ�"
objDict.Add "textbookreservemgt" ,"Ԥ������"
objDict.Add "textbookreservemgt_student" ,""
objDict.Add "textbookreservetimemgt" ,"�̲�Ԥ��ʱ�����"
objDict.Add "textbooktype" ,"�̲�����--�����д���"
objDict.Add "textbookversion" ,"�̲�"
objDict.Add "textbookversion_course" ,"�γ̲̽�"
objDict.Add "textbookversion_specialtysbaseinfo" ,"�̲�רҵ"
objDict.Add "textbookversion_student" ,"�̲�ѧ��"
objDict.Add "textbookversionmgt" ,"�̲İ汾�����"
objDict.Add "textbookversionmgt_course" ,""
objDict.Add "tmp_score" ,""
objDict.Add "versiontype" ,"�̲İ汾����"

' Get the current active model
Dim model
Dim opt
Set model = ActiveModel
If (model Is Nothing) Or (Not model.IsKindOf(PdPDM.cls_Model)) Then
   MsgBox "The current model is not a PDM model."
Else
Set opt = model.GetModelOptions()
   opt.EnableNameCodeTranslation = true
   opt.save
   opt.UpdateModelOptions ' need to call this you have made changes
    
   ModifyProperties model
End If


'-----------------------------------------------------------------------------
' Display tables properties defined in a folder
'-----------------------------------------------------------------------------
Sub ModifyProperties(package)
   ' Get the Tables collection
   Dim ModelTables
   Set ModelTables = package.Tables
   MsgBox "The model or package '" + package.Name + "' contains " + CStr(ModelTables.Count) + " tables."

   ' For each table
   Dim noTable
   Dim tbl
   Dim bShortcutClosed
   Dim Desc
   noTable = 1
   For Each tbl In ModelTables
      If IsObject(tbl) Then
         bShortcutClosed = false
         If tbl.IsShortcut Then
            If Not (tbl.TargetObject Is Nothing) Then
               Set tbl = tbl.TargetObject
            Else
               bShortcutClosed = true
            End If
         End If

         Desc = "Table " + CStr(noTable) + ":"
         If Not bShortcutClosed Then
		    if objDict.Exists(tbl.Name) then
             if objDict(tbl.Name)<>"" then
			      tbl.Name=objDict(tbl.Name)
			      Desc= "have find it"
              end if
			  end if
         Else
            Desc = Desc + vbCrLf + "The target object of the table shortcut "   + tbl.Code + " is not accessible."
         End If
         'MsgBox Desc
      Else
         MsgBox "Not an object!"
      End If
      noTable = noTable + 1
      
      If noTable > 305 Then
         Exit For
      End If
   Next
   
 
End Sub
