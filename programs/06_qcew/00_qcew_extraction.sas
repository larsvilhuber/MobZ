/* convert the concatenated QCEW data to Stata */

%include "../config.sas";


%macro extract ; 

    
data bls_us_county (keep = fips naics2 /*annual_avg_emplvl*/ emp_month1 year quarter) ; 
    set INPUTS.bls_us_county (where=(  
                            ownership_code ='5'
                            and aggregation_level='74' and naicssec ne '99')) ;
    fips = state||county ; 
    naics2 = naicssec; 
run;

/* sort by info */
proc sort data=bls_us_county nodupkey;
by fips naics2 year quarter;
run;

data qcew_county (keep = fips naics2 annual_avg_emplvl year);
  set bls_us_county;
  by fips naics2 year quarter;
  retain annual_empl n_recs;
  if first.year then do;
	annual_empl = .;
        n_recs = 0;
  end;
  annual_empl + emp_month1;
  n_recs+1;
  if last.year then do;
     annual_avg_emplvl = annual_empl/n_recs;
     output;
  end;
run;

proc export data=qcew_county  
                  outfile = "&diroutputs./qcew_county.dta" replace 
                  dbms=dta ; 
run;

/* intermediate file, for debugging */                               
proc export data=bls_us_county  
                  outfile = "&dirinterwrk./bls_us_county.dta" replace 
                  dbms=dta ; 
run;
                               
    
%mend extract ; 
    
%extract;
