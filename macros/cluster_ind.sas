%macro cluster_ind(range,year,inlib=OUTPUTS,outlib=OUTPUTS);

*Performing cluster routine ;

%if "&range." = "all" %then %do ;
	%let start = 1 ;
	%let end = 3 ; 
%end ; 
%else %do ;
	%let start = &range. ; 
	%let end = &range. ; 
%end ;

/* First creating a shell of the counties */

proc sql nowarn;
     create table ctyshell as
         select * 
         from 

            &inlib..reslf_lodes_&year._ind1 (keep=home_cty) a,
              &inlib..reslf_lodes_&year._ind1 (keep=home_cty rename=(home_cty=work_cty)) b
         order by home_cty, work_cty ;	
quit;


data ctyshell ; 
	set ctyshell ; 
	if home_cty ne '' and  work_cty ne '' ; 
run ;

proc sort data = ctyshell ; 
	by home_cty work_cty ; 
run ; 

proc contents data = ctyshell ;
run ;


********************************** ;
%do ind = &start. %to &end. ; 
********************************** ; 



proc sort data = &inlib..ctypairs_lodes_&year._ind&ind. out = ctypairs;
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

data clustermatrix_lodes_&year._ind&ind. ; 
	format home_cty $10. ;
	set clustermatrix ;
	home_cty = "cty"||home_cty ; 
run ;

proc cluster 	method =average 
		data = clustermatrix_lodes_&year._ind&ind.
			outtree=&outlib..clustertree_&year._ind&ind.; 	
	id home_cty ;
run ; 

proc datasets ;
	delete clustermatrix_lodes_&year._ind&ind. ;
run; 

proc contents data = &outlib..clustertree_&year._ind&ind. ;
run; 

	
%end ; /* end of industry loop */

/* When iterating, these add up to take up a lot of memory */
proc datasets ; 
	delete clustermatrix cluster ctyshell ctypairs ;
run ;
%mend cluster_ind;
