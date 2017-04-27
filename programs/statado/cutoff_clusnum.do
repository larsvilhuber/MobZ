global progdir "/ssgprojects/projects0002/MobZ"
#delimit ;

use "$progdir/data/clusnum_cutoff_jtw1990.dta, clear ;
replace cutoff= cutoff/10000 ;
sort cutoff ;

twoway (line clusnum cutoff),
           xline(0.9418)
           xtitle("Cutoff")
           ytitle("Number of Clusters")
           legend(off);

graph export "$progdir/paper/figures/numclus_cutoff.png", replace ;
