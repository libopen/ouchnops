delete eas_tcp_segmentcourses where orgcode in ('511','320','321','410')

delete eas_tcp_segmsemecourses where orgcode in ('511','320','321','410');
commit;


delete eas_tcp_learcentcourse where segorgcode in ('511','320','321','410');
commit;


delete eas_tcp_learcentsemecour where orgcode in ('511','320','321','410');
commit;



delete eas_tcp_implementation where orgcode in ('511','320','321','410');
delete eas_tcp_implmodulecourse where segmentcode in ('511','320','321','410');
commit;


select  seq_schroll_absence.nextval from dual

delete eas_schroll_absence where segmentcode in ('511','320','321','410');
commit;


delete eas_exmm_netexamscore where segmentcode in ('511','320','321');
---12791
commit;

delete eas_expt_exptnetexam where segmentcode in ('511','320','321');
---12791
commit;