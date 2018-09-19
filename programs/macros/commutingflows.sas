%macro commutingflows(clusdset,flowsyear,inlib=OUTPUTS,outlib=OUTPUTS,otherlib=OUTPUTS,noprint=NO) ;

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

proc sort data = &inlib..&clusdset.  out=clussorted (keep=county cluster) 	;
	by county ;
run; 
        

data reslf_clusters ;
   merge reslf (rename=(cty=county)) clussorted ;
   by county ; 
run;   

/******* TOTAL RESLF BY CLUSTER ***********/
proc summary data=reslf_clusters nway; 
    var reslf ;
    class cluster ;
    output out = reslf_clus sum(reslf)=reslf_clus ; 
run;
data hctymerged;
	merge flows_reslf clussorted (rename=(county=cty)); 
	by cty; 
        if work_cty ne '' ;
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

data cluster_inflows (keep = work_cluster frac_inflows reslf_tot );
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
        weight reslf_tot;	
	output out = mean_outflows mean(frac_outflows) = share_outflows;
run; 

proc summary data = cluster_inflows nway ;
	var frac_inflows ;
        weight reslf_tot; 
	output out = mean_inflows mean(frac_inflows) = share_inflows ;
run; 
/*
data mean_inflows ;
	set mean_inflows ;
	share_inflows = share_inflows/&inflows.;
run; 
*/
/**********************************
Now merging them all together
**********************************/

data &outlib..objectivefn (keep= share_inflows share_outflows ) ;
	merge mean_inflows mean_outflows ;
run;

%mend commutingflows ;
