%macro objectivefunction_norm1(clusdset,flowsyear,inlib=OUTPUTS,outlib=OUTPUTS,otherlib=OUTPUTS,noprint=NO) ;

/**************************
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
proc contents data=OUTPUTS.&flowdset.;
run;
proc contents data=OUTPUTS.&resdata.;
run;

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


/* Dataset that includes all relevant variables 
proc sort data = &inlib..obj_inputs_&flowsyear. out=obj_inputs;
	by cty ; 
run; 
*/
proc sort data = &inlib..&clusdset.  out=clussorted (keep=county cluster) 	;
	by county ;
run; 
        
        proc contents data=&inlib..&clusdset. ; 
            title 'input cluster contents' ;
        run;
            
        proc print data=&inlib..&clusdset. (obs=20) ;
            title 'input print';
        run;
/*
data merged ;
	merge obj_inputs clussorted ;
	by cty ;
run; 
*/
/* components: 
1. SD of urate within cluster
2. SD of hiring rate
3. commuting flows to outside of cluster
4. commuting flows from outside of cluster
*/

proc contents data= &inlib..&clusdset. ;
run;
/************************
 1.correlation of urate
 ************************/

%cluster_correlation(&inlib..&clusdset.,OUTPUTS.corrlong_urates,cluster,corr) ;


proc summary data = corrclusters nway;
	var mean_corr ; 
	output out = urate mean(mean_corr) = meancorr_urate; 
run; 

data urate;
    set urate; 
    meancorr_urate=meancorr_urate ;
run;

/***********************
2. Variation in earnings
*************************/

%cluster_correlation(&inlib..&clusdset.,OUTPUTS.corrlong_earnings,cluster,corr) ;

proc summary data = corrclusters nway;
	var mean_corr ; 
	output out = earnings mean(mean_corr)= meancorr_earnings;
run;
    
data earnings;
    set earnings; 
    meancorr_earnings=meancorr_earnings ;
run;    

/**********************
 3. commuting flows to outside cluster AND from outside cluster in
 (previous just the first, but update for speed )
 ***********************/	
    
  
data hctymerged;
	merge flows_reslf clussorted (rename=(county=cty)); 
	by cty; 
        if work_cty ne '' ;
run; 
        
proc print data=hctymerged (obs=20) ;
    title 'check' ; 
run;        

proc sort data = hctymerged (where=(work_cty ne ''))  out=flows ;
	by work_cty ; 
run; 

data allclusmerged ;
	merge flows clussorted (in =a rename=(cluster=work_cluster county=work_cty));
	by work_cty ;
	*if a ;
	*if cluster ne . ;
run; 
    
proc print data=allclusmerged (obs=20) ;
    title 'check' ; 
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

data mean_outflows ;
	set mean_outflows ;
	share_outflows = share_outflows;
run; 

proc summary data = cluster_inflows nway ;
	var frac_inflows ;
	output out = mean_inflows mean(frac_inflows) = share_inflows ;
run; 

data mean_inflows ;
	set mean_inflows ;
	share_inflows = share_inflows;
run; 

/**********************************
Now merging them all together
**********************************/

data &outlib..objectivefn (keep=objfn share_inflows share_outflows meancorr_urate meancorr_earnings) ;
	merge mean_inflows mean_outflows urate earnings ;
	objfn = (meancorr_urate+meancorr_earnings-share_inflows-share_outflows)/4 ;    
run;

proc print data=&outlib..objectivefn ;
    title 'objective function for &ii.' ;
run;

/**********************
TURNING LOG BACK ON
**********************/
%if "&noprint."="YES" %then %do ;

	%printlog ;
	%put "LEAVING OBJECTIVEFUNCTION.SAS" ;
%end; 

%mend objectivefunction_norm1 ;
    
