/* Aggregate geography to clustering level */
proc contents data=GEO.blk_xwalk_wide;
run;
proc contents data=LODES.od_us_&year._jt&jt._s000_1;
run;

/* LODES file is already sorted by h_geocode w_geocode */
data od_us;
	set LODES.od_us_&year._jt&jt._s000_1 ;
run;

/* Add county codes onto OD by workplace and home */
proc sort data=GEO.blk_xwalk_wide (keep=stfid fipsstco) out = blk_xwalk_sorted ; 
	by stfid ;
run ; 
data od_us_blockmerge (rename=( fipsstco=home_cty)); 
	merge od_us 
		blk_xwalk_sorted (rename=(stfid = h_geocode));
	by h_geocode ; 	
run ;			
proc sort data= od_us_blockmerge ;
	by w_geocode ;
run; 
data od_us_blockmerge (rename=( fipsstco=work_cty)); 
		
	merge od_us_blockmerge 
		blk_xwalk_sorted (rename=(stfid=w_geocode));
	by w_geocode ;
	if fipsstco < 56999 and home_cty <56999 ;
run ;

data od_us_blockmerge ;
	format home_cty work_cty $5. ;
	set od_us_blockmerge ; 
run ; 			

/* Now totalling up jobs between h_geocode and w_geocode */
proc sort data = od_us_blockmerge ;
	by home_cty work_cty ;
run ; 

data OUTPUTS.flows_lodes (keep = home_cty work_cty jobsflow);
	retain home_cty work_cty jobsflow  ;
	set od_us_blockmerge ;
	by home_cty work_cty ;
	if first.work_cty then jobsflow = 0 ; 
	jobsflow = jobsflow + jobs ; 
	if last.work_cty then output OUTPUTS.flows_lodes ;
run;

proc contents data = OUTPUTS.flows_lodes varnum; 
	title "Contents of County Commuting Flows Dataset - LODES" ;
run ; 	

proc means data=OUTPUTS.flows_lodes ; 
	title "Summary of OD at county level" ;
	var jobsflow;
run ; 		
