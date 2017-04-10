%macro perturb(dset,seed,inlib=OUTPUTS,outlib=OUTPUTS) ; 

/******************************

Datasets in: 

OUTPUTS.flows_jtw2009 ; 

Datasets out:

OUTPUTS.flows_jtw2009p ;

******************************/


proc contents data = &inlib..flows_jtw2009  ;
run ;

data &outlib..flows_jtw2009_p&seed. (drop=x y z flows_p) flowsp  ;
	set &inlib..flows_jtw2009 ; 
	
	x =ranuni(&seed.);
	y =ranuni(&seed.);
	if y > 0.5 then z = -1 ;
	else z = 1 ; 
	
	flows_p = jobsflow+(moe*x*z);
	if flows_p < 0 then flows_p = 0 ; /* In case the MOE is way too large */
	output flowsp ;
		
	jobsflow = flows_p ;
	output &outlib..flows_jtw2009_p&seed. ;
	
run ; 
/*
proc means data = flowsp mean std p5 p25 p50 p75 p95 ; 
	vars flows_p jobsflow ; 	
run; 

proc print data = flowsp (obs = 40) ; 
run; 
*/

proc datasets ;
	delete flowsp ;
run ; 

%mend perturb ;
