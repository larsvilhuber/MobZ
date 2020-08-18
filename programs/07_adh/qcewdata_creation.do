include "../config.do"

#delimit ; 

use $datadir/qcew_county.dta, clear ; 

keep if year == 1990 | year == 2000 | year ==2007;

bys fips year: egen manufacturing_employment = sum(annual_avg_emplvl*(naics2=="31")) ;
bys fips year: egen total_employment = sum(annual_avg_emplvl) ;

collapse (first) manufacturing_employment total_employment , by (fips year) ;

save $datadir/qcewdata.dta, replace; 
