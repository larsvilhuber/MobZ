#delimit ;
use "$datadir/clusnum_cutoff.dta", clear ;
replace cutoff= cutoff/10000 ;
sort cutoff ;

twoway (line clusnum cutoff),
           xline(0.9365, lcolor(red) lwidth(thick) lpattern(dash) )
           xtitle("Cutoff")
           ytitle("Number of Clusters")
           legend(off);

graph export "$graphdir/numclus_cutoff.png", replace ;


