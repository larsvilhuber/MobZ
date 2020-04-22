%include(/ssgprojects/project0002/Mobz/programs/config.sas) ;

    * Mobility Zones (MobZ);
* Execute control program to run selected modules;	
options  mlogic symbolgen spool;
* Modules, set to 1 to run, otherwise 0;	

/*************************************
FURTHER ANALYSIS
            
module_graph runs the %review for jtw1990, over
a wide             
**************************************/    
%let run_cutoff = 0 ; 
%let run_graph = 0;


/**********************************
  BOOTSTRAP_STATISTICS PERTURBS THE FLOWS 
          AND REDOES CLUSTERING AND REVIEW 
***********************************/            
%let run_bootstrap_statistics =0   ; 

             
%let run_comstat=0 ;
    
/*********************************
    SETTING MACROS FOR RUNS
********************************/        

* Cluster threshold;
%let cutoff=0.9385 ; /*national cutoff for their way*/
    
* Cutoffs ;
    %let cutoff_bottom = 0.8 ;
    %let cutoff_top = 1.0 ;
    %let ci90 = 1.645 ;
    
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
    log="&dirprog./programs/modules/20.analysis/module_&modname..log" new
    print="&dirprog./programs/modules/20.analysis/module_&modname..lst" new;
run;
%include "&dirprog./programs/modules/20.analysis/module_&modname..sas";	

%end;
%mend runmod;

* Create one for each module;

%runmod(&run_graph.,graph);

%runmod(&run_bootstrap_statistics., bootstrap) ;

%runmod(&run_cutoff.,cutoff) ;
%runmod(&run_comstat.,comstat) ;    

%mend runall;
* run all;
%runall;
