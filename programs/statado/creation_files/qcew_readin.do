set more off
import delimited "$qcewdir\allhlcn90.csv", delimiter(comma) clear

drop if _n<=2

destring v2, gen(stfip) force

tab stfip

gen ctyfips = v3

gen fips = 1000*stfip + ctyfips

gen year = v6
rename v12 industries
rename v11 ownership
destring v15, gen(employment) ignore(",") force

drop v*

keep if industries == "Manufacturing" | (ownership == "Total Covered")
drop if  ctyfips == 0 | fips == .
bys fips: egen manufacturing_emp = sum(employment*(industries=="Manufacturing"))
bys fips: egen total_employment = sum(employment*(ownership == "Total Covered"))

collapse (first) manufacturing_emp total_employment, by(fips year)

tempfile 1990qcew
save `1990qcew', replace

import delimited "$qcewdir\allhlcn00.csv", delimiter(comma) clear

drop if _n<=2


destring v1, gen(fips) force
gen ctyfips = v3

drop if ctyfips == 0 
gen year = v6
rename v12 industries
rename v11 ownership
destring v15, gen(employment) ignore(",") force

drop v*

keep if industries == "Manufacturing" | (ownership == "Total Covered")
drop if fips == .

bys fips: egen manufacturing_emp = sum(employment*(industries=="Manufacturing"))
bys fips: egen total_employment = sum(employment*(ownership == "Total Covered"))

collapse (first) manufacturing_emp total_employment, by(fips year)

tempfile 2000qcew
save `2000qcew', replace


import delimited "$qcewdir\allhlcn07.csv", delimiter(comma) clear

drop if _n<=2


destring v1, gen(fips) force
gen ctyfips = v3

drop if ctyfips == 0 
gen year = v5
rename v11 industries
rename v10 ownership
destring v14, gen(employment) ignore(",") force

drop v*

keep if industries == "Manufacturing" | (ownership == "Total Covered")
drop if fips == .

bys fips: egen manufacturing_emp = sum(employment*(industries=="Manufacturing"))
bys fips: egen total_employment = sum(employment*(ownership == "Total Covered"))

collapse (first) manufacturing_emp total_employment, by(fips year)

tempfile 2007qcew
save `2007qcew', replace

append using `1990qcew'
append using `2000qcew'

tostring fips, replace
replace fips = "0" +fips if length(fips) == 4

tab year
drop if substr(fips,1,2) == "15" | substr(fips,1,2) == "02" 

sort fips year
save "$datadir\qcewdata.dta", replace



