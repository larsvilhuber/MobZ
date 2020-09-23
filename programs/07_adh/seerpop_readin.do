/* Data pulled from: https://data.nber.org/seer-pop/uswbosingleagesadj.dta.zip */
/* Then data unzipped */

use uswbosingleagesadj.dta, clear


bys county year: egen pop_16_65 = sum(pop*(age>=16 & age<=65))
bys county year: egen totalpop = sum(pop) 

collapse (first) pop_16_65 totalpop, by(county year)

save $raw/popcounts.dta, replace