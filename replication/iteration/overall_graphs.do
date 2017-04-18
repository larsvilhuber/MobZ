/*******************
This makes graphs of
distribution of results
*******************/
global root = "/ssgprojects/project0002/MobZ"
global dodir "$root/replication/iteration"

include "$dodir/config.do" ;

global clusdir = "$root/data"
global graphdir "$paperdir/figures"
global outgraph "$paperdir/figures"

use "$clusdir/bootstrap_results.dta"
sort iteration
local true_est = beta_1990[1] 
di "`true_est'"
#delimit ; 
twoway (hist beta_1990 if iteration!=0)
	(kdensity beta_1990 if iteration!=0)
	(scatteri 0 `true_est' 15 `true_est', recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
       saving("$graphdir/1990_distribution.gph", replace)
       xtitle("Coefficient")
       ytitle("Density")
      /* xline(`true_est',lstyle(foreground) lpattern(dash) lcolor(red))*/
       title("Distribution of Estimated Effect, 1990")
       legend(off)
       ;

graph export "$outgraph/1990_distribution.png", replace ;

preserve ; 
sum if iteration == 0 ; 
local true_est = r(mean); 
keep if iteration !=0 ;

sort tstat_1990 ;

local lower_bound = tstat_1990[25] ;
local upper_bound = tstat_1990[975];
restore ; 


twoway (hist tstat_1990 if iteration!=0)
	(kdensity tstat_1990 if iteration!=0)
	(scatteri 0 `true_est' 2 `true_est', recast(line) lcolor(blue) lwidth(thick) lpattern(dash))
	(scatteri 0 `lower_bound' 2 `lower_bound', recast(line) lcolor(red) lwidth(thick) lpattern(dash))
	(scatteri 0 `upper_bound' 2 `upper_bound', recast(line) lcolor(red) lwidth(thick) lpattern(dash)),
       saving("$graphdir/1990_tdistribution.gph", replace)
       xtitle("Coefficient")
       ytitle("Density")
      /* xline(`true_est',lstyle(foreground) lpattern(dash) lcolor(red))*/
       title("Distribution of Estimated Effect, 1990")
       legend(off)
       ;

graph export "$outgraph/1990_tstat_distribution.png", replace ;


end
twoway (hist beta_2000 if iteration!=0)
(kdensity beta_2000 if iteration!=0),
       saving("$graphdir/2000_distribution.gph", replace)
       xtitle("Coefficient")
       ytitle("Density")
       title("Distribution of Estimated Effect, 1990")
       legend(off)
       xline(`true_est');

graph export "$outgraph/2000_distribution.png", replace ;
       
twoway (hist beta_all if iteration!=0)
	(kdensity beta_all if iteration!=0),
       saving("$graphdir/all_distribution.gph", replace)
       xtitle("Coefficient")
       ytitle("Density")
       title("Distribution of Estimated Effect, 1990")
       legend(off)
       xline(`true_est');       

graph export "$outgraph/all_distribution.png", replace ;
