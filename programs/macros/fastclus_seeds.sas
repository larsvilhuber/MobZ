%macro fastclus_seeds(dset,minclus,maxclus,numseeds,indir=OUTPUTS,outdir=OUTPUTS) ;


/**************************************
This macro is built in 2 main parts
1. Get all objective function values 
for range of cluster nums and seeds

2. Loop over this dataset from #1 to 
compare it 
***************************************/
%fastclus_prep ;
%fastclus_loop(&dset.,&minclus.,&maxclus.,&numseeds.,inlib=OUTPUTS,noprint_obj=NO,map=NO) ;

/******************
OUTPUT DATASET: 
functionoutcome
*******************/

%do ss = 1 %to &numseeds ; 
%put "************************** INSIDE LOOP FOR &ss. number of seeds *********************" ;
	%let lastseed = %eval(&ss.-1) ;	

	data seedfn;
		set functionoutcome (where=(seednum<=&ss.)); 
	run; 
	
	proc sort data = seedfn ;
		by clusnum objfn ;
	run ;
	
	data cluster&ss. (rename = (seednum = seed&ss.);
		set seedfn ;
		by clusnum ;
		
		if first.clusnum then output ; 
	run; 
/*	
	proc print data = cluster&ss. ;
	run; 
*/
%end; 

/*********************************
NOW, I CALCULATE SWITCH RATES ALL IN
ONE DATA STEP
**********************************/
%let numclus = %eval(&maxclus.-&minclus.+1) ;
data switch_rate (keep = seed switch_rate);
	merge cluster1-cluster&numseeds. ;
	by clusnum ;
	
	array sds{&numseeds.} seeds1-seeds&numseeds.; 
	array switch{&numseeds.} _temporary_ ;
	array total_switch{&numseeds.} _temporary_ ;
	retain total_switch{*}; 
	
	do i = 2 to &numseeds; 
		switch{i} = (seeds{i} ne sds{i}) ;
		total_switch{i} = total_switch{i} + switch{i} ;
	end; 
	
	if clusnum = &maxclus. then do;
		do i = 2 to &numseeds ;
			switch_rate = total_switch{i}/&numclus. ;
			seed = i;
			output switch_rate ;
		end ;
	end;  
run; 

proc print data = switch_rate ; 
run; 	

%macro skip ; /************* OLD CODE *******************/

	%if %eval(&ss.>1) %then %do ;
		/**************************
		 COMPARE CURRENT CLUSTERS
		 WITH CLUSTERS W/ ONE LESS
		 SEED 
		 **************************/
		data merged ;
			merge cluster&ss. cluster&lastseed. ;
			by clusnum ; 
			if seed_&ss. ne seed_&lastseed. then switch = 1 ; /*if optimal seed has changed*/
			else switch = 0 ; 
		run; 

		proc summary data = merged ; 
			var switch;
			output out = calc  mean(switch) = switch_rate ; 
		run; 
		
		data calc (keep = seed switch_rate); 
			set calc; 
			seed = &ss. ;
		run; 
		
		proc append base = switch_rate 
			data = calc ; 
		run; 
		%macro skip;
		%if %eval("&ss."="2") %then %do ;
			data switch_rate ;
				set calc ; 
			run; 
		%end; 
		%else %do; 
	
			data switch_rate ; 
				set switch_rate calc ;
			run ;
		%end; 
		%mend skip; 
	%end; 
%put "************************** END OF LOOP FOR &ss. number of seeds *********************" ;
%end ; 

%mend skip ;

%mend fastclus_seeds ;
