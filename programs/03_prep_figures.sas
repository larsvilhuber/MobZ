* Mobility Zones (MobZ);
* Execute control program to run selected modules;	
options  mlogic symbolgen spool fullstimer;
* Modules, set to 1 to run, otherwise 0;	

%include "config.sas" ;

/*************************************
FURTHER ANALYSIS
            
module_graph runs the %review for jtw1990, over
a wide             
**************************************/    
%let run_cutoff = 1 ; 
%let run_graph = 0;


/*-----------------------------------------------------------
  Structure of this program
  - the macro %runall will do a bit of config, and run module macros
  - module macros are in the second part of the file
  - the actual calls are at the end
  - some macros that actually do stuff are in the &dirprog/macros directory
-------------------------------------------------------------*/

/* Overall Macro */

* Modules;
%macro runmod(val,modname);/*========================================*/
%put module &modname.;

%if (&val.=1) %then %do;
x mkdir -p &logdir.;
proc printto
    log="&logdir./module_&modname..log" new
    print="&logdir./module_&modname..lst" new;
run;

/* run the module */
%&modname.;	
	
%end;
%mend runmod; /*========================================*/


/* individual modules */

%macro m_cutoff;

    %cutoff(jtw1990,0.90,0.97,step=5 ) ;               

    proc export data=OUTPUTS.cluster_cutoff_jtw1990 
            outfile = "&diroutputs./clusters_cutoff_jtw1990.dta" replace; 
    run;

    
    proc export data=clusnum_cutoff 
            outfile = "&diroutputs./clusnum_cutoff.dta" replace; 
    run;                    
    
    proc print data=clusnum_cutoff;
    run;
%mend;

%macro m_graph;
    %graph_cutoff(jtw1990,&cutoff_bottom.,&cutoff_top.,graphpath=&dirfig.);
%mend;

* run each module ;

%runmod(&run_cutoff, m_cutoff );  
%runmod(&run_graph., m_graph ) ;

