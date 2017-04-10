%macro geoagg_spectral(infile,outfile,inlib=WORK,outlib=WORK) ;

proc sort data = &inlib..&infile. out =flows;
	by home_cty work_cty ; 
run ; 
    
proc summary data = flows (where=(not missing(home_cty) and not missing(work_cty))) nway;
	class home_cty work_cty ; 
	var jobsflow ;
	output out = flows (keep=home_cty work_cty jobs) sum(jobsflow) = jobs ;
run; 

data flows ; 
    set flows (where=(substr(home_cty,1,2) <= '56' 
            and substr(work_cty,1,2) <= '56'));
run;		
    
    proc print data=flows ; 
        title 'job commuting flows' ;
    run; 
 
/* Calculating residence labor force */		

proc summary data = flows  nway;
    class home_cty ; 
    var jobs ;
    output out = reslf (keep=home_cty reslf) sum(jobs) = reslf ;
run; 
            
proc means data=reslf    min max ;
    title 'min and max of reslf' ;
run;        

proc sort data = reslf ;
    by home_cty ; 
run;

/* Now merging it all together */

data ctyflowssorted (keep = h_cty w_cty jobs) ;
	set flows  ; 
	h_cty = work_cty ; 
	w_cty = home_cty ;
run;

proc sort data = ctyflowssorted 
            (rename=(w_cty = work_cty h_cty = home_cty jobs = w_h_jobflows)) ;
	by home_cty work_cty ; 
run ;

proc sort data = flows out=flows_sort ; 
	by home_cty work_cty ;
run ;

data ctypairs (keep= home_cty work_cty w_h_jobflows h_w_jobflows) ;
	merge ctyflowssorted flows_sort (rename =(jobs=h_w_jobflows)); 	
	by home_cty work_cty ; 
run ; 

data ctypairs (keep= home_cty work_cty w_h_jobflows h_w_jobflows reslf_h) ;
	merge ctypairs reslf (rename=(reslf=reslf_h)) ;
	by home_cty ; 
run ; 

proc sort data = ctypairs ;
 	by work_cty ;
run ; 

data ctypairs (keep=home_cty work_cty w_h_jobflows h_w_jobflows reslf_h reslf_w p_ij ) ;
	merge ctypairs reslf (rename=(home_cty=work_cty reslf=reslf_w)) ;
	by work_cty ; 
	if h_w_jobflows = . then h_w_jobflows = 0 ; 
	if w_h_jobflows = . then w_h_jobflows = 0 ; 
	
	denominator = min(reslf_h , reslf_w) ;
	p_ij = (h_w_jobflows + w_h_jobflows)/denominator ; 
	if p_ij > 1 then p_ij = 0.999 ;
	if work_cty = home_cty then p_ij = 1 ;
	
	if home_cty ne '' and work_cty ne '' ;
run ;    

/*When iterating, these all combine to take up a lot of memory */
proc datasets ; 
	delete  ctyflowssorted flows ;
run ;
    
/***********************
    Creating clustermatrix 
*************************/    

proc sql nowarn;
     create table ctyshell as
         select * 
         from 

            reslf (keep=home_cty) a,
              reslf  (keep=home_cty rename=(home_cty=work_cty)) b
         order by home_cty, work_cty ;	
 quit;

proc contents data = ctyshell ;
run;

data ctyshell ; 
	set ctyshell ; 
	if home_cty ne '' and  work_cty ne '' ; 
run;

proc sort data = ctyshell ; 
	by home_cty work_cty ; 
run; 

proc sort data = ctypairs ;
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

proc transpose data = cluster 
		out = clustermatrix 
		PREFIX = cty ; 
		
		by home_cty ;
		id work_cty ; 
		var d_ij ;
run;

data &outlib..&outfile. ; 
	format home_cty $10. ;
	set clustermatrix ;
	home_cty = "cty"||home_cty ; 
run;
    
%mend geoagg_spectral ;
