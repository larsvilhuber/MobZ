/*******************************
This macro takes 4 arguments, two
of which are required:
1. Range
	All means all industry supersectors, 1-3
	Also can specify single industry (1,2 or 3)
2. Year
	Specifies which year you want to run.
********************************/


%macro preplodes_ind(range,year,inlib=OUTPUTS,outlib=OUTPUTS); 

%if "&range." = "all" %then %do ;
	%let start = 1 ;
	%let end = 3 ; 
%end ; 
%else %do ;
	%let start = &range. ; 
	%let end = &range. ; 
%end ;



/* Add county codes onto OD by workplace and home 
proc sort data=GEO.blk_xwalk_wide (keep=stfid fipsstco) out = GEO.blk_xwalk_sort_stfid ; 
	by stfid ;
run ; 
*/


/* This is already sorted by stfid */
data blk_xwalk_sorted ; 
	set GEO.blk_xwalk_sort_stfid ; 
run;

****************************************;
%do ind = &start. %to &end. ;
****************************************;

/* LODES file is already sorted by h_geocode w_geocode */
data od_us;
	set LODES.od_us_&year._jt&jt._si0&ind._1 ;
run;

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

data flows_lodes_&year._ind&ind. (keep = home_cty work_cty jobsflow);
	retain home_cty work_cty jobsflow  ;
	set od_us_blockmerge ;
	by home_cty work_cty ;
	if first.work_cty then jobsflow = 0 ; 
	jobsflow = jobsflow + jobs ; 
	if last.work_cty then output flows_lodes_&year._ind&ind. ;
run;

proc means data=flows_lodes_&year._ind&ind. ; 
	title "Summary of OD at county level for industry supersector &ind." ;
	var jobsflow;
run ; 	

/*************************
THIS PORTION IS THE GEO 
AGGREGATION TO COUNTY LEVEL
***************************/	

proc sort data = flows_lodes_&year._ind&ind. out =flows;
	by home_cty work_cty ; 
run ; 

proc summary data = flows ;
	class home_cty work_cty ; 
	var jobsflow ;
	output out = flows (keep=home_cty work_cty jobs) sum(jobsflow) = jobs ;
run; 

data flows ; 
	set flows (where=(substr(home_cty,1,2) ne '72' 
			and substr(work_cty,1,2) ne '72' 
			and not missing(home_cty) and not missing(work_cty)));
run ;		
 
/* Calculating residence labor force */		

proc summary data = flows  ;
	class home_cty ; 
	var jobs ;
	output out = &outlib..reslf_lodes_&year._ind&ind. (keep=home_cty reslf) sum(jobs) = reslf ;
run ; 
	
proc sort data = &outlib..reslf_lodes_&year._ind&ind. out = reslf ;
	by home_cty ; 
run ;

/* Now merging it all together */
data ctyflowssorted (keep = h_cty w_cty jobs) ;
	set flows  ; 
	h_cty = work_cty ; 
	w_cty = home_cty ;
run ;

proc sort data = ctyflowssorted (rename=(w_cty = work_cty h_cty = home_cty jobs = w_h_jobflows)) ;
	by home_cty work_cty ; 
run ;

proc sort data = flows out=flows_sort ; 
	by home_cty work_cty ;
run ;

data ctypairs (keep= home_cty work_cty w_h_jobflows h_w_jobflows) ;
	merge ctyflowssorted flows_sort (rename =(jobs=h_w_jobflows)); 	
	by home_cty work_cty ; 
run ; 

data ctypairs (keep= home_cty work_cty w_h_jobflows h_w_jobflows reslf_h) ;
	merge ctypairs reslf (rename=(reslf=reslf_h)) ;
	by home_cty ; 
run ; 

proc sort data = ctypairs ;
 	by work_cty ;
run ; 

data &outlib..ctypairs_lodes_&year._ind&ind. (keep=home_cty work_cty w_h_jobflows h_w_jobflows reslf_h reslf_w p_ij ) ;
	merge ctypairs reslf (rename=(home_cty=work_cty reslf=reslf_w)) ;
	by work_cty ; 
	if h_w_jobflows = . then h_w_jobflows = 0 ; 
	if w_h_jobflows = . then w_h_jobflows = 0 ; 
	
	denominator = min(reslf_h , reslf_w) ;
	p_ij = (h_w_jobflows + w_h_jobflows)/denominator ; 
	if p_ij > 1 then p_ij = 0.999 ;
	if work_cty = home_cty then p_ij = 1 ;
	
	if home_cty ne '' and work_cty ne '' ;
run ;

proc datasets; 
	delete flows_lodes_&year._ind&ind.; 
run; 


%end ; /* End of industry loop */

/*When iterating, these all combine to take up a lot of memory */
proc datasets ; 
	delete ctypairs reslf ctyflowssorted flows od_us_blockmerge  flows;
run ; 

%mend preplodes_ind ; /* End of Macro */
