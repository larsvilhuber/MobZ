/*************** 
This preps the new file 
for use in the
 bootstrap macro loops
****************/

%include "config.sas"/source2;

data OUTPUTS.flows_jtw1990_moe ;
    infile "&dirinterwrk./jtw1990_moe.csv" delimiter = ',' firstobs= 2;
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
    

            
                        
                
proc print data=OUTPUTS.flows_jtw1990_moe (obs=50);
run;                                            

%let modname=bootstrap_statistics;

/*===================================================================*/
/* After the first few macro command, the LOG output gets redirected */
/* search for a file with "module_bootstrap_statistics" in the name !*/
/*===================================================================*/

%bootstrap_statistics(jtw1990_moe,&bootstrap_num.,cutoff=&cutoff.) ;
            
            
proc export data=OUTPUTS.bootclusters_jtw1990_moe
            outfile = "&diroutputs./bootclusters_jtw1990_moe_new.dta"
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
