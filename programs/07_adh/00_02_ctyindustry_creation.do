/* create a file combining multiple census information sources */
/* pre-requisites: run the NHGIS data read-in scripts under ..../raw */

include "../config.do"

*cd "$datadir"

use "$dorndata/cty_industry1980", clear
gen year = 1980

append using "$dorndata/cty_industry1990"
replace year = 1990 if year == .

append using "$dorndata/cty_industry2000"
replace year = 2000 if year == .

tostring cty_fips, gen(fips) force

replace fips = "0"+fips if length(fips)==4 
tab year 

save "$interwrk/industry_data", replace
