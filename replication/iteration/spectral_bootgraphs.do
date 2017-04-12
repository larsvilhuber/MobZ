cap log close
log using spectral_bootloop.log, replace 
global dodir "."
global clusdir = "[data]/outputs"
global graphdir "[data]/figures"
global outgraph "[data]/figures"
local czonedataset = "${clusdir}/bootstrap_spectral.dta"
global czone_iteration = "${clusdir}/czones_cutoff.dta"
local ipw_regs "${clusdir}/bootstrap_spec_results.dta"


set more off
#delimit ;

use "$clusdir/bootstrap_results.dta", clear; 

summ if iteration!=0 , d;  
keep if iteration == 0 ; 

local true_est = beta_1990[1] ;

append using "$clusdir/bootstrap_spec_results.dta" ; 

des, full;

twoway (hist beta_1990)
	(kdensity beta_1990)
	/*(scatteri 0 `true_est' 15 `true_est', recast(line) lcolor(red) lwidth(thick)
	lpattern(dash))*/,
	saving("$graphdir/1990_spectraldist.gph", replace)
	xtitle("Coefficient")
	ytitle("Density")
	title("Distribution of Estimated Effect with Spectral Iterations, 1990")
	legend(off)
	;
	
graph export "$outgraph/1990_spectraldist.png", replace ;

summ if iteration!=0, d; 

sort iteration; 

keep iteration beta_1990 ;

tempfile specboot ;
save `specboot', replace; 

use "$clusdir/bootstrap_results.dta", clear;  
keep iteration beta_1990 ;
rename beta_1990 beta_1990_heir;
sort iteration ; 

merge iteration using `specboot';

tab _merge ;

twoway (hist beta_1990)
	(kdensity beta_1990)
	(hist beta_1990_heir)
	(kdensity beta_1990_heir)
	(scatteri 0 `true_est' 15 `true_est', recast(line) lcolor(red) lwidth(thick)
	lpattern(dash)),
	saving("$graphdir/1990_comparisondist.gph", replace)
	xtitle("Coefficient")
	ytitle("Density")
	title("Distribution of Estimated Effect with Spectral Iterations, 1990")
	legend(off)
	;
