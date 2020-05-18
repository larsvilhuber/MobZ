cd "$indir\nhgis0001_fixed"

set more off
foreach suff in female manu pop { 
	use 1970`suff', clear
	sort fips
	save 1970`suff',replace
}

foreach suff in female manu { 
	merge 1:1 fips using 1970`suff'
	tab _merge
	drop _merge
} 
gen year = "1970"
keep pop* female* fips manu_emp  total_emp bachelors year
tempfile 1970census
save `1970census', replace

cd "$indir\nhgis0006_fixed"

foreach suff in manu pop { 
	use 1980`suff', clear
	sort fips 
	save 1980`suff', replace
} 

	merge 1:1 fips using 1980manu
	tab _merge
	drop _merge
	cap drop year
	gen year = "1980"
tempfile 1980census
save `1980census', replace
local j = 3
foreach yr in 1990 2000 2009 {

cd "$indir\nhgis000`j'_fixed"

	foreach suff in pop emp { 
		use `yr'`suff', clear
		sort fips
		save `yr'`suff',replace
	} 
	merge 1:1 fips using `yr'pop
	tab _merge
	drop _merge
	gen year = "`yr'"
	tempfile `yr'census
	save ``yr'census', replace
	local j = `j' + 1 
} 
use `1970census', clear
foreach yr in  1980 1990 2000 2009 { 
	append using ``yr'census', force
} 
destring year, force replace
drop if real(fips)>56999
replace female_pop_16_65 = femalepop_16_65 if year == 1970

keep pop* female* fips manu_emp  total_emp foreign bachelors year
drop femalepop*

order fips year 

tab year

sort fips year

save "$datadir\censusdata.dta", replace

cd "$datadir"

use cty_industry1980, clear
gen year = 1980

append using cty_industry1990
replace year = 1990 if year == .

append using cty_industry2000
replace year = 2000 if year == .

tostring cty_fips, gen(fips) force

replace fips = "0"+fips if length(fips)==4 
tab year 

save industry_data, replace
