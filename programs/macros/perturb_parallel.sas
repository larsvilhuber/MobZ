%macro perturb_parallel(dset,outdset,seed,inlib=OUTPUTS,outlib=OUTPUTS) ; 

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
        if jobflows ne 0 then do ;
        lowerbound_x = -1*1.645*moe ; 
        upperbound_x = 1.645*moe ; 
        end;
        if jobsflow-lowerbound_x < 0 then do ; 
            lowerbound_x = -jobsflow ; 
            upperbound_x = jobsflow*2 ; 
        end;
            /* for people not bounded by 0 - keep it normal */
        else do; 
            lowerbound_x = -1000000 ;
            upperbound_x = 1000000 ; 
        end;
        do until (lowerbound_x <= x <= upperbound_x) ;    
            x =rannor(&seed.)*(moe/(1.645)); 
        end;
	
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
%mend perturb_parallel ;
