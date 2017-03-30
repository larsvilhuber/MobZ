/******************************
This do-file takes the commuting
zone file (fed from on high), 
collapses everything according to
czone, and then merges it all together
to get del_M and IPW, the key
parts of the estimation
*******************************/

use "[data]/replication/industry_data.dta", clear

drop if fips == "30113" | (substr(fips,1,2)=="02" | substr(fips,1,2) == "15")
sort fips 
merge fips using "$czone_iteration"
tab _merge
drop if _merge == 2
 
collapse (sum) emp tot_emp_cty, by(czone sic87dd year)

rename emp L_ijt
rename tot_emp_cty L_it 

sort sic87dd year
merge sic87dd year using "$datadir/industrydata.dta"
tab _merge

drop _merge

sort sic87dd year
merge sic87dd year using "$datadir/tradedata.dta"

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

sort czone year 

tempfile IPW
save `IPW', replace

/****************************
Manufacturing employment and
Census data
*****************************/

use  "$datadir/cty_censusdata.dta", clear

sort fips 
merge m:1 fips using "$czone_iteration"
tab _merge 
tab fips if _merge == 1
drop if _merge != 3 
drop _merge

drop if substr(fips,1,2) == "02" | substr(fips,1,2) == "15" 

#delimit ;
collapse (sum) manuemp_adh manufacturing_emp totalpop total_employment 
				pop_16_65 population_census_1665 female_emp manu_emp 
				bachelors total_emp female_pop_16_65 foreign 
				manu_emp_cbp , by(czone year);
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
	

sort czone year
merge 1:1 czone year using `IPW'
tab _merge
tab year _merge 

bys year: egen tot_pop_16_65 = sum(pop_16_65)
gen share_czpop = pop_16_65/tot_pop_16_65

gen y2000 = year==2000

erase `IPW' 
/* Now run regression on it, and then get the coefficient and store it */
