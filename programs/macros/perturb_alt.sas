%macro perturb_alt(dset,seed,inlib=OUTPUTS,outlib=OUTPUTS) ; 

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

data &outlib..flows_&dset._p&seed. (keep=work_cty home_cty jobsflow) flowsp  ;
	set &inlib..flows_&dset. ; 
	/*Drawing from N(0,1), scaling by sigma 
	Sigma is 
	*/ 
        if jobsflow ne 0 then do ;
            lowerbound_x = -1*&ci90.*moe ; 
            upperbound_x = &ci90.*moe ; 
            if jobsflow+lowerbound_x < 0 then do ; 
                lowerbound_x = -jobsflow ; 
                upperbound_x = jobsflow*2 ; 
            end;
            do until (lowerbound_x <= x <= upperbound_x ) ;    
                x =rannor(&seed .)*(moe/(&ci90.)); 
                put x work_cty home_cty jobsflow moe lowerbound_x upperbound_x ;             
            end;
            x =rannor(&seed.)*(moe/(1.64*2));
            flows_p = jobsflow+x;
            if flows_p < 0 then flows_p = 0 ; /* In case the MOE is way too large */
            output flowsp ;

	end; 	
	jobsflow = flows_p ;
	output &outlib..flows_&dset._p&seed. ;
	
run ; 
    
proc print data=&outlib..flows_&dset._p&seed. ;
    title 'post perturbation' ;
run;        

proc datasets ;
	delete flowsp ;
run ; 

%mend perturb_alt ;
