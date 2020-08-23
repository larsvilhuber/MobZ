/**********************
This is the do-file loop

It has three steps

1. Calculate the aggregate data
	(national level)

2. Decide which czone defn to use

3. Aggregate cty data to czone

4. Run regressions of delM on delIPW, 
	store regressions.
	
***************************/

include "../config.do"
include "$programs/config-bootstrap.do"

/* local configuration */
local czonedataset = "${outputs}/bootclusters_jtw1990_moe_new.dta"
global czone_iteration = "${interwrk}/czones.dta" 
global dodir "${programs}/07_adh/"


di "`czonedataset'" 
include "$dodir/zz_aggregatedata.do"
set more off
#delimit ;

use "`czonedataset'", clear ;
des ; 
tempname czoneresults;
tempfile ipw_regs;

postfile `czoneresults' iteration beta_1990 se_1990 tstat_1990
                                  beta_2000 se_2000 tstat_2000
                                  beta_all se_all tstat_all
			using `ipw_regs', replace ;
			
* first, run the legitimate regressions ;
	* step2 ;
	use "`czonedataset'", clear;
		*rename home_cty fips ;
		egen czone = group(clustername) ;
		keep fips czone;
		sort fips ;
		save "$czone_iteration", replace; 
	
	*step3 ;
	include "$dodir/zz_ctymerge.do";
		
	*step4 ; 
	ivregress 2sls del_L_mprime (IPW_uit = IPW_oit ) if year == 1990 [weight=share_czpop];
		local beta90 = _b[IPW_uit] ;
                local se90 _se[IPW_uit] ;
	ivregress 2sls del_L_mprime (IPW_uit = IPW_oit ) if year == 2000 [weight=share_czpop];
		local beta00 = _b[IPW_uit] ;
                local se00 = _se[IPW_uit] ;
	ivregress 2sls del_L_mprime (IPW_uit = IPW_oit ) y2000 [weight=share_czpop] ;
		local betaall = _b[IPW_uit] ;
                local seall = _se[IPW_uit] ;

        foreach yr in 90 00 all { ;
                local tstat`yr' = `beta`yr''/`se`yr'' ;                                 
        };

	post `czoneresults' (0) (`beta90') (`se90') (`tstat90')
                                (`beta00') (`se00') (`tstat00')
                                (`betaall') (`seall') (`tstatall') ;

/* 
here we are estimating effects with our replicated CZs - we need to find
the optimal level before running this for real.
*/	
	
forvalues i = 1/$bootstrap_num {;
        di "ITERATION IS `i', TIME IS $S_TIME on $S_DATE" ;
	* step2 ;
	use "`czonedataset'", clear;
		egen czone = group(clustername_`i') ;
		*rename home_cty cty_fips ;
		keep fips czone;
		sort fips ;
		save "$czone_iteration", replace; 
		
	*step3 ;
	include "$dodir/zz_ctymerge.do";
		
	*step4 ; 
	ivregress 2sls del_L_mprime (IPW_uit = IPW_oit ) if year == 1990 [weight=share_czpop];
		local beta90 = _b[IPW_uit] ;
                local se90 _se[IPW_uit] ;
	ivregress 2sls del_L_mprime (IPW_uit = IPW_oit ) if year == 2000 [weight=share_czpop];
		local beta00 = _b[IPW_uit] ;
                local se00 = _se[IPW_uit] ;
	ivregress 2sls del_L_mprime (IPW_uit = IPW_oit ) y2000 [weight=share_czpop] ;
		local betaall = _b[IPW_uit] ;
                local seall = _se[IPW_uit] ;

        foreach yr in 90 00 all { ;
                local tstat`yr' = `beta`yr''/`se`yr'' ;                                 
        };

	post `czoneresults' (`i') (`beta90') (`se90') (`tstat90')
                                (`beta00') (`se00') (`tstat00')
                                (`betaall') (`seall') (`tstatall') ;                      


} ; 

postclose `czoneresults' ;

use `ipw_regs', clear; 

list ;

sum beta_1990 beta_2000 beta_all, d;

save "$interwrk/bootstrap_results.dta", replace ;

*erase `czoneresults' ;
erase `ipw_regs' ;
/* also create some graphs etc. (next dofile)*/
    
