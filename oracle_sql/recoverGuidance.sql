-- select * from eas_tcp_guidance where tcpcode in (select * from table(splitstr
('180901403030200,180901403030200'
,',')))

declare 
 i_tcpcode EAS_TCP_IMPLEMENTATION.TCPCODE %type;
begin
--select * from 
for v_r in (
 select * from table(splitstr
('180901403030200,180901403030200'
,','))
)
loop
 i_tcpcode := v_r.column_value;
delete EAS_TCP_Execution where tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('Eas_tcp_execution' ||  SQL%ROWCOUNT);
--select * from 
delete EAS_TCP_ExecOnRule where tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('EAS_TCP_ExecOnRule' ||  SQL%ROWCOUNT);
--select * from 
delete EAS_TCP_ExecModuleCourse where tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('EAS_TCP_ExecModuleCourse' ||  SQL%ROWCOUNT);
--select * from
delete  EAS_TCP_ExecOnModuleRule where tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('EAS_TCP_ExecOnModuleRule' ||  SQL%ROWCOUNT);

delete EAS_TCP_MExecution where  tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('EAS_TCP_MExecution' ||  SQL%ROWCOUNT);


delete EAS_TCP_MExecModuleCourse where  tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('EAS_TCP_MExecModuleCourse' ||  SQL%ROWCOUNT);


delete EAS_TCP_MExecOnRule where  tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('EAS_TCP_MExecOnRule' ||  SQL%ROWCOUNT);

delete EAS_TCP_MExecOnModuleRule where  tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('EAS_TCP_MExecOnModuleRule' ||  SQL%ROWCOUNT);


delete EAS_TCP_ImplModuleCourse where tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('EAS_TCP_ImplModuleCourse' ||  SQL%ROWCOUNT);
--select * from 
delete EAS_TCP_ImplOnRule where tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('EAS_TCP_ImplOnRule' ||  SQL%ROWCOUNT);
--select * from 
delete EAS_TCP_ImplOnModuleRule where tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('EAS_TCP_ImplOnModuleRule' ||  SQL%ROWCOUNT);
--select * from
delete  EAS_TCP_Implementation where tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('EAS_TCP_Implementation' ||  SQL%ROWCOUNT);

update eas_tcp_guidance set state=0 where tcpcode=i_tcpcode;
DBMS_OUTPUT.PUT_LINE('eas_tcp_guidance' ||  SQL%ROWCOUNT);
--commit
DBMS_OUTPUT.PUT_LINE(sysdate);
end loop;
end  ;
