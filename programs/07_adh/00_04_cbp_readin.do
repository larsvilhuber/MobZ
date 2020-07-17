/* will readin in select years of CBP data */

include "../config.do"

use "$cbpdata/cbp1990_co.dta", clear
keep if sic=="20--"
desc

gen fips = fipstate*1000 + fipscty
tostring fips, replace force
replace fips = "0" + fips if length(fips) == 4

/* replace emp if empflag has certain value */

replace emp = 10 if empflag == "A"
replace emp = 60 if empflag == "B"
replace emp = 175 if empflag == "C"
replace emp = 375 if empflag == "E"
replace emp = 750 if empflag == "F"
replace emp = 1750 if empflag == "G"
replace emp = 3750 if empflag == "H"
replace emp = 7500 if empflag == "I"
replace emp = 17500 if empflag == "J"
replace emp = 37500 if empflag == "K"
replace emp = 75000 if empflag == "L"

sum emp,d

keep year fips emp 
rename emp manu_emp_cbp

tempfile cbp90 
save `cbp90', replace

use "$cbpdata/cbp2000_co.dta", clear
keep if naics=="31----"
desc

gen fips = fipstate*1000 + fipscty
tostring fips, replace force
replace fips = "0" + fips if length(fips) == 4

/* replace emp if empflag has certain value */

replace emp = 10 if empflag == "A"
replace emp = 60 if empflag == "B"
replace emp = 175 if empflag == "C"
replace emp = 375 if empflag == "E"
replace emp = 750 if empflag == "F"
replace emp = 1750 if empflag == "G"
replace emp = 3750 if empflag == "H"
replace emp = 7500 if empflag == "I"
replace emp = 17500 if empflag == "J"
replace emp = 37500 if empflag == "K"
replace emp = 75000 if empflag == "L"

sum emp,d 

keep year fips emp 
rename emp manu_emp_cbp

tempfile cbp00
save `cbp00', replace

use "$cbpdata/cbp2007_co.dta", clear
keep if naics=="31----"
desc

gen fips = fipstate*1000+fipscty
tostring fips, replace force
replace fips = "0" + fips if length(fips) == 4 

/* replace emp if empflag has certain value */

replace emp = 10 if empflag == "A"
replace emp = 60 if empflag == "B"
replace emp = 175 if empflag == "C"
replace emp = 375 if empflag == "E"
replace emp = 750 if empflag == "F"
replace emp = 1750 if empflag == "G"
replace emp = 3750 if empflag == "H"
replace emp = 7500 if empflag == "I"
replace emp = 17500 if empflag == "J"
replace emp = 37500 if empflag == "K"
replace emp = 75000 if empflag == "L"

sum emp, d

keep year fips emp 
rename emp manu_emp_cbp

tempfile cbp07
save `cbp07', replace

/***************************************/

append using `cbp00'
append using `cbp90'


tab year 
sort fips year

save "$interwrk/cbp_allyears.dta", replace
