* Mobility Zones (MobZ);
* Execute control program to run selected modules;	
options  mlogic symbolgen spool;
* Modules, set to 1 to run, otherwise 0;	

%include "config.sas";

/************************
THESE MODULES PREP THE COMMUTING FLOWS  
************************/
%let run_prepjtw1990=1;
%let run_prepjtw2009=1;
                                        
/*************************
Runs geoagg module for corresponding
dataset;
Creates two separate files: ctypairs_&dset.
    and reslf_&dset.                                                  
*************************/                                        

%let run_geoaggjtw1990 =1 ; 
%let run_geoaggjtw2009 = 1 ;       


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
proc printto
    log="&dirprog./modules/00.dataprep/module_&modname..log" new
    print="&dirprog./modules/00.dataprep/module_&modname..lst" new;
run;

/* run the module */
%&modname.;	
	
%end;
%mend runmod; /*========================================*/


/* individual modules */

%macro module_prepjtw1990;
    
    data OUTPUTS.flows_jtw1990 (keep = home_cty work_cty jobsflow);
    	infile "&raw./1990jtw_raw.txt"  ;
    	/* Raw 1990 JTW file is here: https://www.census.gov/hhes/commuting/files/1990/resco/USresco.txt */
    	length work_cty $5. ;
    	input h_st $1-2 h_cty $4-6 w_st $23-25 w_cty $27-29 jobsflow 46-54 ;
    	if substr(w_st,1,1) = '0' ; /*This gets rid of all foreign commutes */
    	home_cty = h_st||h_cty ;
    	work_cty = substr(w_st,2,2)||w_cty ; 
    	if home_cty ne 30113; /*Gets rid of Yellowstone*/
    run ;
    
    
    proc contents data = OUTPUTS.flows_jtw1990 ; 
    run ; 
	proc export data=OUTPUTS.flows_jtw1990 outfile= "&root./data/flows1990.dta" replace; 
	run;                

%mend module_prepjtw1990; 



%macro module_czones;

    data OUTPUTS.cz1990 (keep = cty cz1990) ;
    	length cty $5. ;
    	infile "&root./raw/czones.csv" dsd  delimiter = ',' termstr=lf  ;
    	/* Commuting zones are here: https://www.ers.usda.gov/webdocs/DataFiles/Commuting_Zones_and_Labor_Market_Areas__17970//czlma903.xls */
    	input ctycode $ cz1990 $ ;
    	if cz1990 ne "CZ90"; 
    	cty = ctycode ; 
    run ; 		
    
    proc sort data = OUTPUTS.cz1990 ;
    	by cty ;
    run ;	
    
    proc print data = OUTPUTS.cz1990 ; 
    run ; 

%mend module_czones;



%macro module_prepjtw2009;

    data OUTPUTS.flows_jtw2009 (keep = home_cty work_cty jobsflow moe);
    	infile "&raw./jtw2009_2013.csv" dsd delimiter = ',' firstobs=2 ;
    	length work_cty $5. home_cty $5.;
    	input h_st $ h_cty $ w_st $ w_cty $ jobsflow moe	 ;
    	if substr(w_st,1,1) = '0' or
    	    substr(w_st,1,1) = '7' or substr(h_st,1,1)='7'; 
    	    /*This gets rid of all foreign commutes and territories.*/
    	home_cty = trim(h_st)||trim(h_cty)	 ;
    	work_cty = substr(w_st,2,2)||trim(w_cty)	 ; 
    run ;
    
    proc contents data = OUTPUTS.flows_jtw2009 ; 
    run ; 
    
    proc print data = OUTPUTS.flows_jtw2009 (obs = 40) ;
    run;  

%mend module_prepjtw2009;


%macro geoaggjtw1990;
    %geoagg(jtw1990) ;	
%mend;
%macro geoaggjtw2009;
    %geoagg(jtw2009) ;
%mend;



* Run each module;
%runmod(&run_prepjtw1990., module_prepjtw1990) ;
%runmod(&run_prepjtw1990., module_czones);
%runmod(&run_prepjtw2009., module_prepjtw2009) ; 

%runmod(&run_geoaggjtw1990.,geoaggjtw1990) ;
%runmod(&run_geoaggjtw2009.,geoaggjtw2009) ;

