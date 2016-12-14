%macro cluster_naming(dset,outdset,resdat,inlib=OUTPUTS,outlib=OUTPUTS,otherlib=OUTPUTS) ;

proc sort data = &inlib..&dset. out = clusterssorted  ;
	by county ; 
run ;

proc sort data = &otherlib..&resdat. out=reslf_naming (rename=(cty=county)); 
	by cty ;
run ; 
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
run ;

data final ;
	merge clusters_reslf largest_cty ;
	by cluster ; 
run ;
/*
proc print data = final (obs = 50) ;
run ;
*/
data &outlib..&outdset. (keep=clustername county);
	set final ;
	clustername = "CL"||bigcounty ;
run ; 
/*
proc freq data = &outlib..&outdset. ;
	table clustername ; 
run ; 
*/

%mend cluster_naming ; 
