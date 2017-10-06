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

global dodir ""
global clusdir = ""
global graphdir ""
global outgraph ""
local czonedataset = "${clusdir}/clusters_cutoff_jtw1990.dta"
global czone_iteration = "${clusdir}/czones_cutoff.dta"
local ipw_regs "${clusdir}/cutoff_post.dta"
global datadir = "" 
 local qcewdata = "$datadir/qcew_county.dta"

/* create shell here */
 #delimit ; 
 use `qcewdata', clear; 
 
  destring naics2, replace ;
 collapse (first) fips, by(naics2 year) ;
 keep naics2 year ;
 tempfile shell;
 save `shell', replace;
 
 /* create industry-year data here */
 use `qcewdata', clear; 
 destring naics2, force replace ; 
 collapse (sum) EMP_jt = annual_avg_emplvl, by(naics2 year) ;
sort naics2 year ; 
xtset naics2 year ;

gen delta_emp_jt = log(EMP_jt) - log(L.EMP_jt) ;

tempfile industry_by_year ;
save `industry_by_year' , replace ;
 
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
tempname czoneresults;
tempfile bartik_regs;

postfile `czoneresults' cutoff beta se  using `bartik_regs', replace;


foreach i in `values' { ;
         di "`i'";
         local cutoff= `i'/10000 ;
         	use "`czonedataset'", clear;
		egen czone = group(clus`i') ;
		keep fips czone;
		sort fips ;
		
		save "$czone_iteration", replace;
                collapse (first) fips, by(czone) ;
                cross using `shell' ;
                tempfile shell2 ;
                save `shell2', replace ;

         include "$dodir/bartik_merge.do" ;

         xtset czone year ;

         areg log_uireceipt L.bartik_it i.year, absorb(czone) cluster(czone) ;

         post `czoneresults' (`cutoff') (_b[L.bartik_it]) (_se[L.bartik_it]) ;

          cap erase `bartik' ;
          cap erase `base_year' ;
          cap erase `mergefile' ;
                        



} ;                        

postclose `czoneresults' ;

use `bartik_regs', clear ;

sum beta se cutoff ;

save "$datadir/bartik_results_cutoff.dta", replace; 
