%macro fastclus(dset,seedsdset,numclus,inlib=OUTPUTS,outlib=OUTPUTS,noprint=NO,fcvars=ctylat
ctylon);

%if "&noprint."="YES" %then %do ;
%put "ENTERING FASTCLUS " ;
%printjunk ;

%end; 


/* suggested by documentation to normalize everything */
proc standard mean=0 std = 1 data = &inlib..&dset. out=standardized ;
	var %unquote(&fcvars.); 
run; 

proc standard mean=0 std= 1 data = &seedsdset. out=stanseeds ;
	var %unquote(&fcvars.); 
run; 


proc fastclus data = standardized
	seed = stanseeds 
	noprint 
	maxclusters = &numclus. maxiter = 1000 
	out = &outlib..clusters_&dset. ;
	var %unquote(&fcvars.) ; 
run; 
/*
proc print data = &outlib..clusters_&dset. ; 
run; 	

proc freq data = &outlib..clusters_&dset. ; 
	table cluster;  
run; 
*/

%if "&noprint."="YES" %then %do ;

%printlog ;
%put "LEAVING FASTCLUS" ;
%end; 

proc contents data = &outlib..clusters_&dset. ; 
run; 

%mend fastclus ; 
