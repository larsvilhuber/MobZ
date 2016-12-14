/*****************************
This macro requires 5 inputs:

1. dset = which dataset we are doing
2. minclus = what is the fewest clusters to test.
3. maxclus = most number of clusters to test
4. numseeds = how many times are we iterating over the seeds?
5. input library name (default outputs);
For double set, see: http://www.lexjansen.com/pnwsug/2009/Gehring,%20Renu%20-%20Multiple%20Set%20Statements%20in%20a%20Data%20Step.pdf
*****************************/



%macro
fastclus_loop(dset,minclus,maxclus,numseeds,inlib=OUTPUTS,noprint_obj=NO,map=NO,year=2012,
	perm=YES,fcvars=ctylat ctylon,dsuffix=fast,random=YES) ;

%if "&noprint_obj."="YES" %then %do ;
%put "ENTERING FASTCLUS " ;
%printjunk ;

%end; 

%prep_objfn(&year.,outlib=&inlib.) ;

/**************************************
CREATING NORMALIZATION
(and getting macros for input)
**************************************/
%if "&random." = "YES" %then %do ;

%randomcounties_norm(&year.,noprint=YES);

data _NULL_ ;
	set random_objfn ; 
	call symput('inflows',rand_inflows);
	call symput('outflows',rand_outflows);
	call symput('sdurate',rand_sdurate);
	call symput('sdearn',rand_sdearn); 
run; 

%end; 

/********************************
 Creating county CDF 
 *********************************/

proc summary data = OUTPUTS.reslf_lodes_2012 nway; 
	var reslf ;
	output out = denom(keep=totalpop) sum(reslf) = totalpop ; 
run; 
proc print data=denom;
    title "Counties Denom";
run;
data _NULL_ ;
	set denom ; 
	call symput('totalpop',totalpop);
run;

data counties_cdf(keep=home_cty cdf cdf_lag density /*mergekey1 mergekey2 index=(mergekey=(mergekey1 mergekey2))*/)  ;
	set OUTPUTS.reslf_lodes_2012 (where=(home_cty ne ''));
	*length mergekey1 mergekey2 $1;
	retain cdf ; 
	if _N_ =1 then cdf = 0; 
	cdf_lag = cdf ; 
	density=reslf/(&totalpop.);
	cdf = cdf + density; 
	*mergekey1=1;
	*mergekey2=2;
run;  	

proc print data=counties_cdf (obs=50);
    title "Counties CDF";
run;
proc means data=counties_cdf;
run;


data _NULL_ ;
	set stats ; 
	call symput('maxlat',maxlat);
	call symput('maxlon',maxlon);
	call symput('minlat',minlat);
	call symput('minlon',minlon);
run; 

data clustemp (keep= cty %unquote(&fcvars.)) ;	
	set &inlib..&dset.;
run; 	

proc contents data = clustemp ; 
run; 

%let bestobjfn = 10000; /*setting this very high so that it is replaced by first iteration*/
/************************************
	BEGINNING OF LOOP
*************************************/

%do ii=&minclus. %to &maxclus. ; /* Begin cluster number loop */


	/********************************/
	/* Alternate way to create seeds
	    using a double set		*/
	/********************************/
	%do jj = 1 %to &numseeds. ; 
		/* Creates the seeds for fastclus */
		%seeds_select(randomcounties,&ii.,&jj.,fcvars=&fcvars.); 
			
			
		/* Runs fastclus algorithm  */
		%fastclus(clustemp,seeds_use,&ii.,inlib=WORK,outlib=WORK,noprint=&noprint_obj.,fcvars=&fcvars.) ;
		proc contents data = clusters_clustemp ;
		run; 
		/* Calculates objective function */
		%objectivefunction(clusters_clustemp,&year.,inlib=WORK,outlib=WORK,noprint=&noprint_obj.) ;
		proc print data = objectivefn; 
		run; 
		/********************************
		This portion checks the most recent
		objective function value against the
		"best" of the previous runs
		********************************/
		data _NULL_ ;
			set objectivefn; 
			call symput('objfnvalue',objfn) ;
		run;
			
		%if %eval(&bestobjfn. > &objfnvalue.) %then %do ;
			%put "OBJECTIVE FUNCTION VALUE REPLACED: &bestobjfn. is greater than &objfnvalue." ;
			%let bestobjfn = &objfnvalue. ;
						
			data bestclusters ;
				set clusters_clustemp ;
				seed = &jj.;
				numclusters = &ii.;
			run;		
		%end; 
		/**********************************/
		
		/* adding counters */
		data outcome; 
			set objectivefn ; 
			clusnum = &ii. ;
			seednum = &jj ; 
		run; 
	
		%if &ii.=&minclus. and &jj.=1 %then %do ;
			data functionoutcome ;
				set outcome ;
			run; 
		%end ;
		%else %do ;
			data functionoutcome ;
				set functionoutcome outcome ;
			run; 
		%end ; 
	%end ; 
%end ; 

/*******************************
	END OF LOOP
*********************************/

proc sort data = functionoutcome ; 
	by objfn ;
run; 

proc print data = functionoutcome ; 
run ;

/* This should be our correct best outcome*/

data newob (keep=clusnum seednum rename = (seednum = seed_&numseeds.));
	set functionoutcome ; 
	by objfn ; 
	if _N_ = 1 then do ;
		call symput('clus',clusnum);
		call symput('seed',seednum);
		output newob; 
	end ; 
run;

/* Then here, I am going to map the "optimal" clusters 
I do this by re-running the procedure. */
%if "&perm." = "YES" %then %do ;
proc sort data = bestclusters out=OUTPUTS.bestclusters_&dsuffix. (rename = (cty = county) ;
	by cty ;
run; 	
%end;  
%else %do ; 
proc sort data = bestclusters out = bestclusters_&dsuffix. ;
	by cty ;
run; 
%end;  
/* Runs fastclus algorithm  */

%if "&map." = "YES" %then %do ; 

	/*%fastclus(&dset.,seeds,&clus.,inlib=&inlib.,outlib=WORK) ;*/

	*%fastclusmap(bestclusters_&dset.,inlib=&inlib.);
%end; 

/* 
proc sort data = clusters_&dset. (keep= cluster fipsstco rename=(fipsstco=cty)) ;
	by cty ; 
run; 


data clustercomp cluster_unmatched; 
	merge bestclusters_&dset. (keep= cluster cty rename = (cluster= optimal_cluster)) clusters_&dset. ;
	by cty ;
	if cluster ne optimal_cluster then output cluster_unmatched;
	output clustercomp ;
run; 

proc print data = clustercomp; 
	var cty optimal_cluster cluster ;
run; 

*/

%if "&noprint_obj."="YES" %then %do ;

%printlog ;
%put "LEAVING FASTCLUS" ;
%end; 

%mend fastclus_loop ;

