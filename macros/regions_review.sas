%macro regions_review(dset,cutoff); 

%do ii = 1 %to 6 ;

	%if %eval(&ii. = 1) %then %let region = west ; 
	%else %if %eval(&ii. = 2) %then %let region = southwest ;
	%else %if %eval(&ii. = 3) %then %let region = central ;
	%else %if %eval(&ii. = 4) %then %let region = midwest ;
	%else %if %eval(&ii. = 5) %then %let region = northeast ;
	%else %if %eval(&ii. = 6) %then %let region = southeast ;


	proc sort data = OUTPUTS.clustertree_&region. out=clustertree; 
	by _HEIGHT_ ;
	run ;
	data ctydata (keep = _NAME_ _PARENT_ /*_PARENTOLD_*/)
		clusterdata (keep = _PARENT_ _GRANDPA_ _HEIGHT_	)	
		cutclusters (keep = _GRANDPA_ _GRANDPAPPY_)
		clusterheight (keep=_NAME_ _HEIGHT_ rename=(_NAME_=_PARENT_));

		length default = 4 ; 
		set clustertree	;
		
		height = _HEIGHT_;
		_HEIGHT_ = height ;
		
		if substr(_NAME_,1,2) ne "CL" then do ;
			*_PARENTOLD_=_PARENT_ ; /*Holding for when merge goes above cutoff*/
			output ctydata ; /*Bottom of tree */
		end; 
		else do ;
			if (_HEIGHT_ > &cutoff.) then do ; 
				
				_GRANDPA_ = _NAME_ ;
				_GRANDPAPPY_ = '' ;	
				output cutclusters ; /* Outputting ineligible clusters */
			end ; 	
			else do ; 
				_GRANDPA_=_PARENT_;
				_PARENT_=_NAME_ ;
				output clusterdata ; /* Outputting clusters */
			end ; 
		end ;
		
		if (_HEIGHT_ <= &cutoff.) then output clusterheight ;
	run ;
	
	%let pointbreak = 0 ; 
	%let circuitbreaker=  0 ;
	%let mein = 0 ; 

	/* ==================
	Initializing the 
	nrows macros, in 
	order to make sure 
	the loop doesn't run
	forever.
	===================*/
	%let nrows = 0 ;
	%let nrows_lag = 1 ; 
	%let nrows_lag2 = 2 ; 
	
	proc sort data = clusterdata ; 
			by _PARENT_ ;
	run ; 

	%do %while (&pointbreak.=0 and &circuitbreaker. < 100 ) ; 
		%let circuitbreaker = %eval(&circuitbreaker. + 1) ;
		%put "Start of Geneology loop while mein=&mein., pointbreak=&pointbreak., and cirguitbreaker=&circuitbreaker.";
	
		proc sort data = ctydata ; 
			by _PARENT_ ;
		run ; 	
	
		data ctydata (keep = _NAME_ _PARENT_   /*_PARENTOLD_*/)
			ctydata_finished (keep= _NAME_ _PARENT_) ;

			merge ctydata (in=incty) clusterdata (in=inclus) ;
			by _PARENT_ ; 
				if incty then do ;
					if _GRANDPA_ ne '' then do ; 
						*_PARENTOLD_=_PARENT_ ;
						_PARENT_ = _GRANDPA_ ;
						output ctydata ;
					end;
					else do ;
						*_PARENT_ = _PARENTOLD_ ;
						output ctydata_finished ; 
					end;  
				end; 
		run ;
	
		proc append base=clustersfinished&region. data=ctydata_finished;
		run;
	
		/*Deciding whether to stay in loop*/
		proc sql noprint ;
			select count(*)	 into :nrows from ctydata; 
		quit ; 	
		%put "&nrows. in &region." ;

		%if %eval(&nrows.) = 0 %then %do ;
			/* If there are no observations in the CTYDATA, we are done */
			/* Also if the same number of rows are stuck a number of times, we are done */	
			%let pointbreak = 1 ; 
			%put "POINT BREAK" ; 
		%end ; 
	
		/* If getting kicked out of loop because a few rows are singletons, need to append them */
	
		%if (%eval(&nrows.) =  %eval(&nrows_lag.) and  %eval(&nrows_lag2.) =  %eval(&nrows_lag.)) %then %do ;
		
			data ctydata (keep = _NAME_ _PARENT_);
				set ctydata ;
			run ;
			 
			proc append base = clustersfinished&region. data = ctydata ; 
			run ; 
			%let pointbreak = 1 ; 
		%end;


		%let nrows_lag2 = &nrows_lag. ;
		%let nrows_lag = &nrows. ; 
		%put "=================================================================================" ;
		%put "END of Geneology loop while mein=&mein., pointbreak=&pointbreak., and circuitbreaker=&circuitbreaker.";
		%put "=================================================================================" ;		
	
	%end ; 	
	
	proc sort data = clustersfinished&region. ;
		by _PARENT_ ;
	run ; 
	proc sort data = clusterheight ;
		by _PARENT_ ;
	run ; 
	data clustersfinished&region. (keep = _NAME_ _PARENT_ _HEIGHT_ _CLUSTEROLD_) ;
		length _PARENT_ $15. ;
		merge clustersfinished&region. (in=a) clusterheight (in=b) ;
		by _PARENT_ ;
		if a ;
		if _HEIGHT_ = . then do ;
			_CLUSTEROLD_ = _PARENT_ ;
			_PARENT_ ="CL10"||substr(_NAME_,4,5); 
			_HEIGHT_ = 0 ; 
		end; 
	run ;	
	
	proc sort data = clustersfinished&region. 
			out= clusfinished_&region. (rename =(_NAME_ = cty _PARENT_ =clus&region. _HEIGHT_=height&region.))	;
		by _NAME_ ;
	run ; 
	
	data clusfinished_&region. (keep=home_cty clus&region. height&region. _CLUSTEROLD_)	;
		length home_cty $5. ;
		set clusfinished_&region.;	
		home_cty = substr(cty,4,5) ;
	run ;
	
	proc sort data =clusfinished_&region. nodupkey ;
		by home_cty clus&region. ;
	run ;
	/* 
	%if %eval(&ii.=1) %then %do ;
	proc print data = clusfinished_&region. ;
	run ; 
	%end;
*/
	proc datasets  ;
		delete clustersfinished&region. ;
	run ;

