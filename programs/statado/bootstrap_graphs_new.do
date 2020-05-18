#delimit ;

global datadir "[datadir]" ;
global graphdir "[figuredir]" ;

use "$datadir/finalstats_jtw1990_moe_new.dta", clear;

/* make the graphs */

twoway (histogram share_mismatch_wgt)
       (kdensity share_mismatch_wgt),
       saving("$graphdir/mismatch_jtw1990.gph", replace)
       xtitle("Population Share in Different Commuting Zone")
       ytitle("Density")
       legend(off)
       ;
            
graph export "$graphdir/mismatch_jtw1990.png", replace; 



twoway (histogram mean_clussize)
       (kdensity mean_clussize)
       (scatteri 0 3.88 15 3.88, recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
       saving("$graphdir/meanclussize_jtw1990.gph", replace)
       xtitle("Mean Cluster Size")
       ytitle("Density")
       /*xline(3.88)*/
       legend(off)
       ;

graph export "$graphdir/meanclussize_jtw1990.png", replace;

twoway (histogram numclusters)
       (kdensity numclusters)
       (scatteri 0 810 .06 810, recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
       saving("$graphdir/numclusters_jtw1990.gph", replace)
       xtitle("Number of Clusters")
       ytitle("Density")
       /*xline(810)*/
       legend(off)
       ;

graph export "$graphdir/numclusters_jtw1990.png", replace; 




