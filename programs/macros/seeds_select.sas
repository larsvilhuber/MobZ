

/*******************************

This macro creates the seeds for
fastclus, and includes all ways
that we can select the seeds:

1. withoutreplacement
2. withreplacement
3. randompoints
4. randomcounties


Other options: 

	seeds (how many to produce)
	iteration (to produce the random seed

********************************/
%macro seeds_select(type,seeds,iteration,fcvars = ctylat ctylon) ;

%if "&type." = "withoutreplacement" %then %do ; 
	
	* sample without replacement (cannot use keep);
	data counties_cdf;
		set counties_cdf (keep=home_cty density);
	run;
	* some methods require that size<1/sampsize for all units, but not brewer;
	proc surveyselect data=counties_cdf
		method=srs
		sampsize=&ii.
		/*seed=1234567*/
		reps=1
		out=seeds_cdf;
		size density;
	run;
	
	proc sort data=seeds_cdf out=seeds_use;
		by fipsstco;
	run;
	data seeds_use (keep = cluster %unquote(&fcvars))
	    seeds_use_check ;
		merge  seeds_use (in=a keep=cluster fipsstco) fc_datainput;
		by fipsstco ;
		if a ; 
	run; 
%end; 

/******************************************/
%if "&type." = "withreplacement" %then %do ; 
	data seeds_shell (keep=cluster seed x /*mergekey1 mergekey2*/);
	*length mergekey1 mergekey2 $1;
		do ctr = 1 to &seeds. ; 
			cluster = ctr ;
			*mergekey1=1;
			*mergekey2=2;
			* numseeds will serve as the initial value of the seed;
			retain seed &iteration. ; 
			call ranuni(seed,x);
			output;
		end ; 
	run;
	
	data seeds_cdf (keep = home_cty cluster x cdf_lag cdf rename=(home_cty = fipsstco));
		set seeds_shell ;
		do i=1 to num;
			set counties_cdf nobs=num point=i;
			if cdf_lag < x <= cdf then output;
		end;
	run;
	
	data seeds_cdf (keep = home_cty cluster rename=(home_cty = fipsstco)) 
	    seeds_cdf_miss (keep = home_cty cluster x)
	     seeds_cdf_merge;
		set seeds_shell ; 
		length tmp $5 ; 
		cont1 = 0 ;
		cont2 = 0 ;
		valid_record_found = 0 ; 
		* numseeds will serve as the initial value of the seed;
		retain seed &iteration. ; 
		call ranuni(seed,x);
		tmp = home_cty ; 
		do while(cont1=0); 
			set counties_cdf key=mergekey;
			if cont2=1 then do ;
				cont1=1;
				home_cty = tmp ; 
			end ; 
			if _iorc_ = 0 then do ; 
				* check;
				*output seeds_cdf_merge;
				if cdf_lag < x <= cdf then do ;
					valid_record_found = 1 ; 
					output seeds_cdf; 
					home_cty = '' ;
				end ; 
			end ; 
			else do ;
				_error_ = 0 ;
				cont2=1 ; 
			end;
		end ;
		if valid_record_found = 0 then output seeds_cdf_miss;
	run ;
	
	proc sort data=seeds_cdf out=seeds_use;
			by fipsstco;
	run;
	
	data seeds_use (keep = cluster %unquote(&fcvars))
		seeds_use_check ;
		merge  seeds_use (in=a keep=cluster fipsstco) fc_datainput;
		by fipsstco ;
		if a ; 
	run; 
%end ; 

/***************************************/
%if "&type" = "randompoints" %then %do ;

	/*create seeds for data */
	data seeds_use (keep=cluster %unquote(&fcvars.));
		seed = &iteration.; 
		do ctr = 1 to &seeds. ; 		
			latseed = ranuni(seed);
			lonseed = ranuni(seed);
			useed = ranuni(seed);
			ctylat = &minlat. + (latseed*(&maxlat.-&minlat.)) ;
			ctylon = &minlon. + (lonseed*(&maxlon.-&minlon.)) ;
			urate = &minurate. + (useed*(&maxurate.-&minurate.)) ;
			cluster = ctr ;
			output ;
			seed = ranuni(seed) ;	
		end ; 	
	run ; 
%end; 

/**************************************************/

%if "&type." = "randomcounties" %then %do ; 
	data ctyseeds;
		set fc_datainput ;
		retain seed &iteration. ;
		rank = ranuni(seed) ;
		seed = ranuni(seed) ;
	run; 
	
	proc sort data=ctyseeds ;
		by rank ;
	run; 
	
	data seeds_use (keep=cluster %unquote(&fcvars.));
		set ctyseeds; 
		if _N_<=&seeds then do ;
			cluster = _N_ ;
			output;
		end ;
	run; 
	
%end ;

%mend seeds_select ; 
