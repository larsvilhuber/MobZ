
include "../config.do"

/* compress and create summary stats */
/*=================== Employment file ==================*/
 
use "$outputs/qcew_county.dta", clear
compress
save "$outputs/qcew_county.dta", replace
sum 
codebook

/*=================== Earnings file ==================*/
use "$outputs/qcew_earnings.dta", clear
compress
save "$outputs/qcew_earnings.dta", replace
sum
codebook

