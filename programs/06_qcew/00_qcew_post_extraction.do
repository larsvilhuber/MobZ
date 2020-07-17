
include "../config.do"

/* compress and create summary stats */
/*=================== Employment file ==================*/
 
use "$outputs/qcew_county.dta", clear
compress
save "$outputs/qcew_county.dta", replace
sum 
codebook

/*=================== Mostly raw BLS QCEW file ==================*/

use "$interwrk/bls_us_county.dta", clear
compress
save "$interwrk/bls_us_county.dta", replace
sum 
codebook

