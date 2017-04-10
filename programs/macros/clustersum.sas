%macro clustersum(cz1990=YES,cz2000=YES,fastclus=YES,state=YES,msa=YES);

%macro clustersumfn(clusterdata);
	proc freq data=&clusterdata. noprint /*NOT ALWAYS CHARACTER, FOR EXAMPLE, BESTCLUSTERS (where=(cluster ne ''))*/;
		table cluster / out=ctysum;
	run;
	proc summary data=ctysum (keep=count cluster rename=(count=ctycnt));
		var ctycnt;
		output out=clustsum (drop=_TYPE_ _FREQ_)
			n= sum= median= mean= std= min= max= / autoname;
	run;
	data clustsum_&clusterdata.;
		length clustername $20;
		set clustsum;
		clustername="&clusterdata.";
	run;
		
%mend;


/******************************************
1990 COMMUTING ZONE DEFINITIONS
******************************************/
%if %eval("&cz1990."="YES") %then %do ; 

	data cz1990 (rename = (cz1990 = cluster)); 
		set OUTPUTS.cz1990 ;
	run;
	%clustersumfn(cz1990);

		%put "FINISHED WITH SETUP FOR CLUSTERS CZ1990"; 

%end ;
/******************************************
2000 COMMUTING ZONE DEFINITIONS
******************************************/	
%if %eval("&cz2000."="YES") %then %do ;
	
	data cz2000 (rename = (cz2000 = cluster)) ;
		set OUTPUTS.cz2000 ;
	run;
	%clustersumfn(cz2000);

		%put "FINISHED WITH SETUP FOR CLUSTERS CZ2000"; 

%end;
***********************************************;
* FASTCLUS ;
***********************************************;
%if %eval("&fastclus."="YES") %then %do;

	data clusters_fast (drop=cluster_num);
		length cluster $8;
		set OUTPUTS.bestclusters_ctycoors (rename=(cluster=cluster_num));
		cluster=put(cluster_num,8.);
	run; 
	%clustersumfn(clusters_fast);
	
%end; 
********************************************* ;
* STATE CLUSTERS;
********************************************* ;
%if %eval("&state."="YES") %then %do;
	data clusters_state (rename=(home_cty = cty));
		length cluster $8;
		set OUTPUTS.reslf_lodes (where=(home_cty ne '')) ; 
		cluster = substr(home_cty,1,2);
	run;
	proc sort data = clusters_state ;
		by cty ;
	run; 
	%clustersumfn(clusters_state);

%end;  

********************************************* ;
* CBSA CLUSTERS;
********************************************* ;
%if %eval("&msa."="YES") %then %do;
	proc sort data = GEO.blk_xwalk_wide out=cbsa (keep=fipsstco cbsaid) nodupkey; 
		by fipsstco;
	run;
	proc freq data = cbsa noprint;
		table cbsaid ;
	run;
	data clusters_msa; 
		length cluster $8;
		set cbsa (rename=(fipsstco=cty cbsaid=cluster_num)) ;
		if cty ne '' and input(substr(cty,1,2),2.)<=56 ; 
		cluster=put(cluster_num,8.);
		if (cluster=929) then cluster= substr(cty,1,2)||'999'; /*Rest of state*/ 
	run;
	
	proc sort data = clusters_msa nodupkey; 
		by cty ; 
	run; 
	
	%clustersumfn(clusters_msa);
%end;


**************************************;
* Random clusters (baseline);
* I am going to loop over multiple times
**************************************;

proc sort data=OUTPUTS.reslf_jtw1990 out=counties_rand (keep=home_cty) nodupkey ; 
	by home_cty ; 
run; 


%do ii = 1 %to 1 ; 

data counties_random (rename=(home_cty=cty)); 
	set counties_rand ; 
	randomnumber=ranuni(_N_*&ii.) ;
run; 

proc sort data = counties_random;
	by randomnumber ;
run; 

data clusters_random (keep=cty cluster); 
	length cluster $8;
	set counties_random ;
	cluster_num = ceil(_N_/5) ;
	cluster=put(cluster_num,8.);
run; 

%end; 	

	%clustersumfn(clusters_random);

****************************************** ;
* MERGING (based on which ones are turned on); 
****************************************** ;

data OUTPUTS.cluster_sum;
	set 
		%if %eval("&fastclus."="YES") %then %do;
			clustsum_clusters_fast
		%end; 
		%if %eval("&cz1990."="YES") %then %do;
			clustsum_cz1990 
		%end;
		%if %eval("&cz2000."="YES") %then %do;
			clustsum_cz2000 
		%end;
		%if %eval("&msa."="YES") %then %do;
			clustsum_clusters_msa
		%end;	
		%if %eval("&state."="YES") %then %do ;
			clustsum_clusters_state
		%end;
		clustsum_clusters_random;
run ;

proc print data = OUTPUTS.cluster_sum ; 
	title "Summary statistics of county allocations to clusters, by methodology";
run; 

%mend clustersum ;


