/* convert the concatenated QCEW data to Stata */

%include "../config.sas";


%macro extract ; 

    
data qcew_county (keep = fips naics2 /*annual_avg_emplvl*/ emp_month1 year quarter) ; 
    set INPUTS.bls_us_county (where=(  
                            ownership_code ='5'
                            and aggregation_level='74' and naicssec ne '99')) ;
    fips = state||county ; 
    naics2 = naicssec; 
run;

/* sort by info */
proc sort data=qcew_county nodupkey;
by fips naics2 year quarter;
run;

data qcew_county (keep = fips naics2 annual_avg_emplvl year);
  set qcew_county;
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
    
data qcew_earnings (keep = fips year quarter /*avg_annual_pay annual_avg_emplvl*/ empl_month1 total_wage) ;
    set INPUTS.bls_us_county /* (where=( quarter=1 and aggregation_level='70'))*/ ;
    fips = state||county ; 
run;
/* sort by info */
proc sort data=qcew_earnings;
by fips year quarter;
run;

data qcew_earnings (keep = fips annual_avg_emplvl avg_annual_pay year);
  set qcew_earnings;
  by fips year quarter;
  retain annual_empl annual_wage  n_recs;
  if first.year then do;
	annual_empl = .;
        annual_wage = .;
        n_recs = 0;
  end;
  annual_empl + emp_month1;
  annual_wage + total_wage;
  n_recs+1;
  if last.year then do;
     annual_avg_emplvl = annual_empl/n_recs;
     avg_annual_pay = annual_wage/n_recs;
     output;
  end;
run;


proc export data=qcew_earnings 
               outfile = "&diroutputs./qcew_earnings.dta" replace
               dbms=dta;
                           
    
%mend extract ; 
    
%extract;
