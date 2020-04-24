#delimit ; 

import delimited "/data/working/mobz/qcew/bea_table30.csv", clear ; 

keep if linecode == 70 ; 

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
save "/data/working/mobz/qcew/bea_table30.dta", replace;  
