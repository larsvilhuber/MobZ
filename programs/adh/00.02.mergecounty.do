/******************************
This program gets all the relevant datasets
into a county-year form, with all the variables
that we want to calculate.
********************************/

global datadir "/data/working/mobz/replication"
global logdir "/programs/projects/mobz2/replication/logfiles"
    

set more off
***********************
*STEP 1: industry employment
***********************

use "$datadir/cbp_allyears.dta", clear

replace fips = "12025" if fips == "12086" 
sort fips year
tempfile cbp
save `cbp' , replace

use "$datadir/industry_data.dta", clear

collapse (sum) emp, by(cty_fips year) 
tostring cty_fips, gen(fips) force
replace fips = "0" + fips if length(fips) == 4
replace fips = "12025" if fips == "12086"

rename emp manuemp_adh
keep fips year manuemp_adh 
sort fips year 
tempfile adhemp
save `adhemp', replace

**********************
* STEP 2: census data
**********************

use "$datadir/popcounts.dta", clear

rename county fips 
replace fips = "12025" if fips == "12086"
drop if fips == "30113" | (substr(fips,1,2)=="02" | substr(fips,1,2) == "15" )

sort fips year
tempfile population
save `population', replace

use "$datadir/censusdata.dta", clear
replace year = 2007 if year > 2000 

rename  pop_16_65 population_census_1665
replace fips = "12025" if fips == "12086"

sort fips year
merge 1:1 fips year using `population'

tab _merge
tab year _merge
*tab fips if _merge == 2 
drop if _merge == 2
drop _merge

tabstat pop_16_65 population_census_1665, by(year)


sort fips year
merge 1:1 fips year using "$datadir/qcewdata.dta"
tab _merge
drop if _merge == 2
drop _merge
drop if fips == "30113" | (substr(fips,1,2)=="02" | substr(fips,1,2) == "15" )

sort fips year
merge 1:1 fips year using `cbp'
tab _merge
tab year _merge 
drop if _merge == 2 
drop _merge

sort fips year
merge 1:1 fips year using `adhemp'
tab _merge
tab year _merge 
drop if _merge == 2 
drop _merge

sort fips year
tempfile cty_censusdata
save  "$datadir/cty_censusdata.dta", replace

