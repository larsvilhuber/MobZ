**************************
/*
This macro calculates two divergence measures:
- avg share of ctys in cluster that are in CZ
- avg share of ctys in CZ that are in cluster
*/
**************************;

%macro divergence(dset,czyear,noprint=NO) ; 

%if "&noprint."="YES" %then %do ;
%put "ENTERING DIVERGENCE with dset &dset and czyear &czyear. " ;
%printjunk ;

%end;

data clusters (rename = ( _PARENT_ = cluster)) ;
	length cty $5 ; 
	set OUTPUTS.clusfin_&dset. ;
	cty = substr(_NAME_,4,5) ; 
	drop _NAME_ ;
run ; 

proc sort data = clusters ;
	by cty ;
run ; 

proc contents data = OUTPUTS.cz&czyear. ;
run ; 

proc contents data = clusters ;
run ;	

data cluster_cz ; 
	merge clusters (in=a) OUTPUTS.cz&czyear. (in=b) ;
	by cty ; 
	if a and b ; 
	count = _N_ ;
run ; 
/*
proc print data = cluster_cz (obs = 20) ;
run ; 
*/
proc sort data = cluster_cz ; 
	by cty ;
run ;

%do ii = 1 %to 3141 ; 
	data _NULL_ ;	
		set cluster_cz (where=(count = &ii.));
		call symput('cluster', cluster) ;
		call symput('cz', cz&czyear.) ;
		call symput('cty',cty);
	run ; 
	
	%put "*****************************************" ;
	%put "CLUSTER &cluster. and COMMUTING ZONE &cz." ;
	%put "*****************************************" ;
	data czclus (keep=cty mean_czmatch mean_clustermatch); 
		set cluster_cz 
                        (where = (cluster=trim(left("&cluster.")) or cz&czyear. = trim(left("&cz.")))) 
                        end = eof;
		retain czcount clustercount czmatch clustermatch ;
		if _N_ = 1 then do ; /*Setting them to -1 so that counties don't count themselves in mean*/
			czcount = -1;
			clustercount = -1 ;
			czmatch = -1;
			clustermatch = -1;
		end; 
		
		if cz&czyear. = trim(left("&cz.")) then do ;
			czcount = czcount + 1 ; 
			if cluster=trim(left("&cluster.")) then do;
				czmatch = czmatch+1 ; 
			end;
		end;
		if cluster = trim(left("&cluster.")) then do ;
			clustercount = clustercount + 1 ;
			if cz&czyear. = trim(left("&cz.")) then do ;
				clustermatch = clustermatch+1 ; 
			end; 
		end; 
		/* figure this out later*/
		if eof then do; 
			cty = trim(left("&cty.")) ;
			if czcount ne 0 then mean_czmatch = czmatch/czcount ;
                        else mean_czmatch = . ;
                        if clustercount ne 0 then mean_clustermatch = clustermatch/clustercount ;
                        else mean_clustermatch = . ;
			output czclus;
		end ;
	run;
	%macro skip ;
	proc summary data = clusteravg nway;
		class cty ;
		var match ; 
		output out=clustercalc mean(match)=mean_clusmatch ;
	run;
	
	data czavg (keep=cty cluster cz&czyear. match);
		set cluster_cz (where=(cz&czyear.=trim(left("&cz."))));
		if cluster=trim(left("&cluster.")) then match = 1;
		else match = 0 ;
		cty = trim(left("&cty.")) ;
	run;
	proc summary data = czavg nway ;
		class cty ;
		var match ;
		output out=czcalc mean(match)=mean_czmatch ;
	run;
	
	/* QA CODE */

	%if %eval(&ii.>10 and &ii. < 20) %then %do;
		proc print data = clusteravg ;
			title "County &ii." ;
		run ;
		proc print data = czavg ;
			title "COUNTY &ii.";
		run;
	%end;

	%if %eval(&ii=1) %then %do;
		data cluster_divergence ;
			set clustercalc ;
		run;
		
		data cz_divergence ;
			set czcalc; 
		run;
	%end; 
	%else %do ;
		proc append base =cluster_divergence data=clustercalc ;
		run;
		proc append base = cz_divergence data=czcalc;
		run; 
	%end;
	%mend skip;
	
	%if %eval(&ii.=1) %then %do ;
		data czclus_merged ;
			set czclus ;
		run; 
	%end;
	%else %do ; 
		data czclus_merged ; 
			set czclus_merged czclus ;
		run; 
	%end;/*
	%if %eval(&ii.=20) %then %do ;
		proc print data = czclus_merged ;
		run; 
	%end ;*/
%end;
***********************************;
%macro skip2 ;
proc sort data = cz_divergence ;
	by cty ; 
run ;

proc sort data = cluster_divergence; 
	by cty ; 
run; 

data czclus_merged ;
	merge cz_divergence (in=a) cluster_divergence (in=b) ;
	by cty ; 
run;
%mend skip2 ;
*************************************;
proc means data = czclus_merged ;
	var mean_czmatch mean_clustermatch ;
run ;	

proc summary data = czclus_merged nway;
	var mean_czmatch;
	output out = czmatch mean(mean_czmatch)=similarity_czmatch; 
run ;

proc summary data = czclus_merged nway;
	var mean_clustermatch; 
	output out = clusmatch mean(mean_clustermatch) = similarity_clusmatch;
run; 

%if "&noprint."="YES" %then %do ;
%printlog ;
%put "LEAVING DIVERGENCE" ;
%end; 

%mend divergence ;
