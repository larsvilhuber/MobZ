/**************************

This is the do-file loop

It has three steps:

2. Decide which czone defn to use;

3. Aggregate county data into czones

4. calculate bartik, outcomes

5. Run regressions of avg earnings on bartik

****************************/

include "../config.do"
include "$programs/config-bootstrap.do"

#delimit ; 
set more off ; 
  local czonedataset = "${outputs}/bootclusters_jtw1990_moe_new.dta" ;
 global czone_iteration = "${interwrk}/czones_qcew.dta" ;
// local qcewdata = "$qcewdata/qcew_county.dta" ;
 global qcewfile = "$outputs/qcew_county.dta";
 
 /* create shell here */
use $qcewfile, clear;
//destring naics2, force replace;
rename naics2 naics2char;
egen naics2 = group(naics2char);
compress fips;
tempfile qcewdata;
save `qcewdata';
 
 use `qcewdata', clear; 
 
//  destring naics2, replace ;
 collapse (first) fips, by(naics2 year) ;
 keep naics2 year ;
 tempfile shell;
 save `shell', replace;
 
 /* create industry-year data here */
 use `qcewdata', clear; 
 // destring naics2, force replace ; 
 collapse (sum) EMP_jt = annual_avg_emplvl, by(naics2 year) ;
sort naics2 year ; 
xtset naics2 year ;

gen delta_emp_jt = log(EMP_jt) - log(L.EMP_jt) ;

tempfile industry_by_year ;
save `industry_by_year' , replace ;
 
use "`czonedataset'", clear ;

tempname czoneresults;
tempfile bartik_regs;

                                       
/**************SET UP POSTFILE FIRST **************/
postfile `czoneresults' iteration beta se tstat using `bartik_regs', replace;


/*************** FIRST SET OF REGRESSIONS ************/
use "`czonedataset'", clear ;
      qui egen czone = group(clustername) ;
      keep fips czone ;
      sort fips ;
      save "$czone_iteration", replace;
      
      collapse (first) fips, by( czone) ;
      cross using `shell' ;
      tempfile shell2 ;
      save `shell2', replace ;
      

      include "$programs/06_qcew/zz_bartik_merge.do" ;
      
      xtset czone year; 

      areg log_uireceipt L.bartik_it i.year, absorb(czone) cluster(czone) ;
                 local tstat = _b[L.bartik_it]/_se[L.bartik_it] ;
      post `czoneresults' (0) (_b[L.bartik_it]) (_se[L.bartik_it]) (`tstat') ; 
di "done with first step" ; 

cap erase `bartik' ;
cap erase `base_year' ;
cap erase `mergefile' ;

/* loop here over all possible values */

forvalues i = 1/$bootstrap_num { ;
      di "starting iteration `i'" ;
      use "`czonedataset'", clear ;
      qui egen czone = group(clustername_`i') ;
                       tab czone ; 
      keep fips czone ;
      sort fips ;
      save "$czone_iteration", replace;
      
      collapse (first) fips, by( czone) ;
      cross using `shell' ;
      save `shell2', replace ;
      

      include "$programs/06_qcew/zz_bartik_merge.do" ;
      
      xtset czone year; 

      areg log_uireceipt L.bartik_it i.year, absorb(czone) cluster(czone) ;
                 local tstat = _b[L.bartik_it]/_se[L.bartik_it] ;
      post `czoneresults' (`i') (_b[L.bartik_it]) (_se[L.bartik_it]) (`tstat') ; 


cap erase `bartik' ;
cap erase `base_year' ;
cap erase `mergefile' ;

} ; 

postclose `czoneresults' ; 

use `bartik_regs', clear ; 
sum beta se tstat ;

save "$interwrk/bartik_results_moe_new.dta", replace; 

                                                                     
