
include "../config.do"

* import delimited "$raw/bea_table30.csv", clear ; 
/* the last three lines contain unwanted footnotes */
/* We use shell script here to remove them */
/* On windows, do this manually! */

tempfile a
! head -n -3 "$raw/CAINC30__ALL_AREAS_1969_2018.csv" > `a'
//insheet using "${raw}/jtw2009_2013.csv", names
insheet using "`a'", names

#delimit ; 

keep if linecode == 70 ; 

destring geofips, replace;
keep if floor(geofips/1000) != geofips/1000 ;

forvalues i = 29/54 { ;
	local yr = `i'+1961 ; 
	rename v`i' uireceipt`yr' ;

};

keep geofips uireceipt* ;
reshape long uireceipt ,i(geofips) j(year) ;

rename geofips fips ; 
destring uireceipt, force replace ; 
tostring fips, replace; 
replace fips = "0"+fips if length(fips) == 4 ; 
save "$interwrk/bea_table30.dta", replace;  
outsheet using "$interwrk/bea_table30.csv", replace noquote comma;

/* create summary stats */
sum;
codebook;
 

