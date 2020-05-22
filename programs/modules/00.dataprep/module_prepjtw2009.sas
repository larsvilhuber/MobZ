
data OUTPUTS.flows_jtw2009 (keep = home_cty work_cty jobsflow moe);
	infile "&raw./jtw2009_2013.csv" dsd delimiter = ',' firstobs=2 ;
	length work_cty $5. home_cty $5.;
	input h_st $ h_cty $ w_st $ w_cty $ jobsflow moe	 ;
	if substr(w_st,1,1) = '0' or
	    substr(w_st,1,1) = '7' or substr(h_st,1,1)='7'; 
	    /*This gets rid of all foreign commutes and territories.*/
	home_cty = trim(h_st)||trim(h_cty)	 ;
	work_cty = substr(w_st,2,2)||trim(w_cty)	 ; 
run ;

proc contents data = OUTPUTS.flows_jtw2009 ; 
run ; 

proc print data = OUTPUTS.flows_jtw2009 (obs = 40) ;
run;  
