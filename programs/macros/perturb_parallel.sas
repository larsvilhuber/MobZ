%macro perturb_parallel(dset,outdset,seed,inlib=OUTPUTS,outlib=OUTPUTS) ; 

/******************************

Datasets in: 

OUTPUTS.flows_jtw2009 ; 

Datasets out:

OUTPUTS.flows_jtw2009p ;

******************************/


proc contents data = &inlib..flows_&dset. ;
run;

proc print data=&inlib..flows_&dset. (obs=20) ;
    title 'pre perturbation' ;
run;

data &outlib..&outdset. (keep=work_cty home_cty jobsflow)  ;
	set &inlib..flows_&dset. ; 
	/*Drawing from N(0,1), scaling by sigma 
	Sigma is 
	*/
	x =rannor(&seed.)*(moe/(1.64*2)); 
	
	flows_p = jobsflow+x;
	if flows_p < 0 then flows_p = 0 ; /* In case the MOE is way too large */
		
	jobsflow = flows_p ;
	output &outlib..&outdset. ;
	
run ; 
    /*
proc print data=&outlib..&outdset.;
    title 'post perturbation' ;
run;        
*/
%mend perturb_parallel ;
