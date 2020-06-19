/****************************************
This dofile creates the RHS for the outcome
*****************************************/
    
    
use "$datadir/cw_cty_czone.dta", clear
sort cty_fips
tempfile czone
save `czone', replace

use "$datadir/adh_data/sic87dd_trade_data.dta", clear

bys year sic87dd: egen M_ucjt = sum(imports*(exporter=="CHN")*(importer=="USA"))

bys year sic87dd: egen M_ocjt = sum(imports*(exporter=="CHN")*(importer=="OTH"))

*keep if (importer=="USA" | importer == "OTH") & exporter == "CHN"

keep if year == 1991 | year == 2000 | year == 2007
collapse (first) M*, by(sic87dd year) 

/* this is fixing an issue with two of the sic codes that only show up in 2006 */
expand 3 if year == 2007 & (sic87dd == 2992 | sic87dd==3273)
bys sic87dd year: egen seq = seq() 
replace year = 2000 if seq == 3
replace year = 1990 if seq == 2
replace M_ucjt = 0 if seq > 1
replace M_ocjt = 0 if seq > 1 
drop seq

sort sic87dd year 

gen del_M_ucjt = M_ucjt[_n+1]-M_ucjt if year<2007
gen del_M_ocjt = M_ocjt[_n+1]-M_ocjt if year<2007
/*all missings are from 2007, which is by construction */

/*	replace del_M_ucjt = M_ucjt[_n+1] if (sic87dd == 2992 | sic87dd==3273)
	replace del_M_ucjt = 0 if (sic87dd == 2992 | sic87dd==3273) & year == 2000
	
	replace del_M_ocjt = M_ocjt[_n+1] if (sic87dd == 2992 | sic87dd==3273)
	replace del_M_ocjt = 0 if (sic87dd == 2992 | sic87dd==3273) & year == 2000
*/
drop if year == 2007
replace year = 1990 if year == 1991 

keep del* M_* sic87dd year

sort sic87dd year
tempfile tradedata
save `tradedata', replace

/**************** COUNTY BY INDUSTRY BY YEAR *************/
use "$datadir/industry_data.dta", clear

drop if fips == "30113" | (substr(fips,1,2)=="02" | substr(fips,1,2) == "15")
preserve 

collapse (sum) emp, by(sic87dd year)

rename emp L_ujt 

sort sic87dd year
tempfile ind_emp 
save `ind_emp', replace

restore



sort cty_fips 
merge cty_fips using `czone'
tab _merge
drop if _merge == 2
 
collapse (sum) emp tot_emp_cty, by(czone sic87dd year)

rename emp L_ijt
rename tot_emp_cty L_it 

sort sic87dd year
merge sic87dd year using `ind_emp'
tab _merge

drop _merge

sort sic87dd year
merge sic87dd year using `tradedata'

tab _merge
*drop _merge

sort czone sic87dd year 

gen first_frac_u = L_ijt/L_ujt
gen second_frac_u = del_M_ucjt/L_it

gen first_frac_o = L_ijt[_n-1]/L_ujt[_n-1] if year!=1980
gen second_frac_o = del_M_ocjt/L_it[_n-1] if year!=1980

bys czone year: egen IPW_uit =  sum(first_frac_u*second_frac_u)
bys czone year: egen IPW_oit = sum(first_frac_o*second_frac_o)

collapse (first) IPW*, by(czone year) 

label variable IPW_uit "Import Competition from China for county i"
label variable IPW_oit "Import Flows to Other Rich Nations (instrument)"

save "$datadir/IPW_czone.dta", replace
