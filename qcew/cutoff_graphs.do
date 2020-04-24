global dodir "/programs/projects/mobz2/replication/iteration"
global clusdir = "/data/working/mobz/outputs"
global datadir "/data/working/mobz/qcew" 
global graphdir "/programs/projects/mobz2/paper/figures"
global outgraph "/programs/projects/mobz2/paper/figures"

#delimit ; 


use "$datadir/bartik_results_cutoff.dta", clear;

gen top = beta + 1.64*se ;
gen bottom = beta - 1.64*se ;

twoway (rarea top bottom cutoff, color(gs13))
       (line beta cutoff)
       (scatteri -6.643 .9 -6.643 .98, recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
       saving("${graphdir}/cutoff_bartik.gph", replace)
       ytitle("Effect")
       xtitle("Cluster Height Cutoff")
      
       legend(off) ;

graph export "$outgraph/cutoff_bartik.png", replace ; 
