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
objDict.Add "awardtypes" ,"奖励类型表"
objDict.Add "baseinfo" ,"招生模块?基础数据（包括层次?门类?学科）"
objDict.Add "berkeleyspecialtys" ,"分校专业实体"
objDict.Add "classes" ,"班级对象"
objDict.Add "cooperationcollege" ,"合作高校表"
objDict.Add "course" ,"课程信息表"
objDict.Add "courseadditional" ,"教务-->专业规则/教学计划-->指导性专业规则-->-->课程模块-->课程"
objDict.Add "coursecontrol" ,"课程申请时间控制"
objDict.Add "coursemodule" ,"教务--模块课程"
objDict.Add "courseselecteddetail" ,"选课详情"
objDict.Add "courseselectperiod" ,"选课时间"
objDict.Add "degree" ,"学位信息"
objDict.Add "degreeapplydate" ,"学位申请时间"
objDict.Add "degreebatch" ,"学位批次"
objDict.Add "degreecourses" ,"学位课程表"
objDict.Add "degreeenglish" ,"学位英语规则"
objDict.Add "degreeenglishs" ,"学位英语"
objDict.Add "degreepunishment" ,"惩罚规则"
objDict.Add "degreerule" ,"学位规则信息"
objDict.Add "department" ,"部门"
objDict.Add "educationalsystem" ,"招生--基础数据--学制"
objDict.Add "educationbackg" ,"学历信息表"
objDict.Add "entrolscore" ,"招生--入学测试成绩"
objDict.Add "evaluatetype" ,"评价管理--评价"
objDict.Add "evaluation" ,"评价管理--评价2"
objDict.Add "evaluationanswer" ,"评价记录表"
objDict.Add "evaluationpart" ,"找不到对应的实体"
objDict.Add "evaluationpartexam" ,"找不到对应的实体"
objDict.Add "evaluationrecord" ,"单题评价记录"
objDict.Add "examinee" ,"考生信息"
objDict.Add "exemptionapply" ,"教务-->免修免考-->审批申请--> 免修免考审批申请"
objDict.Add "exemptionapply_photo" ,""
objDict.Add "exemptionscore" ,"教务-->免修免考-->免修免考成绩实体"
objDict.Add "exemptiontime" ,"免修免考申请时间实体"
objDict.Add "exemptiontype" ,"教务-->免修免考类型"
objDict.Add "finalaudit" ,"学生复审对象"
objDict.Add "firstaudit" ,"入学资格初审对象"
objDict.Add "graduation" ,"毕业申请审批"
objDict.Add "graduationapplydate" ,"毕业申请时间"
objDict.Add "message" ,"消息"
objDict.Add "messagebody" ,"消息体"
objDict.Add "messagetype" ,"消息类型"
objDict.Add "openspecialty" ,"开设专业管理"
objDict.Add "organization" ,"机构实体"
objDict.Add "orgxcoursescontrol" ,"教务-->专业规则/教学计划-->执行专业管理权限?执行专业管理权限(对选修课程可以调整)"
objDict.Add "picture" ,"照片实体"
objDict.Add "professionalcoursemodule" ,"指导性专业规则-->课程模块?课程模块实体"
objDict.Add "professionalcoursemodule_courseadditional" ,""
objDict.Add "professionalcoursemodule_professionalsimilarcourse" ,""
objDict.Add "professionalrules" ,"专业指导规则表"
objDict.Add "professionalsimilarcourse" ,"指导性专业规则-->课程模块 -->相似课程"
objDict.Add "professionaltime" ,"教学计划--专业规则时间控制"
objDict.Add "professionaltitle" ,"职称信息表"
objDict.Add "punishmenttypes" ,"惩罚类型表"
objDict.Add "questionnaire" ,"评价管理--问卷"
objDict.Add "recruitbacth" ,"招生--基础数据--招生批次"
objDict.Add "recruitplanallot" ,""
objDict.Add "recruitplanbranch" ,"招生计划分配人数(分校)"
objDict.Add "recruitplanfill" ,""
objDict.Add "recruitplanset" ,"招生计划基实体"
objDict.Add "recruittype" ,"招生--基础数据--学生类型实体"
objDict.Add "schoolrollawardpunishmentapply" ,"学籍奖惩申请"
objDict.Add "schoolrollawardpunishmentaudit" ,"学籍奖惩申请审批"
objDict.Add "schoolrollchangeapply" ,"学籍信息修改"
objDict.Add "schoolrolltransactionapply" ,"学籍异动申请"
objDict.Add "schoolrolltransactionaudit" ,""
objDict.Add "schoolrolltransactiontime" ,"学籍异动时间"
objDict.Add "schoolrollupdatetime" ,"学籍信息变动时间管理"
objDict.Add "score" ,"成绩"
objDict.Add "senioritymanagement" ,"教务-->免修免考-->免修免考资格"
objDict.Add "senioritymanagement_coursemodule" ,""
objDict.Add "senioritymanagement_specialtysbaseinfo" ,""
objDict.Add "sequence" ,""
objDict.Add "specialtysbaseinfo" ,"专业?基本信息实体"
objDict.Add "student" ,"学生表"
objDict.Add "student_course" ,""
objDict.Add "studentchange" ,"学生信息更动记录"
objDict.Add "studentinfochangerecord" ,"学生基本信息修改记录"
objDict.Add "studentnewinfo" ,"学籍修改内容（新信息）"
objDict.Add "studentnum" ,"学号中间表"
objDict.Add "studentoldinfo" ,"学籍修改原信息"
objDict.Add "studentphoto" ,"学生照片"
objDict.Add "t_course_teacher" ,""
objDict.Add "t_schedule" ,""
objDict.Add "teacher" ,"教师信息表"
objDict.Add "teachercourse" ,"课程分配老师表"
objDict.Add "teachercourse_berkeleyspecialtys" ,""
objDict.Add "teachercourse_specialtysbaseinfo" ,""
objDict.Add "teachercourse_teacher" ,""
objDict.Add "teachercourse_teacherrole" ,""
objDict.Add "teacherrole" ,"课程老师权限表"
objDict.Add "teachertype" ,"教师类型"
objDict.Add "testscore" ,"考试成绩"
objDict.Add "testscorelogin" ,"考试成绩总表"
objDict.Add "textbookreservemgt" ,"预定管理"
objDict.Add "textbookreservemgt_student" ,""
objDict.Add "textbookreservetimemgt" ,"教材预定时间管理"
objDict.Add "textbooktype" ,"教材类型--教务中创建"
objDict.Add "textbookversion" ,"教材"
objDict.Add "textbookversion_course" ,"课程教材"
objDict.Add "textbookversion_specialtysbaseinfo" ,"教材专业"
objDict.Add "textbookversion_student" ,"教材学生"
objDict.Add "textbookversionmgt" ,"教材版本管理表"
objDict.Add "textbookversionmgt_course" ,""
objDict.Add "tmp_score" ,""
objDict.Add "versiontype" ,"教材版本类型"

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
