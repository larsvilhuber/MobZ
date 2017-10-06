%macro perturb_parallel_old(dset,outdset,seed,inlib=OUTPUTS,outlib=OUTPUTS) ; 

/*
proc contents data = &inlib..flows_&dset. ;
run;

proc print data=&inlib..flows_&dset. (obs=20) ;
    title 'pre perturbation' ;
run;
*/
data &outlib..&outdset. (keep=work_cty home_cty jobsflow)  ;
	set &inlib..flows_&dset. ; 
	/*Drawing from N(0,1), scaling by sigma 
	Sigma is 
	*/
        /* seed is the iteration number - and only the first seed matters, 
        rest are ignored.*/
          
            x =rannor(&seed.)*(moe/(&ci90.)); 
	
	flows_p = jobsflow+x;
	if flows_p < 0 then flows_p = 0 ; /* In case the MOE is way too large */
		
    	jobsflow = flows_p ;
        
	output &outlib..&outdset. ;	
run; 
    /*
proc print data=&outlib..&outdset.;
    title 'post perturbation' ;
run;        
*/
%mend perturb_parallel_old ;
