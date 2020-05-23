%macro cluster(dset=jtw1990,inlib=OUTPUTS,outlib=OUTPUTS,noprint=NO);

%if "&noprint."="YES" %then %do ;
%put "ENTERING REVIEW " ;
%printjunk ;
    
%end;

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
/*
proc contents data = ctyshell ;
run;
*/
data ctyshell ; 
	set ctyshell ; 
	if home_cty ne '' and  work_cty ne '' ; 
run;

proc sort data = ctyshell ; 
	by home_cty work_cty ; 
run; 

proc sort data = &inlib..ctypairs_&dset. out = ctypairs;
	by home_cty work_cty ; 
run; 

data cluster (keep = home_cty work_cty d_ij) ;
	merge ctyshell (in=a) ctypairs (in=b) ;
	by home_cty work_cty ; 
	if a ; 
	if home_cty= work_cty then p_ij = 1 ; 
	if p_ij = . then p_ij = 0 ;
	d_ij = 1-p_ij ;  
run; 
/*
proc contents data= cluster;  
run; 


proc means data = cluster  N NMISS MEAN STD P1 P5 P50 P95 P99 MAX;
	var d_ij ;
run;
*/
proc transpose data = cluster 
		out = clustermatrix 
		PREFIX = cty ; 
		
		by home_cty ;
		id work_cty ; 
		var d_ij ;
run;

data clustermatrix_&dset. ; 
	format home_cty $10. ;
	set clustermatrix ;
	home_cty = "cty"||home_cty ; 
run;

proc cluster 	method =average 
		data = clustermatrix_&dset.
			outtree=&outlib..clustertree_&dset.	; 	
	id home_cty ;
run; 
	
/* 
proc tree horizontal maxheight=&cutoff.	;
	id home_cty ;
run ; 


proc freq data=clustermatrix_&dset. ;
    table home_cty ;
run; 
*/
/* When iterating, these add up to take up a lot of memory */
proc datasets nolist ; 
	delete clustermatrix_&dset. clustermatrix cluster ctyshell ctypairs ;
run;

%if "&noprint."="YES" %then %do ;
%printlog ;
%put "LEAVING REVIEW" ;
%end; 
    
%mend cluster;
