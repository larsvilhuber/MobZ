/************************************
This do-file creates graphs 

************************************/

include "../config.do"
#delimit ; 

use "$interwrk/bartik_results_moe_new.dta", clear;


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
	(scatteri 0 `true_est' 2.2 `true_est', 
			recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
	saving("$outgraph/beta_bartik_distribution.gph", replace) 
	xtitle("Estimated Coefficient")
	ytitle("Density")
	title("Estimated effect of labor demand on UI Receipt")
	legend(off)
	;
	
	graph export "$outgraph/beta_bartik_distribution_moe_new.png", replace; 
	graph export "$outgraph/qcew_betadist.png", replace ; 
/*************************************
graphing t-statistics 
*************************************/
twoway (hist tstat if iteration!=0)
	(kdensity tstat if iteration!=0)
	(scatteri 0 `lower_bound' 1.5 `lower_bound', recast(line) lcolor(gs12) lwidth(thick) lpattern(dash))
	(scatteri 0 `upper_bound' 1.5 `upper_bound', recast(line) lcolor(gs12) lwidth(thick) lpattern(dash))
	(scatteri 0 `actual_tstat' 1.5 `actual_tstat', recast(line) lcolor(blue) lwidth(thick) lpattern(dash)),
       saving("$graphdir/tdistribution_bartik.gph", replace)
       xtitle("t-statistic")
       ytitle("Density")
      /* xline(`true_est',lstyle(foreground) lpattern(dash) lcolor(red))*/
       title("Distribution of t-statistic")
       legend(off)
       ;
       
       graph export "$outgraph/tdistribution_bartik_moe_new.png", replace ;
	graph export "$outgraph/qcew_tstatdist.png", replace;  


