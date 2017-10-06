/************************************
This do-file creates graphs 

************************************/

global dodir ""
global clusdir = ""
global datadir "" 
global graphdir ""
global outgraph ""

#delimit ; 
foreach dset in moe moe_new { ; 

use "$datadir/bartik_results_`dset'.dta", clear;


sort iteration ; 
local true_est = beta[1] ;
di "`true_est'";
local true_se = se[1] ;
di "`true_se'";
local upper = `true_est'+(1.96*`true_se') ;
local lower = `true_est'-(1.96*`true_se');



preserve ; 


sum tstat if iteration == 0 ; 
local actual_tstat = r(mean) ;
keep if iteration!=0 ;
sort tstat;  

di " The 2.5th and 97.5th percentiles of the t-distribution statistics are " %6.4f tstat[25] 
    "   and  " %6.4f tstat[975] ;

local lower_bound = tstat[25];
local upper_bound = tstat[975];

restore ; 

/**************************************
graphing beta coefficients
***************************************/

twoway (hist beta if iteration!=0 )
	(kdensity beta if iteration!=0)
	(scatteri 0 `true_est' 9 `true_est', 
			recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
	saving("$graphdir/beta_bartik_distribution.gph", replace) 
	xtitle("Estimated Coefficient")
	ytitle("Density")
	title("Estimated effect of labor demand on UI Receipt")
	legend(off)
	;
	
	graph export "$graphdir/beta_bartik_distribution_`dset'.png", replace;  
/*************************************
graphing t-statistics 
*************************************/
twoway (hist tstat if iteration!=0)
	(kdensity tstat if iteration!=0)
	(scatteri 0 `lower_bound' 5 `lower_bound', recast(line) lcolor(gs12) lwidth(thick) lpattern(dash))
	(scatteri 0 `upper_bound' 5 `upper_bound', recast(line) lcolor(gs12) lwidth(thick) lpattern(dash))
	(scatteri 0 `actual_tstat' 5 `actual_tstat', recast(line) lcolor(blue) lwidth(thick) lpattern(dash)),
       saving("$graphdir/tdistribution_bartik.gph", replace)
       xtitle("T-statistic")
       ytitle("Density")
      /* xline(`true_est',lstyle(foreground) lpattern(dash) lcolor(red))*/
       title("Distribution of T-Statistic")
       legend(off)
       ;
       
       graph export "$outgraph/tdistribution_bartik_`dset'.png", replace ;


} ; 

