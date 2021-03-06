/* This program runs the bootstrap stuff */
/* Author: Andrew Foote */

include "config.do"

/* the last three lines contain unwanted footnotes */
/* We use shell script here to remove them */
/* On windows, do this manually! */

tempfile a
! head -n -3 "${raw}/jtw2009_2013.csv" > `a'
//insheet using "${raw}/jtw2009_2013.csv", names
insheet using "`a'", names

save "$interwrk/jtw2009_2013", replace

gen ratio = moe/flow

sum flow, d

foreach x in 50 90 95 99 {
	local pct`x' = r(p`x')
}

sum ratio if flow<=`pct50', d

sum ratio if flow> `pct50' & flow <= `pct90',d 
sum ratio if flow> `pct90' & flow <= `pct95',d 
sum ratio if flow> `pct95' & flow <= `pct99',d 
sum ratio if flow> `pct99',d 
#delimit ; 
twoway (kdensity ratio if flow <= `pct50' & ratio<10) 
		(kdensity ratio if flow> `pct50' & flow<=`pct90')
		(kdensity ratio if flow> `pct90' & flow<=`pct95')
		(kdensity ratio if flow> `pct95' & flow<=`pct99'),
		legend(label(1 "First Cat") label(2 "Second Cat")
				label(3 "Third Cat") label(4 "Fourth Cat"))
		xtitle("Ratio")
		ytitle("Density");
graph save "$outgraphs/figure05a_temp.gph", replace;
graph export "$outgraphs/figure05a_temp.pdf", replace;

#delimit cr

gen flowsize=  . 
	replace flowsize = 1 if flow<= `pct50'
	replace flowsize = 2 if flow> `pct50' & flow <= `pct90'
	replace flowsize = 3 if flow> `pct90' & flow <= `pct95'
	replace flowsize = 4 if flow> `pct95' & flow <= `pct99'
	replace flowsize = 5 if flow> `pct99'

bys flowsize: egen sd_ratio = sd(ratio)
bys flowsize: egen mean_ratio = mean(ratio)

collapse (first) sd_ratio mean_ratio, by(flowsize)

export delimited using "$interwrk/flow_moe_ratios.csv", replace

/* do other stuff here */

tempfile ratios 
save `ratios', replace




use  "${outputs}/flows1990.dta", clear 
rename jobsflow flows
sum flows, d


foreach x in 50 90 95 99 {
	local pct`x' = r(p`x')
}

gen flowsize=  . 
	replace flowsize = 1 if flows<= `pct50'
	replace flowsize = 2 if flows> `pct50' & flows <= `pct90'
	replace flowsize = 3 if flows> `pct90' & flows <= `pct95'
	replace flowsize = 4 if flows> `pct95' & flows <= `pct99'
	replace flowsize = 5 if flows> `pct99'

sort flowsize 
merge flowsize using `ratios'
drop _merge
tab flowsize, m 
/*************************************
ONE TIME DRAW FROM RATIO DISTRIBUTION
**************************************/
gen ratiodraw = rnormal(mean_ratio,sd_ratio)

 sum ratiodraw
/* sometimes is negative: redraw until positive */

while (r(min)<0) {
	replace ratiodraw = rnormal(mean_ratio,sd_ratio) if ratiodraw < 0 
	 sum ratiodraw 
}

/* create file for downstream processing */

gen moe = flows*ratiodraw
format moe ratiodraw mean_ratio sd_ratio %15.5f
outfile using "$interwrk/jtw1990_moe.csv", comma replace noquote
sort work_cty home_cty 

list in 150/200

save "$interwrk/jtw1990_moe.dta", replace
