%macro sumstats ;


data flows_checks ;    
    set OUTPUTS.flows_jtw1990_moe ;
    flows_low = jobsflow - moe ; 
    ci_zero = (flows_low <= 0 and jobsflow > 0  ) ;
run;
    
proc means data=flows_checks SUM MEAN N  ; 
    var ci_zero jobsflow ; 
    title 'Summary of key variables' ;
run;

proc means data=flows_checks MEAN N ;
    var ci_zero jobsflow ; 
    weight jobsflow ; 
    title 'share with zero, weighted by reported jobs flow' ;
run;

proc print data=flows_checks (where=(ci_zero = 1) obs=50);
    vars flows_low ci_zero jobsflow moe ; 
run;

%let chunks = 20 ;
    
%do chunk = 0 %to %eval(&chunks.-1) ;

    /* first I need to prep for parallelization */
    data flows_jtw1990_moe_&chunk. ; 
        set OUTPUTS.flows_jtw1990_moe ; 
    run;

%end; 
/************ START II LOOP ****************/
%do ii = 1 %to 1000  %by &chunks. ;
    

/* ________________ START CHUNK LOOP ______________ */
%do chunk = 0 %to %eval(&chunks.-1) ;
    
%let jj = %eval(&ii.+&chunk.) ;
%let countyer=&jj. ; 

%if (&jj. le 1000) %then %do ; 
    
    SIGNON chunk&chunk. ;
        %syslput mywork = %sysfunc(pathname(WORK))/ remote=chunk&chunk. ;
        %syslput ii = &ii.                        / remote=chunk&chunk. ;
        %syslput jj = &jj.                        / remote=chunk&chunk. ;
        %syslput dirprog=&dirprog.                / remote=chunk&chunk. ; 
        %syslput chunk = &chunk.                  / remote=chunk&chunk. ;  
    RSUBMIT chunk&chunk. WAIT=NO ;
    options sasautos = "&dirprog./macros" mautosource fullstimer ; 
    libname MYWORK "&mywork." ; 
    
%perturb_parallel(jtw1990_moe_&chunk.,flows_pert_&jj.,&jj.,inlib=MYWORK,outlib=MYWORK) ;
    
proc summary data=MYWORK.flows_pert_&jj. ;
    var jobsflow ;
    output out = MYWORK.total_jobs_&jj. sum(jobsflow) = total_jobs ;
run;

    ENDRSUBMIT ; /* done with parallel process */
%end ; /* ___________ end j condition ___________ */
%end ; /* ___________ end chunk loop _____________ */    

WAITFOR _ALL_ 
        %do chunk = 0 %to %eval(&chunks.-1) ;
             %let j = %eval(&ii.+&chunk.) ;
             %if (&j. le 1000) %then %do ;
                    chunk&chunk. 
             %end; 
        %end; 
        ;

%put "FINISHED THE LOOP THAT STARTED FROM &ii." ;
%end; /*---------------- end of ii loop -----------------*/

data finalstats_jobs ; 
    set 
    %do ii = 1 %to 1000 ; 
        total_jobs_&ii.
    %end; 
        ;
    error_jobs = total_jobs-115006145 ;
run;
        
proc means data=finalstats_jobs mean p25 p50 p75 ; 
    var error_jobs; 
    title 'average error'  ;
run;        
        
    
%mend sumstats;

%sumstats; 
