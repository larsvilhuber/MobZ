/*******************
This makes graphs of
distribution of results
*******************/

include "../config.do"

use "$interwrk/bootstrap_results.dta", clear
sort iteration
local true_est = beta_1990[1] 
di "`true_est'"
local true_se = se_1990[1] 
di "`true_se'"
local upper = `true_est'+(1.96*`true_se') 
local lower = `true_est'-(1.96*`true_se')
di "CONFIDENCE INTERVAL: [" %5.4f `lower' ", " %5.4f `upper' "]"

#delimit ; 
twoway (hist beta_1990 if iteration!=0)
	(kdensity beta_1990 if iteration!=0)
	(scatteri 0 `true_est' 40 `true_est', recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
       saving("$outgraphs/1990_distribution.gph", replace)
       xtitle("Estimated Coefficient")
       ytitle("Density")
       title("Estimated Effect from Autor, Dorn and Hanson (2013)"
       )
       legend(off)
              text(40 -.95 "Figure shows estimates of the" 
		           "effect of growth in trade with"
			   "China on manufacturing "
			   "employment using 1000 "
			   "realizations of commuting zones"		  
	            , box place(se)  just(left) 
			fcolor(gs15) bcolor(gs2) margin(vsmall))
		    
		text(36.3 -.86 "Replicated Estimate"		  
	            , box place(ne) fcolor(white)  just(left) color(red) margin(small))
       ;
       
       graph export "$outgraphs/1990_distribution_SOLE.pdf", replace ;
       
       twoway (hist beta_1990 if iteration!=0)
	(kdensity beta_1990 if iteration!=0)
	(scatteri 0 `true_est' 35 `true_est', recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
       saving("$outgraphs/1990_distribution.gph", replace)
       xtitle("Estimated Coefficient")
       ytitle("Density")
       title("Estimated Effect from Autor, Dorn and Hanson (2013)"
       )
       legend(off)              
       ;
       
       graph export "$outgraphs/1990_distribution.pdf", replace ;

sum tstat_1990 beta_1990 if iteration!=0,d;

centile tstat_1990, centile(2.5 97.5);

preserve ;
sum tstat_1990 if iteration==0 ; 
local actual_tstat = r(mean);
keep if iteration!=0 ;
sort tstat_1990 ;
di " The 2.5th and 97.5th percentiles of the t-distibution statistic are" %6.4f tstat_1990[25] "  and   " %6.4f tstat_1990[975] ;

local lower_bound = tstat_1990[25];
local upper_bound = tstat_1990[975];

restore ;



twoway (hist tstat_1990 if iteration!=0)
	(kdensity tstat_1990 if iteration!=0)
	(scatteri 0 `lower_bound' 2 `lower_bound', recast(line) lcolor(gs12) lwidth(thick) lpattern(dash))
	(scatteri 0 `upper_bound' 2 `upper_bound', recast(line) lcolor(gs12) lwidth(thick) lpattern(dash))
	(scatteri 0 `actual_tstat' 2 `actual_tstat', recast(line) lcolor(blue) lwidth(thick) lpattern(dash)),
       saving("$outgraphs/1990_tdistribution.gph", replace)
       xtitle("T-statistic")
       ytitle("Density")
      /* xline(`true_est',lstyle(foreground) lpattern(dash) lcolor(red))*/
       title("Distribution of T-Statistic, 1990")
       legend(off)
       ;
       
       graph export "$outgraphs/1990_tstat_distribution.pdf", replace ;

twoway (hist beta_2000 if iteration!=0)
(kdensity beta_2000 if iteration!=0),
       saving("$outgraphs/2000_distribution.gph", replace)
       xtitle("Coefficient")
       ytitle("Density")
       title("Distribution of Estimated Effect, 1990")
       legend(off)
       xline(`true_est');

graph export "$outgraphs/2000_distribution.pdf", replace ;
       
twoway (hist beta_all if iteration!=0)
	(kdensity beta_all if iteration!=0),
       saving("$outgraphs/all_distribution.gph", replace)
       xtitle("Coefficient")
       ytitle("Density")
       title("Distribution of Estimated Effect, 1990")
       legend(off)
       xline(`true_est');       

graph export "$outgraphs/all_distribution.pdf", replace ;

