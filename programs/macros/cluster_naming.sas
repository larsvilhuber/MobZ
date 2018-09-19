%macro cluster_naming(dset,outdset,resdat,inlib=OUTPUTS,outlib=OUTPUTS,otherlib=OUTPUTS,noprint=NO) ;

%if "&noprint."="YES" %then %do ;
%put "ENTERING CLUSTER_NAMING " ;
%printjunk ;

%end;

proc sort data = &inlib..&dset. out = clusterssorted  ;
	by county ; 
run;
/*
proc contents data=&otherlib..&resdat. ;
    title 'reslf dataset ' ;
run;
*/
proc sort data = &otherlib..&resdat. out=reslf_naming (rename=(home_cty=county)); 
	by home_cty ;
run; 
/*
proc contents data = reslf;
run ;

proc contents data=clusterssorted ;
run ;
*/
data clusters_reslf (keep = reslf county cluster);
	merge clusterssorted (in=a)
		 reslf_naming ;
	by county ;
	if a; 
run ;

proc sort data=clusters_reslf ;
	by cluster reslf ;
run;

data largest_cty (keep=cluster bigcounty) ;
	set clusters_reslf ;
	by cluster; 
	if last.cluster then do ;
		bigcounty = county ;
		output largest_cty ;
	end ;
run;

data final ;
	merge clusters_reslf largest_cty ;
	by cluster ; 
run;

proc sort data=final ;
    by county ; 
run;
/*
proc print data = final (obs = 50) ;
run ;
*/
data &outlib..&outdset. (keep=clustername county);
	set final ;
	clustername = "CL"||bigcounty ;
run;

proc print data=&outlib..&outdset.  (obs=100) ;  
    title 'qa check on cluster naming process' ;
run;
 
/*
proc freq data = &outlib..&outdset. ;
	table clustername ; 
run ; 
*/

%if "&noprint."="YES" %then %do ;
%printlog ;
%put "LEAVING Cluster Naming" ;
%end; 

%mend cluster_naming ; 
