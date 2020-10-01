/*************** 
This outputs files for downstream use and publication, and creates
some statistics.
****************/

%include "config.sas"/source2;

proc export data=OUTPUTS.flows_jtw1990_moe 
    outfile = "&diroutputs./flows_jtw1990_moe.csv" replace;
run;

            
proc export data=OUTPUTS.bootclusters_jtw1990_moe
            outfile = "&diroutputs./bootclusters_jtw1990_moe_new.dta"
replace ;
run;

proc export data=OUTPUTS.bootclusters_jtw1990_moe
            outfile = "&diroutputs./bootclusters_jtw1990_moe.csv"
replace ;
run;


/* this is for summary statistics */    
    
data moe_means ;
    set OUTPUTS.flows_jtw2009 ;
    moe_ratio = moe/jobsflow ; 
run;
            
proc means data=moe_means mean p25 p50 p75; 
    var moe_ratio ;
    title 'MOE Ratio, all flows';
run;            
            
proc means data=moe_means (where=(jobsflow<100)) mean p25 p50 p75; 
    var moe_ratio ;
    title 'MOE Ratio, flows<100';
run;
            
proc means data=moe_means (where=(jobsflow>=100 and jobsflow<1000))
                mean p25 p50 p75; 
    var moe_ratio ;
    title 'MOE Ratio, flows 100-1000';
run;
            
proc means data=moe_means (where=(jobsflow>=1000 and jobsflow < 10000))
                    mean p25 p50 p75; 
    var moe_ratio ;
    title 'MOE Ratio, flows 1000-10000';
run;

proc means data=moe_means (where=(jobsflow>=10000)) mean p25 p50 p75; 
    var moe_ratio ;
    title 'MOE Ratio, flows 10000+';
run;
