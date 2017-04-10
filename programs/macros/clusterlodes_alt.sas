%macro clusterlodes_alt(year,inlib=OUTPUTS,outlib=OUTPUTS) ;

*Performing cluster routine ;

/* First creating a shell of the counties */

%put "Inside of CLUSTERLODES" ;

%macro skip ; 
proc sql nowarn;
     create table ctyshell as
         select * 
         from 

            &inlib..reslf_lodes_&year. (keep=home_cty) a,
              &inlib..reslf_lodes_&year. (keep=home_cty rename=(home_cty=work_cty)) b
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

%mend skip ; 

proc  sort data = &inlib..ctyshell out=  ctyshell ; 
	by home_cty work_cty ;
run; 

proc sort data = &inlib..ctypairs_lodes_&year. out = ctypairs;
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

data clustermatrix_lodes_&year. ; 
	format home_cty $10. ;
	set clustermatrix ;
	home_cty = "cty"||home_cty ; 
run ;

proc cluster 	method =average 
		data = clustermatrix_lodes_&year.
			outtree=&outlib..clustertree_lodes_&year.; 	
	id home_cty ;
run ; 
	
/* When iterating, these add up to take up a lot of memory */
proc datasets ; 
	delete clustermatrix_lodes_&year. clustermatrix cluster ctyshell ctypairs ;
run ;

%mend clusterlodes_alt ;

