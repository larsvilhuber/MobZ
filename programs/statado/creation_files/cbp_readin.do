use "$cpbdir\cpb1990.dta", clear

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

gen year = 1990

keep year fips emp 
rename emp manu_emp_cbp

tempfile cbp90 
save `cbp90', replace

use "$cpbdir\cbp2000.dta", clear

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

gen year = 2000

keep year fips emp 
rename emp manu_emp_cbp

tempfile cbp00
save `cbp00', replace

use "$cpbdir\cbp2007.dta", clear

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

gen year = 2007

keep year fips emp 
rename emp manu_emp_cbp

tempfile cbp07
save `cbp07', replace

/***************************************/

append using `cbp00'
append using `cbp90'

tab year 
sort fips year

save "$cpbdir\cbp_allyears.dta", replace