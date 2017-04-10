/* =================== 
There are two macros 
that need to be input: 
the dataset and the comparison
year
======================*/

%macro compare_cz(dset,year) ; 

data clusters (rename = ( _PARENT_ = cluster)) ;
	length cty $5 ; 
	set OUTPUTS.clusfin_&dset. ;
	cty = substr(_NAME_,4,5) ; 
	drop _NAME_ ;
run ; 

proc sort data = clusters ;
	by cty ;
run ; 

proc contents data = OUTPUTS.cz&year. ;
run ; 

proc contents data = clusters ;
run ;	

data cluster_cz ; 
	merge clusters (in=a) OUTPUTS.cz&year. (in=b) ;
	by cty ; 
	if a and b ; 
	count = _N_ ;
run ; 

proc print data = cluster_cz (obs = 20) ;
run ; 

%do ii = 1 %to 3141 ; 

	data _NULL_ ;	
		set cluster_cz (where=(count = &ii.));
		call symput('cluster', cluster) ;
		call symput('cz', cz&year.) ;
	run ; 
	%put "CLUSTER &cluster. and COMMUTING ZONE &cz. ";
	data clus (keep = cty cluster) 
		comzone (keep = cty cz&year. );	
		set cluster_cz (where=(cluster="&cluster." or cz&year.="&cz.")) ;
		if cluster="&cluster." then output clus ;
		if cz&year. = "&cz." then output comzone ; 
	run ; 
	
	proc sort data = clus ; 
		by cty ;
	run ; 
	
	proc sort data = comzone ; 
		by cty ; 
	run ;
	
	data matched (keep = cty cluster cz&year. ) 
		mismatched (keep=cty cluster cz&year.) ;
		
		merge clus (in=a) comzone (in=b) ;
		by cty ;
		
		if a and b then output matched ;
		if (a and not b) or (not a and b) then output mismatched ; 	
	run ;
	
	%if %eval(&ii.) =  1 %then %do ;
		data master_matched ;			
			set matched ; 
		run  ;
		
		data master_mismatched ; 
			set mismatched ; 
		run ;
	%end ; 
	%else %do ;
		proc append base = master_matched data = matched ;
		run ; 
		
		proc append base = master_mismatched data = mismatched ;
		run ; 
	%end ; 		
%end ; /* End of observation loop*/


/* The above process is going to create a LOT of duplicates -	 this fixes it */

proc sort data = master_matched nodupkey ; 
	by cty cluster cz&year. ; 
run  ;

proc sort data = master_mismatched nodupkey ;
	by cty cluster cz&year.; 
run ;

data master_mismatched ;
	merge master_mismatched (in = a) cluster_cz (rename = (cluster = clusterREAL cz1990 = cz1990REAL));
	by cty ;
run ;

proc print data = master_matched ; 
	title "Counties in clusters that were matching 1990" ;
run ; 

proc print data = master_mismatched ;
	title "Counties in clusters NOT matching TS 1996" ;
run ; 


%mend compare_cz ; 

