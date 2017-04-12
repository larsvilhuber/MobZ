*libname OUTPUTS "./outputs" ;

data OUTPUTS.flows_jtw1990 (keep = home_cty work_cty jobsflow);
	infile "&root./rawdata/1990jtw_raw.txt"  ;
	/* Raw 1990 JTW file is here: https://www.census.gov/hhes/commuting/files/1990/resco/USresco.txt */
	length work_cty $5. ;
	input h_st $1-2 h_cty $4-6 w_st $23-25 w_cty $27-29 jobsflow 46-54 ;
	if substr(w_st,1,1) = '0' ; /*This gets rid of all foreign commutes */
	home_cty = h_st||h_cty ;
	work_cty = substr(w_st,2,2)||w_cty ; 
	if home_cty ne 30113; /*Gets rid of Yellowstone*/
run ;


proc contents data = OUTPUTS.flows_jtw1990 ; 
run ; 

proc contents data = OUTPUTS.regions ;
run ; 

proc sort data = OUTPUTS.regions ;
	by state ; 
run ; 

proc print data = OUTPUTS.regions ; 
run ; 

data OUTPUTS.cz1990 (keep = cty cz1990) ;
	length cty $5. ;
	infile "&root./raw/czones.csv" dsd  delimiter = ',' termstr=lf  ;
	/* Commuting zones are here: https://www.ers.usda.gov/webdocs/DataFiles/Commuting_Zones_and_Labor_Market_Areas__17970//czlma903.xls */
	input ctycode $ cz1990 $ ;
	if cz1990 ne "CZ90"; 
	cty = ctycode ; 
run ; 		

proc sort data = OUTPUTS.cz1990 ;
	by cty ;
run ;	

proc print data = OUTPUTS.cz1990 ; 
run ; 

proc export data=OUTPUTS.flows_jtw1990 outfile= "&root./data/flows1990.dta" replace; 
run;                
