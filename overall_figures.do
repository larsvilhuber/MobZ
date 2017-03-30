global dodir "M:\CES_New_Folder_Structure\RESEARCH\MobZ\adh data\iteration_dofiles"
global clusdir = "M:\CES_New_Folder_Structure\RESEARCH\MobZ\adh data\iteration_dofiles"
local czonedataset = "${clusdir}\bootclusters_jtw1990_moe.dta"
global czone_iteration = "${clusdir}\czones.dta" 
global graphsdir "${clusdir}\figures" ;
di "`czonedataset'" 

set more off
#delimit ;

use "$clusdir\bootstrap_results.dta", replace ;

sort iteration ; 

local true_value_1990 = beta_1990[1] ;
local true_value_2000 = beta_2000[1] ;
local true_value_all = beta_all[1] ;

drop if iteration == 0 

foreach yr in 1990 2000 all { ; 
twoway (hist beta_`yr')
		(kdensity beta_`yr'),
		xline(`true_value_`yr'')
		saving("$graphsdir\distribution_`yr'.gph", replace)
		ytitle("Density")
		legend(off)
		xtitle("Coefficient Estimates") 
		title("Distribution of Coefficient Estimates, `yr'") ;
}   ;
