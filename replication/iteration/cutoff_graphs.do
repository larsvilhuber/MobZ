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
log using cutoff_graphs.log, replace 
global dodir "."
global clusdir = "[data]/outputs"
global graphdir "[data]/figures"
global outgraph "[data]/figures"
local czonedataset = "${clusdir}/clusters_cutoff_jtw1990.dta"
global czone_iteration = "${clusdir}/czones_cutoff.dta"
local ipw_regs "${clusdir}/cutoff_post.dta"

#delimit ; 
set more off ;

use `ipw_regs', clear; 

list ;

*sum beta_1990 beta_2000 beta_all, d;

gen top_1990 = beta_1990 + (1.64*se_1990) ;
gen bottom_1990 = beta_1990 - (1.64*se_1990) ; 

twoway 	(rarea top_1990 bottom_1990 cutoff, color(gs13))
	(connected beta_1990 cutoff)
	(scatteri -0.8875 0.9 -0.8875 0.98, recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
	
	saving("${graphdir}/cutoff_1990.gph", replace)
	ytitle("Effect") /*yline(-0.8875)*/
	/*title("Effect by cutoff height")*/
	xtitle("Cluster Height Cutoff")
	legend(off);

graph export "$outgraph/cutoff_1990.png", replace ;
end
twoway 	(connected F_90 cutoff)
	,
	xline(`realcutoff') 
	saving("${graphdir}/cutoff_1990.gph", replace)
	ytitle("F-Statistic of First Stage") 
	title("Strength of First-Stage, by CZ Cutoff")
	xtitle("Cluster Height Cutoff")
	legend(off);

graph export "$outgraph/Fstat_1990.png", replace ;



/* calculating the inter-quartile range */
foreach yr in 1990 2000 all { ;
	gen beta_iqr_`yr' = beta_`yr'*iqr_`yr' ;
	gen top_iqr_`yr' = beta_iqr_`yr' + (1.96*iqr_`yr'*se_`yr') ;
	gen bottom_iqr_`yr' = beta_iqr_`yr' - (1.96*iqr_`yr'*se_`yr') ;
} ;

twoway (rarea top_iqr_1990 bottom_iqr_1990 cutoff, color(gs13))
	(connected beta_iqr_1990 cutoff)
	,
	xline(`realcutoff')
	saving("$graphdir/cutoff_iqr_1990.gph", replace)
	ytitle("Effect for IQR")
	title("Effect, scaled by IQR Size")
	xtitle("Cluster Height Cutoff")
	legend(off);

graph export "$outgraph/cutoff_iqr_1990.png", replace ; 

log close ;
