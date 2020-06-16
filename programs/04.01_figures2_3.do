
global datadir [datadir] ;
global graphdir [graphdir] ;
#delimit ;
use $datadir/clusnum_cutoff.dta, clear ;

replace cutoff= cutoff/10000 ;
sort cutoff ;

twoway (line clusnum cutoff, yaxis(1))
	(line share_mismatch_wgt cutoff, yaxis(2) lwidth(medthick) lpattern(dash_dot)),
           xline(0.9385, lcolor(red) lwidth(thick) lpattern(dash) )
           xtitle("Cutoff")
           ytitle("Number of Clusters",axis(1))
	   ytitle("Share Population Mismatched",axis(2))
	   
           legend(label(1 "Number of Clusters") label(2 "Share Mismatch (right axis)"));

graph export "$graphdir/numclus_cutoff.png", replace ;


twoway (line share_inflows cutoff, yaxis(1)),
           xline(0.9385, lcolor(red) lwidth(thick) lpattern(dash) )
           xtitle("Cutoff")
           ytitle("Share Flows",axis(1))
	   title("Cross-Commuting as Share of Population")
           legend(label(1 " Share Cross-Commuting"));

graph export "$graphdir/flows_cutoff.png", replace ;

