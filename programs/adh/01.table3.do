/***********************************
This regression 
***********************************/
    
cap log close 
log using "$logdir/comparison_regressions.log", replace

use "$datadir/adh_data/workfile_china.dta", clear

#delimit ; 
keep d_sh_empl_mfg d_tradeusch_pw d_tradeotch_pw_lag 
				timepwt48 czone yr /*t2000*/ statefip;
rename yr year ; 

sort czone year ;
tempfile adh_data;
save `adh_data', replace ;

use "$datadir/finalczdata.dta", clear;
gen y2000 = year==2000;
 
keep del_L_m* IPW_uit IPW_oit czone year y2000 share_czpop ;

sort czone year ;
merge 1:1 czone year using `adh_data';

tab _merge ; 

/********* just for 1990-2000 *************/

ivregress 2sls d_sh_empl_mfg (d_tradeusch_pw=d_tradeotch_pw_lag) [aw=timepwt48] if year==1990, cluster(statefip);
	local beta_1 = _b[d_tradeusch] ;
	local se_1 = _se[d_tradeusch] ;
	/*
ivregress 2sls d_sh_empl_mfg (d_tradeusch_pw=d_tradeotch_pw_lag) [aw=timepwt48] if year==1990 ;
	local beta_2 = _b[d_tradeusch] ;
	local se_2 = _se[d_tradeusch] ;*/
/************* CHANGING CZ POP WEIGHT ****************/
/*ivregress 2sls d_sh_empl_mfg (d_tradeusch_pw=d_tradeotch_pw_lag) [aw=share_czpop] if year==1990 ;
	local beta_3 = _b[d_tradeusch] ;
	local se_3 = _se[d_tradeusch] ;
*/
/************* CHANGING RHS ****************/
ivregress 2sls d_sh_empl_mfg (IPW_uit=IPW_oit) [aw=timepwt48] if year==1990, cluster(statefip);
	local beta_4 = _b[IPW_uit] ;
	local se_4 = _se[IPW_uit] ;

/************* CHANGING LHS ****************/
ivregress 2sls del_L_m (IPW_uit=IPW_oit) [aw=timepwt48] if year==1990, cluster(statefip) ;
	local beta_5 = _b[IPW_uit] ;
	local se_5 = _se[IPW_uit] ;
/************ Changing the weight ************/	
ivregress 2sls del_L_mprime (IPW_uit=IPW_oit) [aw=share_czpop] if year==1990,cluster(statefip) ;
	local beta_6 = _b[IPW_uit] ;
	local se_6 = _se[IPW_uit] ;
/********** NOT CLUSTERING ON CZ *************/
ivregress 2sls del_L_mprime (IPW_uit=IPW_oit) [aw=share_czpop] if year==1990,cluster(czone);
	local beta_7 = _b[IPW_uit] ;
	local se_7 = _se[IPW_uit] ;

foreach coeff in beta se { ;
	forvalues i = 1/7 { ;
		di %5.4f ``coeff'_`i'' "    " _continue ;

	} ;
	di "" ;
} ;



/**************** SHOWING RATIO OF IPW TO D_TRADEUSCH******************/

gen ratio_us = IPW_uit/d_tradeusch_pw ;
gen ratio_oth = IPW_oit/d_tradeotch_pw_lag;

sum ratio* if year == 1990, d ;

gen ratio_manu = del_L_m/d_sh_empl_mfg ;

sum ratio_manu, d ;

log close ;


