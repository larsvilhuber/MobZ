%macro objectivefunction_norm(clusdset,flowsyear,inlib=OUTPUTS,outlib=OUTPUTS,otherlib=OUTPUTS,noprint=YES) ;

/**************************x
This option is done when I 
loop over the macro a lot, in
order to keep the logfile to a
managable size; nothing
important happens in the
macro, the output is what we
about
**************************/
%if "&noprint."="YES" %then %do ;
%put "ENTERING OBJECTIVEFUNCTION.SAS" ;
%printjunk ;

%end; 


%if %eval(&flowsyear.> 2010) %then %do ;
	%let flowdset = ctypairs_lodes_&flowsyear. ; 
	%let resdata = reslf_lodes_&flowsyear. ;
%end ;
%else %if %eval(&flowsyear.=1990 or &flowsyear.=2000)%then %do ; 
	%let flowdset = flows_jtw&flowsyear. ;
	%let resdata = reslf_jtw&flowsyear. ;
%end; 
%else %if "&flowsyear." = "2010" %then %do ;
	%let flowdset = flows_jtw2009 ;
	%let resdata = reslf_jtw2009 ;
%end; 
/********************************
This macro is going to calculate
the objective function in the following
steps:

1. Calculate each component of objfn
2. Merge them all together
3. Add them all up
4. Output dataset is one observation with
	value of objective function
********************************/
/******************************
Pre-prepping commuting data 
*******************************/
/* proc contents data=OUTPUTS.&flowdset.;
run;
proc contents data=OUTPUTS.&resdata.;
run;
*/
proc sort data= OUTPUTS.&flowdset. out= flows (rename=(home_cty =cty)); 
	by home_cty ; 
run; 

proc sort data = OUTPUTS.&resdata. out=reslf (rename=(home_cty=cty));
	by home_cty ; 
run ;

data flows_reslf ;
	merge flows reslf ;
	by cty ;
run; 

proc sort data = flows_reslf;
	by cty ;
run; 


/* Dataset that includes all relevant variables */
proc sort data = &inlib..obj_inputs_&flowsyear. out=obj_inputs;
	by cty ; 
run; 

proc print data = obj_inputs;
run; 

proc sort data = &inlib..&clusdset. out=clussorted (keep=cty cluster) 	;
	by cty ;
run; 

data merged ;
	merge obj_inputs clussorted ;
	by cty ;
run; 

/* components: 
1. SD of urate within cluster
2. SD of hiring rate
3. commuting flows to outside of cluster
4. commuting flows from outside of cluster
*/


/************************
 1.variation in urate 
 ************************/

proc summary data = merged nway;
	class cluster ;
	var urate ; 
	output out = norm_urate std(urate) = sd_urate; 
run; 

proc summary data = norm_urate nway ; 
	var sd_urate ;
	output out = norm_urate mean(sd_urate)= avg_sd_urate ;
run; 

/***********************
2. Variation in earnings
*************************/
proc summary data = merged nway;
	class cluster ;
	var earnings ; 
	output out = norm_earnings std(earnings) = sd_earnings;
run; 

proc summary data = norm_earnings nway;
	var sd_earnings;
	output out = norm_earnings mean(sd_earnings) = avg_sd_earnings;
run;
/**********************
 3. commuting flows to outside cluster AND from outside cluster in
 (previous just the first, but update for speed )
 ***********************/	
data hctymerged;
	merge flows_reslf clussorted; 
	by cty; 
run; 

proc sort data = hctymerged out=flows ;
	by work_cty ; 
run; 

data allclusmerged ;
	merge flows clussorted (in =a rename=(cluster=work_cluster cty=work_cty));
	by work_cty ;
	if a ;
	if cluster ne . ;
run; 

proc sort data = allclusmerged ;
	by cluster ; 
run; 

data cluster_outflows (keep= cluster frac_outflows reslf_tot);
	set allclusmerged ;
	by cluster ;
	retain flowcount reslf_tot;
	if first.cluster then do ;
		flowcount = 0 ;
		reslf_tot = 0; 
		*put flowcount reslf_tot ;
	end; 
	
	if cluster ne work_cluster then flowcount = flowcount + jobsflow ; 
	reslf_tot  = reslf_tot + jobsflow ; 
	
	if last.cluster then do ; 
		frac_outflows = flowcount/reslf_tot ;
		*put cluster frac_outflows flowcount reslf_tot jobsflow;  
		output cluster_outflows ; 
	end;
run;

proc sort data = allclusmerged ;
	by work_cluster; 
run; 

data cluster_inflows (keep = work_cluster frac_inflows);
	merge allclusmerged cluster_outflows (rename=(cluster=work_cluster)); 
	by work_cluster ;
	retain flowcount;
	if first.work_cluster then do;
		flowcount = 0 ; 
	end; 
	
	if cluster ne work_cluster then flowcount= flowcount +jobsflow ; 
	
	if last.work_cluster then do ;
		frac_inflows = flowcount/reslf_tot ;
		output cluster_inflows ;
	end ;
run;

proc summary data = cluster_outflows nway ;
	var frac_outflows ;	
	output out = mean_outflows mean(frac_outflows) = share_outflows;
run; 

proc summary data = cluster_inflows nway ;
	var frac_inflows ;
	output out = mean_inflows mean(frac_inflows) = share_inflows ;
run; 

/**********************************
Now merging them all together
**********************************/

data &outlib..randomnorm ;
	merge mean_inflows mean_outflows norm_urate norm_earnings /*hrate*/ ;
run;

/**********************
TURNING LOG BACK ON
**********************/
%if "&noprint."="YES" %then %do ;

	%printlog ;
	%put "LEAVING OBJECTIVEFUNCTION.SAS" ;
%end; 
/*
proc print data = objfntest noobs; 
run; 
*/


%mend objectivefunction_norm ;
