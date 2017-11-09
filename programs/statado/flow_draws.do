set more off
import delimited "$datadir/flow_moe_ratios.csv", clear 

sort flowsize 
tempfile ratios
save `ratios', replace

use  "$datadir/flows1990.dta", clear
des

count if jobsflow== .

*list if substr(home_cty,1,2) == "01" & substr(work_cty,1,2) == "01"
sum jobsflow, d

foreach x in 50 90 95 99 {
	local pct`x' = r(p`x')
}

gen flowsize=  . 
	replace flowsize = 1 if jobsflow<= `pct50'
	replace flowsize = 2 if jobsflow> `pct50' & jobsflow <= `pct90'
	replace flowsize = 3 if jobsflow> `pct90' & jobsflow <= `pct95'
	replace flowsize = 4 if jobsflow> `pct95' & jobsflow <= `pct99'
	replace flowsize = 5 if jobsflow> `pct99'

sort flowsize 
merge flowsize using `ratios'
tab flowsize, m 
/*************************************
ONE TIME DRAW FROM RATIO DISTRIBUTION
**************************************/
gen ratiodraw = rnormal(mean_ratio,sd_ratio)

 sum ratiodraw

while (r(min)<0) {
	replace ratiodraw = rnormal(mean_ratio,sd_ratio) if ratiodraw < 0 
	 sum ratiodraw 
}



gen moe = jobsflow*ratiodraw
format moe ratiodraw mean_ratio sd_ratio %15.5f
drop _merge
outfile using "$datadir/jtw1990_moe.csv", comma replace noquote
sort work_cty home_cty 

list in 150/200

save $outdir/jtw1990_moe.dta, replace


