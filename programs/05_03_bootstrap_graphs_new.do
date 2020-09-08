/* creates Figure 4 */

include "config.do"

#delimit ;

use "$interwrk/finalstats_jtw1990_moe_new2.dta", clear;

/* make the graphs */

twoway (histogram share_mismatch_wgt)
       (kdensity share_mismatch_wgt),
       saving("$outgraphs/mismatch_jtw1990.gph", replace)
       xtitle("Population Share in Different Commuting Zone")
       ytitle("Density")
       legend(off)
       ;
            
graph export "$outgraphs/mismatch_jtw1990.pdf", replace; 



twoway (histogram mean_clussize)
       (kdensity mean_clussize)
       (scatteri 0 4.16 15 4.16, recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
       saving("$outgraphs/meanclussize_jtw1990.gph", replace)
       xtitle("Mean Cluster Size")
       ytitle("Density")
       /*xline(3.88)*/
       legend(off)
       ;

graph export "$outgraphs/meanclussize_jtw1990.pdf", replace;

twoway (histogram numclusters)
       (kdensity numclusters)
       (scatteri 0 755 .07 755, recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
       saving("$outgraphs/numclusters_jtw1990.gph", replace)
       xtitle("Number of Clusters")
       ytitle("Density")
       /*xline(810)*/
       legend(off)
       ;

graph export "$outgraphs/numclusters_jtw1990.pdf", replace; 






