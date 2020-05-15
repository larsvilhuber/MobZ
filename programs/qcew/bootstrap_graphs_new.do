#delimit ;

use "$interwrk/finalstats_jtw1990_moe_new.dta", clear;

/* make the graphs */

/*
twoway (histogram share_mismatch_wgt)
       (kdensity share_mismatch_wgt),
       saving("$outgraph/mismatch_jtw1990_SOLE.gph", replace)
       xtitle("Population Share in Different Commuting Zone")
       ytitle("Density")
       title("Share of Population in Different Commuting Zone" "Based on 1000 CZ Realizations")
       legend(off)
       text(40 .055 "Figure shows share of population" 
       "in different commuting zone" "due to county re-assignment" "based on resampled commuting " 
	            "flows ", place(se) box just(left) margin(small) fcolor(gs15))
       ;
       
       

graph export "$outgraph/mismatch_jtw1990_SOLE.png", replace; 
*/

twoway (histogram share_mismatch_wgt)
       (kdensity share_mismatch_wgt),
       saving("$outgraph/mismatch_jtw1990_new.gph", replace)
       xtitle("Population Share in Different Commuting Zone")
       ytitle("Density")
       legend(off)
       ;
            
graph export "$outgraph/mismatch_jtw1990_new.png", replace; 



twoway (histogram mean_clussize)
       (kdensity mean_clussize)
       (scatteri 0 4.15 100 4.15, recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
       saving("$outgraph/meanclussize_jtw1990_new.gph", replace)
       xtitle("Mean Cluster Size")
       ytitle("Density")
       /*xline(3.88)*/
       legend(off)
       ;

graph export "$outgraph/meanclussize_jtw1990_new.png", replace;



twoway (histogram numclusters)
       (kdensity numclusters)
       (scatteri 0 755 .6 755, recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
       saving("$outgraph/numclusters_jtw1990_new.gph", replace)
       xtitle("Number of Clusters")
       ytitle("Density")
       /*xline(810)*/
       legend(off)
       ;

graph export "$outgraph/numclusters_jtw1990_new.png", replace;



