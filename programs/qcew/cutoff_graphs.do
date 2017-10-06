global dodir ""
global clusdir = ""
global datadir "" 
global graphdir ""
global outgraph ""

#delimit ; 


use "$datadir/bartik_results_cutoff.dta", clear;

gen top = beta + 1.64*se ;
gen bottom = beta - 1.64*se ;

twoway (rarea top bottom cutoff, color(gs13))
       (line beta cutoff),
       saving("${graphdir}/cutoff_bartik.gph", replace)
       ytitle("Effect")
       xtitle("Cluster Height Cutoff")
       legend(off) ;

graph export "$outgraph/cutoff_bartik.png", replace ; 
