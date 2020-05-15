#delimit ; 
/*******************************************

globals set above - this will be "include"-d

********************************************/

 /* important tempfiles:

masterdata - data to which things will get merged
$czone_iteration - the czone definition being used right now
   (already sorted by FIPS)
qcewdata - sorted by fips
industry_by_year - sorted by naics2 year (employment growth);
shell - a naics-year-czone dataset for merging into ;

*/
    
use `qcewdata', clear;
destring naics2, replace;  
sort fips ; 
merge fips using $czone_iteration ;
drop _merge ;

tempfile mergefile;
save `mergefile', replace;

/************** BASE YEAR ***********************/
bys naics2 czone: egen L_ij1990 = sum(annual_avg_emplvl*(year==1990)) ;
bys czone: egen L_1990 = sum(annual_avg_emplvl*(year==1990)) ;

gen gamma_ij1990 = L_ij1990 / L_1990 ;

collapse (first) gamma_ij1990, by(czone naics2) ;
sort czone naics2;
tempfile base_year ;
save `base_year', replace;


/************** merging into bartik  *****************/

use `shell2', clear ;

sort czone naics2 ;
merge czone naics2 using `base_year' ;

drop _merge ;

sort naics2 year ;
merge naics2 year using `industry_by_year', keep(delta_emp_jt) ;

bys czone year: egen bartik_it = sum(delta_emp_jt*gamma_ij1990) ;
collapse (first) bartik_it, by(czone year) ;
keep czone year bartik_it ;
tempfile bartik ;
save `bartik', replace;

/************** NOW, COLLAPSE EARNINGS TO CZONE **********/

use "$interwrk/bea_table30.dta", clear;  

sort fips ;
merge fips using $czone_iteration ;

collapse (sum) uireceipt , by(czone year) ; 

gen log_uireceipt = log(uireceipt) ;

sort czone year ;
merge czone year using `bartik' ;

drop _merge ; 

tempfile mergedfile ;

/* then will merge this outside this file, to */
