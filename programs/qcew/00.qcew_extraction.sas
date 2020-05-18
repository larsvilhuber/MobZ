libname QCEW [whereqcewlives];



%macro extract ; 

%let outdir = [where outdir] ;    
    
    
data qcew_county (keep = fips naics2 annual_avg_emplvl year) ; 
    set QCEW.bls_us_county (where=( quarter = 1 and 
                            ownership_code ='5'
                            and aggregation_level='74' and naics2 ne '99')) ;
    fips = state||county ; 
    
run;

proc export data=qcew_county  
                  outfile = "&outdir./qcew_county.dta" replace 
                  dbms=dta ; 
run;
    
data qcew_earnings (keep = fips year avg_annual_pay annual_avg_emplvl) ;
    set QCEW.bls_us_county (where=(quarter=1 and aggregation_level='70')) ;
    fips = state||county ; 
run;

proc export data=qcew_earnings 
               outfile = "&outdir./qcew_earnings.dta" replace
               dbms=dta;
                           
    
%mend extract ; 
    
 %extract;
