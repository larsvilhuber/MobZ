/* subset the QCEW data */

include "../config.do"

#delimit ; 

use $outputs/qcew_county.dta, clear ; 

keep if year == 1990 | year == 2000 | year ==2007;

bys fips year: egen manufacturing_emp = sum(annual_avg_emplvl*(naics2=="31-33")) ;
bys fips year: egen total_employment = sum(annual_avg_emplvl) ;

collapse (first) manufacturing_emp total_employment , by (fips year) ;
sum ;
tabstat manufacturing_emp, by(year) ;
save $interwrk/tmp_qcewdata.dta, replace; 
