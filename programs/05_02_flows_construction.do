/* construct flows */

*import delimited [datadir]/jtw2009_2013.csv, clear
use "$interwrk/jtw2009_2013.csv", clear

destring workersincommutingflow, gen(flow) ignore(",")
destring marginoferror, gen(moe) ignore(",")
drop if flow == . 


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
twoway (kdensity ratio if flow <= `pct50' & ratio<5) 
		(kdensity ratio if flow> `pct50' & flow<=`pct90')
		(kdensity ratio if flow> `pct90' & flow<=`pct95')
		(kdensity ratio if flow> `pct95' & flow<=`pct99'),
		legend(label(1 "First Cat") label(2 "Second Cat")
				label(3 "Third Cat") label(4 "Fourth Cat"))
		xtitle("Ratio")
		ytitle("Density");

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

export delimited using "[datadir]/flow_moe_ratios.csv", replace
