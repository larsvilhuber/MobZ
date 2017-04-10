%macro randomcounties_norm(year,noprint=NO) ;

%if "&noprint."="YES" %then %do ;
%put "ENTERING OBJECTIVEFUNCTION.SAS" ;
%printjunk ;

%end; 

proc sort data=OUTPUTS.reslf_jtw1990 out=counties_rand (keep=home_cty) nodupkey ; 
	by home_cty ; 
run; 


%do ii = 1 %to 50 ; 

data counties_random (rename=(home_cty=county)); 
	set counties_rand ; 
	randomnumber=ranuni(_N_*&ii.) ;
run; 

proc sort data = counties_random;
	by randomnumber ;
run; 

data clusters_random (keep=county cluster); 
	set counties_random ;
	cluster = ceil(_N_/5) ;
run; 


*%objectivefunction_norm(clusters_random,&year.,inlib=WORK,outlib=WORK,otherlib=OUTPUTS,noprint=&noprint.); 

%objectivefunction_norm1(clusters_random,&year.,inlib=WORK,outlib=WORK,otherlib=WORK,noprint=NO) ;
		
	%if %eval(&ii.>1) %then %do ; 
		data random_objfn ;
			set random_objfn objectivefn; 
		run; 
	%end; 
	%else %do;
		data random_objfn;
			set objectivefn;
		run;
	%end; 
%end; 	

proc means data=random_objfn; 
run; 

proc summary data=random_objfn nway; 
	var share_inflows share_outflows meancorr_urate meancorr_earnings;
	output out = OUTPUTS.random_objfn 
		mean(share_inflows share_outflows meancorr_urate meancorr_earnings)=
			rand_inflows rand_outflows rand_corrurate rand_correarn ;
run; 

%if "&noprint_obj."="YES" %then %do ;

%printlog ;
%put "LEAVING FASTCLUS" ;
%end; 


%mend randomcounties_norm ;

