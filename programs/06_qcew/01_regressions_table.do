/**********************
This is the do-file that creates
the tables for Table 2 of the paper

Four regressions:
Weighted/unweighted

TS1996 commuting zones and our replicated
commuting zones
	
***************************/

include "../config.do"

local czonedataset = "${outputs}/clusters_cutoff_jtw1990.dta"
//local qcewdata = "${outputs}/qcew_county.dta"
global qcewfile = "${outputs}/qcew_county.dta"
global czone_iteration = "${interwrk}/czones_cutoff.dta"

#delimit ; 

/*********************************
First get the two czone datasets ready
**********************************/
set more off;
    use "$outputs/bootclusters_jtw1990_moe_new.dta", clear;
   
    keep fips clustername ;
    egen czone = group(clustername) ;
    
    tempfile czone_rep ;
    sort fips ;
    save `czone_rep', replace ;


    //import delimited /data/working/mobz/geo/cz90.csv , clear ;
    use "${interwrk}/czlma903", clear;
    //tostring countyfipscode, gen(fips) ;
    //replace fips = "0" + fips if length(fips) == 4 ;
    rename countyfipscode fips;
    egen czone = group(cz90) ;
    keep fips czone ;
    
    sort fips ;
    tempfile czone_ts ;
    save `czone_ts', replace;


/**********************************
 industry data
**********************************/
/* create shell here */

use $qcewfile, clear;
//destring naics2, force replace;
rename naics2 naics2char;
egen naics2 = group(naics2char);
compress fips;
tempfile qcewdata;
save `qcewdata';
 
 use `qcewdata', clear; 
 
//  destring naics2, force replace ;
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


/********************************
First, regressions with TS1990 
*********************************/

use `czone_ts', clear ;
   compress fips;
   desc fips;
   save $czone_iteration, replace;

 collapse (first) fips, by( czone) ;
      cross using `shell' ;
      tempfile shell2 ;
      save `shell2', replace ;
      

      include "$programs/06_qcew/zz_bartik_merge.do" ;
      xtset czone year; 
sum bartik_it, d;
local sd_ts = r(sd);
      areg log_uireceipt L.bartik_it i.year, absorb(czone) cluster(czone) ;
                 local beta_ts = _b[L.bartik_it] ;
                 local se_ts = _se[L.bartik_it] ;
                 local tstat_ts = _b[L.bartik_it]/_se[L.bartik_it] ;

/***
 then a weighted regression here
***/


/*******************************
Second regressions with FKV1990
*******************************/
use `czone_rep' , clear ; 
    compress fips;
    desc fips;
    save $czone_iteration, replace;

 collapse (first) fips, by( czone) ;
      cross using `shell' ;
      tempfile shell2 ;
      save `shell2', replace ;
      

      include "$programs/06_qcew/zz_bartik_merge.do" ;
      
      xtset czone year; 
sum bartik_it, d;
local sd_fkv = r(sd);
      areg log_uireceipt L.bartik_it i.year, absorb(czone) cluster(czone) ;
                 local beta_fkv = _b[L.bartik_it] ;
                 local se_fkv = _se[L.bartik_it] ;
                 local tstat_fkv = _b[L.bartik_it]/_se[L.bartik_it] ;
di "***********************************************************";
di "*********************** RESULTS ***************************";
di "BETAS:  TS   " %6.4f `beta_ts' "     FKV  " %6.4f `beta_fkv' ;
di "SES:  TS   " %6.4f `se_ts' "     FKV  " %6.4f `se_fkv' ;
di "TSTAT:  TS   " %6.4f `tstat_ts' "     FKV  " %6.4f `tstat_fkv' ;
di "SD Bartik:     " %6.4f `sd_ts' "    FKV   " %6.4f `sd_fkv' ;
di "***********************************************************";
