* Mobility Zones (MobZ);
* Execute control program to run selected modules;	
options  mlogic symbolgen spool;
* Modules, set to 1 to run, otherwise 0;	

%include "../../config.sas";
/************************
THESE MODULES PREP THE COMMUTING FLOWS  
************************/
%let run_preplodes=0;
%let run_prepjtw1990=1;
%let run_prepjtw2000=0;
%let run_prepjtw2009=1;
                                        
/*************************
Runs geoagg module for corresponding
dataset;
Creates two separate files: ctypairs_&dset.
    and reslf_&dset.                                                  
*************************/                                        

%let run_geoagglodes = 0 ;
%let run_geoaggjtw1990 =1 ; 
%let run_geoaggjtw2000 = 0 ;
%let run_geoaggjtw2009 = 1 ;       

   

/**********************
*LODES MACROS
***********************/ 
* job type;
%let jt=00;
* year ; 
%let year=2009;

* Cluster threshold;
%let cutoff=0.9385 ; /*national cutoff for their way*/

* Paths;
%let dirprog=&root.;
%let dirdata=&root.;
libname OUTPUTS "&dirdata./data";
libname GEO "&dirdata./data" ;
options sasautos="&dirprog./programs/macros" mautosource nocenter ps=1000;

%global tstamp;
%let t=%sysfunc(today());
%let tt=%sysfunc(time());
%let dstamp=%trim(%sysfunc(year(&t.),z4.))%trim(%sysfunc(month(&t.),z2.))%trim(%sysfunc(day(&t.),z2.));
%let tstamp=&dstamp._%trim(%sysfunc(hour(&tt.),z2.))%trim(%sysfunc(minute(&tt.),z2.))%trim(%sysfunc(second(&tt.),z2.));

/* Overall Macro */
%macro runall;

* Modules;
%macro runmod(val,modname);
%put module &modname.;
%if (&val.=1) %then %do;
proc printto
    log="&dirprog./programs/modules/00.dataprep/module_&modname..log" new
    print="&dirprog./programs/modules/00.dataprep/module_&modname..lst" new;
run;
%include "&dirprog./programs/modules/00.dataprep/module_&modname..sas";	
	

%end;
%mend runmod;

* Create one for each module;
%runmod(&run_prepjtw1990., prepjtw1990) ;
%runmod(&run_prepjtw2000., prepjtw2000) ;
%runmod(&run_prepjtw2009., prepjtw2009) ; 

%runmod(&run_geoaggjtw1990.,geoaggjtw1990) ;
%runmod(&run_geoaggjtw2000.,geoaggjtw2000); 
%runmod(&run_geoaggjtw2009.,geoaggjtw2009) ;


%mend runall;
* run all;
%runall;
