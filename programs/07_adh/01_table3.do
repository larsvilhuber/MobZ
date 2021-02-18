/***********************************
This regression 
***********************************/
    
include "../config.do"
cap log close 
log using "$logdir/comparison_regressions.log", replace

use "$adhdata/workfile_china.dta", clear

#delimit ; 
keep d_sh_empl_mfg d_tradeusch_pw d_tradeotch_pw_lag 
				timepwt48 czone yr /*t2000*/ statefip;
rename yr year ; 

sort czone year ;
tempfile adh_data;
save `adh_data', replace ;

use "$interwrk/finalczdata.dta", clear;
gen y2000 = year==2000;
 
keep del_L_m* IPW_uit IPW_oit czone year y2000 share_czpop ;

sort czone year ;
merge 1:1 czone year using `adh_data';

tab _merge ; 

postfile table3 str10 col1 col2 col3 col4 col5 using $interwrk/table3.dta, replace;

/********* 
   just for 1990-2000 
   Column 1 of Table 3
   *************/

ivregress 2sls d_sh_empl_mfg (d_tradeusch_pw=d_tradeotch_pw_lag) [aw=timepwt48] if year==1990, cluster(statefip);
	local beta_1 = _b[d_tradeusch] ;
	local se_1 = _se[d_tradeusch] ;
	
/************* 
  CHANGING RHS
  Column 2 of Table 3
  ****************/
ivregress 2sls d_sh_empl_mfg (IPW_uit=IPW_oit) [aw=timepwt48] if year==1990, cluster(statefip);
	local beta_4 = _b[IPW_uit] ;
	local se_4 = _se[IPW_uit] ;

/************* CHANGING LHS (not in Table 3) ****************/
ivregress 2sls del_L_m (IPW_uit=IPW_oit) [aw=timepwt48] if year==1990, cluster(statefip) ;
	local beta_5 = _b[IPW_uit] ;
	local se_5 = _se[IPW_uit] ;
	
	
/***************************
	Changing the weight
	Column 3 of Table 3
****************************/	
ivregress 2sls del_L_mprime (IPW_uit=IPW_oit) [aw=share_czpop] if year==1990,cluster(statefip) ;
	local beta_6 = _b[IPW_uit] ;
	local se_6 = _se[IPW_uit] ;
	
/***************************
	NOT CLUSTERING ON CZ
	Column 4 of Table 3
****************************/
ivregress 2sls del_L_mprime (IPW_uit=IPW_oit) [aw=share_czpop] if year==1990,cluster(czone);
	local beta_7 = _b[IPW_uit] ;
	local se_7 = _se[IPW_uit] ;
	
	
post table3 ("$\Delta IPW_{cz,t}$") (`beta_1') (`beta_4') (`beta_5') (`beta_7') ;
post table3 ("")		    (`se_1') (`se_4') (`se_5') (`se_7') ;
	
postclose table3 ;

foreach coeff in beta se { ;
	forvalues i = 1/7 { ;
		di %5.4f ``coeff'_`i'' "    " _continue ;

	} ;
	di "" ;
} ;

use $interwrk/table3.dta;
forvalues i=2/5 { ;
	replace col`i'=round(col`i',0.0001) ;
}; 
outsheet using $interwrk/table3.csv, comma replace ; 



/**************** SHOWING RATIO OF IPW TO D_TRADEUSCH******************/

gen ratio_us = IPW_uit/d_tradeusch_pw ;
gen ratio_oth = IPW_oit/d_tradeotch_pw_lag;

sum ratio* if year == 1990, d ;

gen ratio_manu = del_L_m/d_sh_empl_mfg ;

sum ratio_manu, d ;

log close ;


