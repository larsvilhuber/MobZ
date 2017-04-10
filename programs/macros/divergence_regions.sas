**************************
/*
This macro calculates two divergence measures:
- avg share of ctys in cluster that are in CZ
- avg share of ctys in CZ that are in cluster
*/
**************************;

%macro divergence_regions(dset,czyear) ; 

data clusters (keep=cty clus1-clus6) ;
	set OUTPUTS.allcounties_&dset. (rename = (cluswest = clus1 clussouthwest = clus2 clusmidwest = clus3 cluscentral= clus4
			clusnortheast=clus5 clussoutheast = clus6 home_cty = cty));	
run ; 

proc sort data = clusters ;
	by cty ;
run ; 
/*
proc contents data = OUTPUTS.cz&czyear. ;
run ; 

proc contents data = clusters ;
run ;	
*/
data cluster_cz ; 
	merge clusters (in=a) OUTPUTS.cz&czyear. (in=b) ;
	by cty ; 
	if a and b ; 
run ; 
/*
proc print data = cluster_cz (obs = 20) ;
run ; 
*/
proc sort data = cluster_cz ; 	
	by cty ;
run ;


%do rr = 1 %to 6 ; 

	data ctyclus ; 
		set cluster_cz (where=(clus&rr. ne '')) ;
		if (substr(cty,1,2) in ('06', '41', '53','16','32','49','04','48','46','31',
					'01','02','15','12','13','45', '37', '26','18','39',
					'54','42','36','50','33','23','25','44','09','34','24','10'))
		then eligible = 1 ;
		else eligible = 0 ;
		count = _N_ ;
	run  ;
	
	proc sql noprint ;
		select count(*)	 into :nrows from ctyclus; 
	quit ; 	
	
	%do ii = 1 %to &nrows. ;
	
		data _NULL_ ;
			set ctyclus (keep= clus&rr. cz&czyear. cty count where=(count=&ii.));  
			call symput('cluster', clus&rr.) ;
			call symput('cz', cz&czyear.) ;
			call symput('cty',cty);
			call symput('eligible',eligible) ;
		run ; 	
		
		data czclus (keep=cty mean_czmatch mean_clustermatch); 
			set ctyclus 	(where=((clus&rr. = "&cluster." or cz&czyear. = "&cz.")))	 end = eof;
	
			retain czcount clustercount czmatch clustermatch ;
			if _N_ = 1 then do ; /*Setting them to -1 so that counties don't count themselves in mean*/
				czcount = -1;
				clustercount = -1 ;
				czmatch = -1;
				clustermatch = -1;
			end; 			
			
			if cz&czyear. = "&cz." then do ;
				czcount = czcount + 1 ; 
				if clus&rr.="&cluster." then do;
					czmatch = czmatch+1 ; 
				end;
			end;
			if clus&rr. = "&cluster." then do ;
				clustercount = clustercount + 1 ;
				if cz&czyear. = "&cz." then do ;
					clustermatch = clustermatch+1 ; 
				end; 
			end; 
			if eof then do; 
				cty = "&cty." ;
				if czcount > 0 then mean_czmatch = czmatch/czcount ;
				else mean_czmatch = 0 ; 
				if clustercount > 0 then mean_clustermatch = clustermatch/clustercount ;
				else mean_clustermatch = 0 ; 
				
				if eligible = 1 then output czclus;
			end ;
		run;
		%put " *****************************************" ;
		%put " **** REGION &rr. and county &cty. ******" ;
		%put "********************************************";
	
	
		proc append base = czclus_merged data = czclus ; 
		run ;
	
	
	%end ; /*end of loop within region &rr.*/
/*	
	%if %eval(&rr. = 1 ) %then %do ;
		data czclus_merged ;
			set czclus_done ;
		run; 
	%end;
	%else %do ; 
		data czclus_merged ; 
			set czclus_merged czclus_done ;
		run; 
	%end;
*/
%end ; /* end region loop*/


proc means data = czclus_merged ;
	title "Means for matching for &cutoff." ;
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

proc datasets ;
	delete czclus_merged ; 
run; 

%mend divergence_regions ;








