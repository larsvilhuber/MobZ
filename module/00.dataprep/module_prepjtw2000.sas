libname OUTPUTS "./outputs" ;

data OUTPUTS.flows_jtw2000 (keep = home_cty work_cty jobsflow);
	infile './rawdata/jtw2000_raw.txt'  ;
	length work_cty $5. ;
	input h_st $1-2 h_cty $4-6 w_st $59-61 w_cty $63-65 jobsflow 118-124 ;
	if substr(w_st,1,1) = '0' ; /*This gets rid of all foreign commutes */
	home_cty = h_st||h_cty ;
	work_cty = substr(w_st,2,2)||w_cty ; 
run ;


proc contents data = OUTPUTS.flows_jtw2000 ; 
run ; 

proc freq data = OUTPUTS.flows_jtw2000 ; 
	table home_cty / missing;
	table work_cty /missing ;
run ; 


data OUTPUTS.cz2000 (keep = cty cz2000) ;
	length cty $5. ;
	infile './geo/cz2000.csv' dsd  delimiter = ',' termstr=crlf  ;
	input ctycode $ cz2000 $ ;
	cty = ctycode ; 
run ; 	
