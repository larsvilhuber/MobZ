*Mobility zones;
options mlogic sybolgen spool fullstimer;

/*************************** 
SETUP FOR RUN
*****************************/

%let dirprog=/ssgprojects/project0002/MobZ/programs/
%let dirdata=/ssgprojects/project0002/MobZ/[data?]

libname OUTPUTS "&dirdata./outputs" ;
libname GEO "&dirdata/geo" ;
options sasautos="&dirprog./public_files/macros" mautosource nocenter ps=1000 sascmd='sas' autosignon ;

/********************************
RUN FROM READIN TO CLUSTER OUTPUTS
**********************************/
*readin ;
%include(module_prepjtw1990.sas) ;

*geoagg;

%geoagg(jtw1990,inlib=OUTPUTS,outlib=WORK) ;

*cluster;

%cluster(jtw1990,inlib=WORK,outlib=WORK) ;

*review (create commuting zones) ;'

%review(jtw1990,0.9418,inlib=WORK,outlib=OUTPUTS) ;

/*here we should also have the maps of the replicated and original CZs */