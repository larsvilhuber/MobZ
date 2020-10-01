/* creates Figure 4 */

include "config.do"

#delimit ;

use "$interwrk/finalstats_jtw2009_moe_new2.dta", clear;

/* make the graphs */

twoway (histogram share_mismatch_wgt)
       (kdensity share_mismatch_wgt),
       saving("$outgraphs/mismatch_jtw2009.gph", replace)
       xtitle("Population Share in Different Commuting Zone")
       ytitle("Density")
       legend(off)
       ;
            
graph export "$outgraphs/mismatch_jtw2009.pdf", replace; 



twoway (histogram mean_clussize)
       (kdensity mean_clussize)
       /* (scatteri 0 4.16 15 4.16, recast(line) lcolor(red) lwidth(thick) lpattern(dash)) */,
       saving("$outgraphs/meanclussize_jtw2009.gph", replace)
       xtitle("Mean Cluster Size")
       ytitle("Density")
       legend(off)
       ;

graph export "$outgraphs/meanclussize_jtw2009.pdf", replace;

twoway (histogram numclusters)
       (kdensity numclusters)
       /* (scatteri 0 755 .07 755, recast(line) lcolor(red) lwidth(thick) lpattern(dash))*/,
       saving("$outgraphs/numclusters_jtw2009.gph", replace)
       xtitle("Number of Clusters")
       ytitle("Density")
       legend(off)
       ;

graph export "$outgraphs/numclusters_jtw2009.pdf", replace; 






