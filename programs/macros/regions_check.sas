%macro regions_check(dset) ; 
proc contents data = OUTPUTS.allcounties_&dset. ;
run ; 


data singlecluster (keep=home_cty clus1-clus6 height1-height6)
	multipleclusters (keep=home_cty clus1-clus6 height1-height6);
	/* ******* RENAMING CLUSTER VARIABLES FOR EASE OF LOOPING ******* */
	set OUTPUTS.allcounties_&dset. 
		(rename = (cluswest = clus1 clussouthwest = clus2 clusmidwest = clus3 cluscentral= clus4
			clusnortheast=clus5 clussoutheast = clus6
			heightwest=height1 heightsouthwest = height2 heightmidwest = height3
			heightcentral = height4 heightnortheast = height5 heightsoutheast = height6)) ;
	
	
	cluster = clus1||" "||clus2||" "||clus3||" "||clus4||" "||clus5||" "||clus6 ;
	if countw(cluster)>1 then output multipleclusters ;
	else output singlecluster ; 
run ;


%do ii = 1 %to 6 ; 
	
	proc sort data = multipleclusters out = clusters&ii. (keep = clus&ii. height&ii.) nodupkey ; 
		by clus&ii. ;
	run; 
	
	data clusters&ii. ;
		set clusters&ii. (where=(clus&ii. ne '')) ;
	run ;
	
	proc print data = clusters&ii. ;
		title "Clusters list" ;
	run ; 
	
	data _NULL_ ;
		set clusters&ii. nobs = n ; 
		call symput('nrows',n);
		stop;
	run ; 
	
	%do jj = 1 %to &nrows ; 
	
		data clusstep (keep=clus&ii.);
			set clusters&ii. ;
			if _n_ = &jj. ;
		run ; 	
		/*
		proc print data = clusstep ; 
		title "RELEVANT CLUSTER &ii." ;
		run ;
		*/
		proc sort data = multipleclusters ;
			by clus&ii. ;
		run ; 
	
		data relevantcounties ;
			merge multipleclusters clusstep (in=b) ;
			by clus&ii. ;
			if b ; 
		run ; 
		
		proc print data = relevantcounties ; 
			title "MATCHED COUNTIES" ;
		run ; 

		%if &jj. = 1 %then %do ; 
			proc print data = clusstep ; 
				title "RELEVANT CLUSTER &ii." ;
			run ; 
		
			proc print data = relevantcounties ; 
				title "RELEVANT COUNTIES " ;
			run ; 
		%end; 
		
		%let conflict = 0 ; 
		%do kk = 1 %to 6; 	 
			
			proc freq data = relevantcounties ; 
				tables clus&kk. /out = count ;
			run ; 
			
			data _NULL_ ;
				set count nobs = n ; 
				call symput('nrows2',n);
				stop;
			run ;
			%if %eval(&nrows2.)>1 %then %let conflict = 1 ;
		%end ; 	
		
		/* The indicator turns on if the clusters don't perfectly overlap.*/
		
		%if %eval(&conflict.) = 1 %then %do ; 
			proc append data = relevantcounties base = conflict ; 
			run ; 
		%end ; 
		%else %do ; 
			proc append data = relevantcounties base = nonconflict ; 
		%end;
	%end; 	
%end; 

proc sort data = conflict nodupkey ;
	by home_cty ; 
run ; 
	
proc sort data = nonconflict nodupkey ;
	by home_cty ; 
run ;
 
proc sort data = multipleclusters ; 
	by home_cty ; 
run ; 

data OUTPUTS.conflict_&dset. ;
	merge multipleclusters conflict (in=b) ;
	by home_cty ; 
	if b; 
run ; 

data OUTPUTS.conflict_&dset. ;
	merge OUTPUTS.conflict_&dset. (in=a) OUTPUTS.cz1990 (rename = (cty = home_cty)) ;
	by home_cty ; 
	if a ; 
run ; 

proc sort data = OUTPUTS.conflict_&dset. out = consort;  
	by clus1 clus2 clus3 clus4 clus5 clus6 ; 
run ; 

/*QA CODE*/
proc freq data = OUTPUTS.conflict_&dset. ;
	tables clus1 clus2 clus3 clus4 clus5 clus6 ;
run ;

proc print data = consort ; 
run ; 


data consort (keep =home_cty cluster) ; 
	set consort nonconflict singlecluster;
	cluster1= clus1 ;  
	cluster2 = cluster1||"_2"|| trim(clus2);
	cluster3 = cluster2||"_3"|| trim(clus3);
	cluster4 = cluster3||"_4"|| trim(clus4);
	cluster5 = cluster4||"_5"|| trim(clus5);
	cluster  = cluster5||"_6"|| trim(clus6);
run ; 

proc sort data = consort nodupkey ; 
	by home_cty ; 	
run ;

proc freq data = consort  nlevels ; 
	tables cluster ;
run ; 

proc print data = consort ; 
run ; 

proc sort data = consort out = nationalclusters nodupkey ;
	by cluster; 
run ; 	

data nationalclusters (keep=cluster clusnum);
	retain clusnum ;
	set nationalclusters ;
	by cluster ; 
	if _n_ = 1 then clusnum = 0 ; 
	clusnum = clusnum + 1 ; 
run; 

proc print data = nationalclusters;  
run;  

proc sort data = consort ; 
	by cluster ; 
run ; 

data OUTPUTS.regionalclusters_&dset. (keep=home_cty clusnum) ;
	merge consort (in=a) nationalclusters (in=b) ;
	by cluster ; 
run ; 

proc freq data = OUTPUTS.regionalclusters_&dset.  nlevels ; 
	tables clusnum ;
run ; 

/******************** MAPPING THE RESULTING COMMUTING ZONES ***********************/
data clusmap (keep = state county clusnum )  ;
	set OUTPUTS.regionalclusters_&dset. ;
	format state county cluster BEST32. ;
	state = substr(home_cty,1,2) ;
	county = substr(home_cty,3,3) ;
	if state not in (2,15,72) ;
run ; 	

proc sort data = clusmap ;
	by state county ; 
run ; 

proc sort data = maps.counties out=counties ; 
	by state county ; 			
run ;  

proc gproject data = maps.counties(where=(state not in (2, 15,72))) out=counties_proj
	parallel1 = 35 parallel2 = 50 project = albers ;
	id state county;  
run ; 


proc gmap map = counties_proj data = clusmap ;
	title "Mobility zones for ALL";
	id state county ;
	choro clusnum	/ discrete nolegend ;
run ; 	



/******************************* Tolbert and Sizer's ***********************/
data cz1990 (keep=state county cz);
	format state county BEST32. ;
	
	set OUTPUTS.cz1990 ; 
	state = substr(cty,1,2) ;
	county = substr(cty,3,3) ;
	cz = input(cz1990,5.0);	
	if state not in ('02','15','72') ;
run ;

proc gmap map = counties_proj data = cz1990 ;
	title "Commuting Zones from Tolbert and Sizer";
	id state county ;
	choro cz	/ discrete nolegend;
run ; 


%mend regions_check ; 
