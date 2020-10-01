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

/* the proc export happens in the next program */            
            
