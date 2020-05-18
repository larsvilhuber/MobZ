/****merge together all the data at 1990 cz level****/


global datadir "/data/working/mobz/replication"
global logdir "/programs/projects/mobz2/replication/logfiles"
    

/************* READ IN COMMUTING ZONE XWALK *******************/
import delimited "$datadir/czones.csv", clear 

tostring fips, replace force
replace fips = "0" + fips if length(fips) == 4
*replace fips = "12086" if fips == "12025"
sort fips 
rename czone1990 czone
tempfile czone 
save `czone', replace


use  "$datadir/cty_censusdata.dta", clear


sort fips 
merge m:1 fips using `czone'
tab _merge 
tab fips if _merge == 1
drop if _merge != 3 
drop _merge

drop if substr(fips,1,2) == "02" | substr(fips,1,2) == "15" 

#delimit ;
collapse (sum) manuemp_adh manufacturing_emp totalpop total_employment pop_16_65 population_census_1665 female_emp manu_emp 
				bachelors total_emp female_pop_16_65 foreign manu_emp_cbp , by(czone year);
#delimit cr

label variable manufacturing_emp "Manufacturing Employment, QCEW"
label variable manu_emp "Manufacturing Employment, Census"

label variable total_employment "Total Employment, QCEW"
label variable total_emp "Total Employment, Census"
tab year

xtset czone year

gen L_m = 100*manu_emp/population_census_1665

gen del_L_m = F10.L_m - L_m if year == 1990
	replace del_L_m = F7.L_m - L_m if year == 2000
	/***** CONVERTING TO DECADAL CHANGE *****/
	replace del_L_m = 10*del_L_m/7 if year == 2000
	
	
gen L_mprime = 100*manufacturing_emp/population_census_1665

gen del_L_mprime = F10.L_mprime - L_mprime if year == 1990
	replace del_L_mprime = F7.L_mprime - L_mprime if year == 2000
	/***** CONVERTING TO DECADAL CHANGE *****/
	replace del_L_mprime = 10*del_L_mprime/7 if year == 2000
	
gen L_mprime2 = 100*manu_emp_cbp/population_census_1665

gen del_L_mprime2 = F10.L_mprime2 - L_mprime2 if year == 1990
	replace del_L_mprime2 = F7.L_mprime2 - L_mprime2 if year == 2000
	/***** CONVERTING TO DECADAL CHANGE *****/
	replace del_L_mprime2 = 10*del_L_mprime2/7 if year == 2000
	
tempfile mainfile
save `mainfile', replace

/**************** READING IN IPW *******************/

use "$datadir/IPW_czone.dta", clear

sort czone year

tempfile ipw
save `ipw',replace
/*************** MERGING IT ALL TOGETHER *****************/
use `mainfile', clear

sort czone year
merge 1:1 czone year using `ipw'
tab _merge
tab year _merge 
drop if _merge == 2
drop _merge

bys year: egen tot_pop_16_65 = sum(pop_16_65)

gen share_czpop = pop_16_65/tot_pop_16_65

foreach suff in uit oit  { 
    replace IPW_`suff' = IPW_`suff'/0.7 if year == 2000
    replace IPW_`suff' = IPW_`suff'/0.9 if year == 1990
}                           


save "$datadir/finalczdata.dta", replace
