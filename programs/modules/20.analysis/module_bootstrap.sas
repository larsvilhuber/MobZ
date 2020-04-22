/*************** 
This preps the new file 
for use in the
 bootstrap macro loops
****************/

data OUTPUTS.flows_jtw1990_moe ;
    infile '/data/working/mobz/jtw1990/jtw1990_moe.csv' delimiter = ',' firstobs= 2;
    informat work_cty $5.;
    informat jobsflow best32. ;
    informat home_cty $5. ;
    informat flowsize best8. ;
    informat sd_ratio best32. ;
    informat mean_ratio best32. ;
    informat draw best8. ;
    informat moe best32. ;
input work_cty jobsflow home_cty flowsize sd_ratio mean_ratio draw moe ;
run;                
    
    /*
proc import datafile= '/data/working/mobz/jtw1990/jtw1990_moe.csv'
            out=OUTPUTS.flows_jtw1990_moe 
            dbms=csv replace; 
run;    
*/

proc export data=OUTPUTS.flows_jtw1990_moe 
            outfile ='/data/working/mobz/outputs/flows_1990_stats.dta'
            replace ;
run;
            
proc export data=OUTPUTS.flows_jtw2009
            outfile ='/data/working/mobz/outputs/flows_2009_stats.dta'
            replace ;
run;
            
                        
                
proc print data=OUTPUTS.flows_jtw1990_moe (obs=50);
run;                                            

%bootstrap_statistics(jtw1990_moe,1000,cutoff=&cutoff.) ;
*%bootstrap_statistics(jtw2009,1000,cutoff=&cutoff.) ;
/*
proc export data=OUTPUTS.bootclusters_jtw1990_moe 
            outfile = '/data/working/mobz/outputs/bootclusters_jtw1990_moe.dta' replace; 
run;
*/
            
            
proc export data=OUTPUTS.bootclusters_jtw1990_moe
            outfile = '/data/working/mobz/outputs/bootclusters_jtw1990_moe_new.dta'
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
    title 'MOE Ratio, flows 10000+'
run;
