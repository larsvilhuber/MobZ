/* set globals */
#delimit ;
    
    global data "" ;
    global outdir "$data" ;
    global czonedata "" ;
/* prep czone data */
use "$czonedata/czones.dta" , clear;
sort fips ;
tempfile czone ;
save `czone', replace ; 

keep czone ;
tempfile czone_levels ;
save `czone_levels', replace; 

/* read in data */
use "$data/qcew_county.dta", clear ;

destring naics2, replace ; 

preserve ;

collapse (first) fips, by(naics2 year) ;
keep naics2 year ; 

cross using `czone_levels' ; 

tempfile shell;
save `shell', replace; 

restore ; 


sort fips ;


/* merge in czone data */
merge fips using `czone' ;

tempfile mainfile ;
save `mainfile', replace ;

/* create base year distribution */

bys naics2 czone: egen L_ij1990 = sum(annual_avg_emplvl*(year==1990)) ;
bys czone: egen L_1990 = sum(annual_avg_emplvl*(year==1990)) ;

gen gamma_ij1990 = L_ij1990 / L_1990 ;

collapse (first) gamma_ij1990, by(czone naics2) ;
sort czone naics2;
tempfile base_year ;
save `base_year', replace;


/***============================
creating employment changes
=====************************/

use `mainfile' ;

bys naics2 year: egen EMP_jt = sum(annual_avg_emplvl) ; 

collapse (sum) EMP_jt = annual_avg_emplvl, by(naics2 year) ;
sort naics2 year ; 
xtset naics2 year ;

gen delta_emp_jt = log(EMP_jt) - log(L.EMP_jt) ;

tempfile industry_by_year ;
save `industry_by_year' , replace ;

/* this dataset to merge into needs to be czone by industry by year */

use `shell', clear;

 sort czone naics2  ;
merge czone naics2 using `base_year' ;

drop _merge ;

sort naics2 year ;
merge naics2 year using `industry_by_year', keep(delta_emp_jt)  ;

bys czone year: egen bartik_it = sum(delta_emp_jt*gamma_ij1990) ;
keep czone year bartik_it ; 
tempfile bartik ;
save `bartik', replace ;
/***** CZONE by YEAR ******/

/******** MERGE ********/

    [read in shell data]
