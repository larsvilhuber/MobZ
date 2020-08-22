// Does the other graphs for this section

include "config.do"
#delimit ;
use $outputs/clusnum_cutoff.dta, clear ;

replace cutoff= cutoff/10000 ;
sort cutoff ;

twoway (line clusnum cutoff, yaxis(1))
	(line share_mismatch_wgt cutoff, yaxis(2) lwidth(medthick) lpattern(dash_dot)),
           xline(0.9385, lcolor(red) lwidth(thick) lpattern(dash) )
           xtitle("Cutoff")
           ytitle("Number of Clusters",axis(1))
	   ytitle("Share Population Mismatched",axis(2))
	   
           legend(label(1 "Number of Clusters") label(2 "Share Mismatch (right axis)"));

graph export "$outgraphs/numclus_cutoff.pdf", replace ;
graph save "$outgraphs/numclus_cutoff.gph", replace ;


twoway (line share_inflows cutoff, yaxis(1)),
           xline(0.9385, lcolor(red) lwidth(thick) lpattern(dash) )
           xtitle("Cutoff")
           ytitle("Share Flows",axis(1))
	   title("Cross-Commuting as Share of Population")
           legend(label(1 " Share Cross-Commuting"));

graph export "$outgraphs/flows_cutoff.pdf", replace ;
graph save "$outgraphs/flows_cutoff.gph", replace ;

