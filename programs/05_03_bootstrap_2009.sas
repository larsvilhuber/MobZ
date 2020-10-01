/*************** 
This creates the bootstrap for 2009 - used for a robustness check
****************/

%include "config.sas"/source2;

%let modname=bootstrap_statistics_2009;

/*===================================================================*/
/* After the first few macro command, the LOG output gets redirected */
/* search for a file with "module_bootstrap_statistics_2009" in the name !*/
/*===================================================================*/

%bootstrap_statistics(jtw2009,&bootstrap_num.,cutoff=&cutoff.) ;

            
/* proc export happens in the next program */
