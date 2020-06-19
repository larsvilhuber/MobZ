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
cap log close
log using cutoff_loop.log, replace 

local czonedataset = "${clusdir}/clusters_cutoff_jtw1990.dta"
global czone_iteration = "${clusdir}/czones_cutoff.dta"
local ipw_regs "${clusdir}/cutoff_post.dta"


include "$dodir/replication/iteration/aggregatedata.do"



set more off
#delimit ;

tempname czoneresults;

use "`czonedataset'", clear ; 

/***********************
Creating string of values to 
loop over
***********************/
local values = "" ;

foreach clus of varlist clus* { ;
	di "`clus'" ;
	local val = real(subinstr("`clus'","clus","",.)) ;
	di "`val'" ;
	local values = "`values' `val'" ;
} ;

postfile `czoneresults' cutoff beta_1990 se_1990 F_90 beta_2000 se_2000 beta_all se_all
                               iqr_1990 iqr_2000 iqr_all
			using `ipw_regs', replace ;
			
/* 
missing step: estimate effects using our "replicated" Commuting Zones, which
aren't exactly the same 
*/	
	di "`values'" ;
foreach i in `values'  { ; 
	di "`i'" ;
	local cutoff = `i'/10000 ;
	* step2 ;
	use "`czonedataset'", clear;
		egen czone = group(clus`i') ;
		keep fips czone;
		sort fips ;
		tempfile czone;
		save "$czone_iteration", replace; 
		
	*step3 ;
	include "$dodir/county_merge.do";
	
	qui sum IPW_uit if year == 1990, d; 
		local iqr_1990 = r(p75) - r(p25) ;
	qui sum IPW_uit if year == 2000, d; 
		local iqr_2000 = r(p75) - r(p25) ;
	qui sum IPW_uit if year>=1990 & year<=2000,d ; 
		local iqr_all = r(p75) - r(p25) ;
	
	*step4 ; 
	ivregress 2sls del_L_mprime (IPW_uit = IPW_oit ) if year == 1990 [weight=share_czpop];
		local beta90 = _b[IPW_uit] ;
                local se90 = _se[IPW_uit] ;

                qui estat firststage;
                matrix A = r(singleresults);
                local F_90 = A[1,4] ;
                         
                         
	ivregress 2sls del_L_mprime (IPW_uit = IPW_oit ) if year == 2000 [weight=share_czpop];
		local beta00 = _b[IPW_uit] ;
                local se00 = _se[IPW_uit];
	ivregress 2sls del_L_mprime (IPW_uit = IPW_oit ) y2000 [weight=share_czpop] ;
		local betaall = _b[IPW_uit] ;
                local seall = _se[IPW_uit] ;

	post `czoneresults' (`cutoff') (`beta90') (`se90') (`F_90') (`beta00') (`se00') (`betaall') (`seall')
									(`iqr_1990') (`iqr_2000') (`iqr_all');

} ; 

postclose `czoneresults' ;

log close ;

end;
