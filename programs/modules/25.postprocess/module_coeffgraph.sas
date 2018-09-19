%let graphdir = "[figuredir]" ;

proc import datafile="[datadir]/bootstrap_results.dta"
       out=WORK.bootstrap_results dbms=dta replace;



ods graphics on /imagefmt=png imagename = "1990_distribution_sas" ;
ods listing gpath = "&graphdir." ;

proc print data=bootstrap_results (obs=10) ;
run;
    
    proc sort data=bootstrap_results ;
    by iteration;
    run;

data _NULL_ ;
    set bootstrap_results;
    by iteration;
    if _N_ = 1 then call symput('true_est',beta_1990) ;
run;

proc sgplot data = bootstrap_results (where=(iteration ne 0)) noautolegend;
	histogram beta_1990  ;
	density beta_1990/
		name = "Distribution of Estimated Effect, 1990" 
		type = kernel;
run;
