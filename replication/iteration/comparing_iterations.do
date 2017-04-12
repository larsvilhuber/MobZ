cap log close
log using comparing_iterations.log, replace 

global dodir "."
global clusdir = "[data]/outputs"
global graphdir "[data]/figures"
global outgraph "[data]/figures"
local czonedataset = "${clusdir}/bootstrap_spectral.dta"
global czone_iteration = "${clusdir}/czones_cutoff.dta"
local ipw_regs "${clusdir}/bootstrap_spec_results.dta"



#delimit ;
use "${clusdir}/bootclusters_jtw1990_moe.dta", clear ;
tempname results ;
tempfile  heir_results ;  
 

postfile `results' iteration numclusters 
			using `heir_results', replace ;
			
forvalues i = 1/1000 { ;
	qui tab clustername_`i', m ;
	local clusnum = r(r);
	
	post `results' (`i') (`clusnum') ;
	

} ;
postclose `results' ; 

use `heir_results', clear;
sort iteration;
save `heir_results', replace ;

use "${clusdir}/bootstrap_spectral.dta", clear ;

tempname results ;
 tempfile spec_results ; 
 

postfile `results' iteration numclusters_spec
			using `spec_results', replace ;
			
			
forvalues i = 1/1000 { ;
	qui tab cluster_`i', m ; 
	local clusnum = r(r) ;
	post `results' (`i') (`clusnum') ;
};
postclose `results' ;
use `spec_results', clear;
 sort iteration ; 
 
 merge iteration using `heir_results'; 
  
  
