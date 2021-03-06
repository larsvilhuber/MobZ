/* create a file combining multiple census information sources */
/* pre-requisites: run the NHGIS data read-in scripts under ..../raw */

include "../config.do"

* cd "$indir\nhgis0001_fixed"

set more off
foreach suff in female manu pop { 
	use "$raw/nhgis/1970`suff'", clear
	sort fips
	save "$interwrk/1970`suff'",replace
}

foreach suff in female manu { 
	merge 1:1 fips using "$interwrk/1970`suff'"
	tab _merge
	drop _merge
} 
gen year = "1970"
keep pop* female* fips manu_emp  total_emp year
tempfile 1970census
save `1970census', replace

*cd "$indir\nhgis0006_fixed"

foreach suff in manu pop { 
	use "$raw/nhgis/1980`suff'", clear
	sort fips 
	save "$interwrk/1980`suff'", replace
} 

	merge 1:1 fips using "$interwrk/1980manu"
	tab _merge
	drop _merge
	cap drop year
	gen year = "1980"
tempfile 1980census
save `1980census', replace
local j = 3
foreach yr in 1990 2000 2009 {

*cd "$indir\nhgis000`j'_fixed"

	foreach suff in pop emp { 
		use "$raw/nhgis/`yr'`suff'", clear
		sort fips
		save "$interwrk/`yr'`suff'",replace
	} 
	merge 1:1 fips using "$interwrk/`yr'pop"
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

save "$interwrk/censusdata.dta", replace

