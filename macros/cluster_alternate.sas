%macro cluster_alternate(dset,inlib=OUTPUTS,outlib=OUTPUTS);

*Performing cluster routine ;

/* First creating a shell of the counties */

proc sql nowarn;
     create table ctyshell as
         select * 
         from 

            &inlib..reslf_&dset. (keep=home_cty) a,
              &inlib..reslf_&dset. (keep=home_cty rename=(home_cty=work_cty)) b
         order by home_cty, work_cty ;	
 quit;

proc contents data = ctyshell ;
run ;

data ctyshell ; 
	set ctyshell ; 
	if home_cty ne '' and  work_cty ne '' ; 
run ;

proc sort data = ctyshell ; 
	by home_cty work_cty ; 
run ; 

proc sort data = &inlib..ctypairs_&dset. out = ctypairs;
	by home_cty work_cty ; 
run ; 

data cluster (keep = home_cty work_cty d_ij) ;
	merge ctyshell (in=a) ctypairs (in=b) ;
	by home_cty work_cty ; 
	if a ; 
	if home_cty= work_cty then p_ij = 1 ; 
	if p_ij = . then p_ij = 0 ;
	d_ij = 1-p_ij ;
run ; 


proc means data = cluster  N NMISS MEAN STD P1 P5 P50 P95 P99 MAX;
	var d_ij ;
run ;

proc transpose data = cluster 
		out = clustermatrix 
		PREFIX = cty ; 
		
		by home_cty ;
		id work_cty ; 
		var d_ij ;
run ;

data clustermatrix_&dset. ; 
	format home_cty $10. ;
	set clustermatrix ;
	home_cty = "cty"||home_cty ; 
run ;

proc cluster 	method =average 
		data = clustermatrix_&dset.
			outtree=&outlib..clustertree_&dset.; 	
	id home_cty ;
run ; 


/**************************** 
Alternative clustering methods
****************************/

proc cluster 	method = density k = 8
		data = clustermatrix_&dset.
			outtree=&outlib..clustertree_&dset._density ;
		id home_cty ;
run ; 	

proc print data = &outlib..clustertree_&dset._density;
	var _NAME_ _PARENT_ _HEIGHT_ ;
run; 

proc cluster 	method = single trim = 10 k = 10	
		data = clustermatrix_&dset.
			outtree=&outlib..clustertree_&dset._single ;
		id home_cty ;
run ; 

proc cluster 	method = twostage mode = 5 k = 10
		data = clustermatrix_&dset.
			outtree=&outlib..clustertree_&dset._twostage ;
		id home_cty ;
run; 

proc cluster 	method = centroid
		data = clustermatrix_&dset.
			outtree=&outlib..clustertree_&dset._centroid ;
		id home_cty ;
run; 

proc cluster 	method = complete
		data = clustermatrix_&dset.
			outtree=&outlib..clustertree_&dset._complete ;
		id home_cty ;
run; 
	

%mend cluster_alternate;