%end ; /*ending regions loop*/



/* ============ MERGING THEM ALL UP ============= */
proc sort data=OUTPUTS.cluster out = allcounties (keep = home_cty) nodupkey ;
	by home_cty ; 		
run ;

data allcounties ;
	merge allcounties (in=a) clusfinished_west ;
	by home_cty ; 
	if a ; 
run ; 

data allcounties ;
	merge allcounties (in=a) clusfinished_southwest ;
	by home_cty ; 
	if a ; 
run ; 

data allcounties ;
	merge allcounties (in=a) clusfinished_midwest ;
	by home_cty ; 
	if a ; 
run ; 

data allcounties ;
	merge allcounties (in=a) clusfinished_central ;
	by home_cty ; 
	if a ; 
run ; 

data allcounties ;
	merge allcounties (in=a) clusfinished_northeast ;
	by home_cty ; 
	if a ; 
run ; 

data allcounties ;
	merge allcounties (in=a) clusfinished_southeast ;
	by home_cty ; 
	if a ; 
run ; 

data OUTPUTS.allcounties_&dset. ;
	set allcounties ; 
	state = substr(home_cty,1,2) ;
run ;
/*
proc print data = allcounties ; 
run ;  

proc datasets ; 
	delete clusfinished_west clusfinished_southwest clusfinished_midwest
	clusfinished_central clusfinished_northeast clusfinished_southeast ;
run; 
*/

*%macro skip ;
/* Here, I am going to separate those who only have one cluster assigned vs. conflicting clusters */	


data singlecluster (keep = home_cty cluster) 
	multipleclusters (keep = home_cty cluster); 
	
	
	length cluswest clussouthwest clusmidwest cluscentral clusnortheast clussoutheast $10. ;
	set OUTPUTS.allcounties_&dset. ; 
	
	/* Concatenating an identifier on front */
	if missing(cluswest) = 0  then cluswest = "W_"||cluswest; 
	if missing(clussouthwest) = 0 then clussouthwest = "SW_"||clussouthwest ;
	if missing(clusmidwest) = 0 then clusmidwest = "MW_"||clusmidwest ; 
	if missing(cluscentral) = 0 then cluscentral = "C_"||cluscentral ; 
	if missing(clusnortheast)=0 then clusnortheast = "NE_"||clusnortheast ; 
	if missing(clussoutheast) = 0 then clussoutheast = "SE_"||clussoutheast ; 
	
	cluster = cluswest||" "||clussouthwest||" "||clusmidwest||" "||cluscentral||" "||clusnortheast||" "||clussoutheast ;
	if countw(cluster)>1 then output multipleclusters ;
	else output singlecluster ; 	
run; 	

proc print data = singlecluster ; 
run ; 

proc print data = multipleclusters ; 
run ; 	

proc append base = singlecluster data = multipleclusters ; 
run ; 	

proc sort data = singlecluster out = OUTPUTS.regionalcluster_&dset. ;
	by home_cty ; 
run ;	

proc contents data = OUTPUTS.allcounties_&dset. ;
run ;



/************************ EXTRA STEP *************************/
/***************** MAPPING ********************/

proc freq data = clusfinished_west ; 
	table _NAME_; 
run ; 

proc contents data = clusfinished_west ;
run ;

data clusters (keep = state county cluster )  ;
	set clusfinished_west ;
	format state county cluster BEST32. ;
	state = substr(home_cty,1,2) ;
	county = substr(home_cty,3,3) ;
	cluster = substr(cluswest,3,8) ;
run ; 		

proc sort data = clusters ; 
	by state county ; 
run ;

proc sort data = maps.counties out=counties ; 
	by state county ; 			
run ;  

/* =========== MAPPING CODE HERE =============*/

proc gproject data = maps.counties(where=(state  in (6,4,49,32,16,41,53))) out=OUTPUTS.counties_proj_&dset.
	parallel1 = 35 parallel2 = 50 project = albers ;
	id state county;  
run ; 

proc contents data = clusters ; 
run ; 

proc freq data = clusters ; 
	table state ; 
run ;

data clusters ; 
	set clusters (where=(state  in (6,4,49,32,16,41,53)));
run ; 

%let mappath = "./maps" ;

goptions reset= all device=png gsfname = gout xpixels=1600 ypixels=800;
filename gout "&mappath./clustermap_west.png" ;

proc gmap map = OUTPUTS.counties_proj_&dset. data = clusters ;
	title "Mobility zones from &dset. West		";
	id state county ;
	choro cluster	/ discrete nolegend ;
run ; 	
*%mend skip ;
	




%mend regions_review ;

	
