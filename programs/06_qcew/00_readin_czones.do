/* this reads in the original CZ data */

include "../config.do"

import excel using "${raw}/czlma903.xls", sheet("CZLMA903") firstrow case(lower)
// import delimited /data/working/mobz/geo/cz90.csv , clear ;
//tostring countyfipscode, gen(fips) 
//    replace fips = "0" + fips if length(fips) == 4 ;
save "${interwrk}/czlma903", replace

sum
codebook

