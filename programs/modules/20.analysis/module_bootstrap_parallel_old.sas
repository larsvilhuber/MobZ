/*************** 
This preps the new file 
for use in the
 bootstrap macro loops
****************/
data OUTPUTS.flows_jtw1990_moe ;
    infile '[indir]/jtw1990_moe.csv' delimiter = ',' firstobs= 2;
    informat work_cty $5.;
    informat jobsflow best32. ;
    informat home_cty $5. ;
    informat flowsize best8. ;
    informat sd_ratio best32. ;
    informat mean_ratio best32. ;
    informat moe best32. ;
input work_cty jobsflow home_cty flowsize sd_ratio mean_ratio moe ;
run;                
          
                
proc print data=OUTPUTS.flows_jtw1990_moe (obs=50);
run;                                            

%bootstrap_parallel_old(jtw1990_moe,1000,cutoff=&cutoff.) ;

proc export data=OUTPUTS.bootclusters_jtw1990_moe
            outfile = '[outdir]/bootclusters_jtw1990_moe.dta' replace; 
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
