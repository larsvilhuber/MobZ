
/*****************
Prep Aggregate Data
*******************/

/*********************
Trade data
***********************/

/* source: Autor Dorn Hanson public data files */

use "$adhdata/sic87dd_trade_data.dta", clear

bys year sic87dd: egen M_ucjt = sum(imports*(exporter=="CHN")*(importer=="USA"))

bys year sic87dd: egen M_ocjt = sum(imports*(exporter=="CHN")*(importer=="OTH"))

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

drop if year == 2007
replace year = 1990 if year == 1991 

keep del* M_* sic87dd year

sort sic87dd year

save "$interwrk/tmp_tradedata.dta", replace

/*****************************
National Industry Employment
*****************************/
use "$interwrk/industry_data.dta", clear

collapse (sum) emp, by(sic87dd year)

rename emp L_ujt 

sort sic87dd year

/* used nowhere else? */
save "$interwrk/tmp_industrydata.dta", replace




