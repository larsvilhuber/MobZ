%macro objfn_compare(year,cz1990=YES,cz2000=YES,national=YES,
			fastclus=YES,state=YES,msa=YES,msaonly=YES,noprint=NO);


%if "&noprint."="YES" %then %do ;
%put "ENTERING OBJFNCOMPARE.SAS" ;
%printjunk ;

%end; 
	%prep_objfn(&year.,outlib=WORK) ;


/******************************************
1990 COMMUTING ZONE DEFINITIONS
******************************************/
%if %eval("&cz1990."="YES") %then %do ; 

	data cz1990 (rename = (cz1990 = cluster)); 
		set OUTPUTS.cz1990 ;
	run; 
 

		%objectivefunction(cz1990,&year.,inlib=WORK,outlib=WORK); 
			data cluster1990 (rename=(objfn=cz1990));
				set objectivefn ; 
			run; 
		
		%put "FINISHED WITH OBJECTIVE FUNCTIONS FOR CLUSTERS CZ1990 and year &year."; 

%end ;
/******************************************
2000 COMMUTING ZONE DEFINITIONS
******************************************/	
%if %eval("&cz2000."="YES") %then %do ;
	
data cz2000 (rename = (cz2000 = cluster)) ;
	set OUTPUTS.cz2000 ;
run;
 
		%objectivefunction(cz2000,&year.,inlib=WORK,outlib=WORK);
			data cluster2000 (rename=(objfn=cz2000)) ;
				set objectivefn ; 
			run; 

		%put "FINISHED WITH OBJECTIVE FUNCTIONS WITH YEAR &year. and CLUSTERS CZ2000"; 

%end; 
******************************************* ;
*NATIONAL COMMUTING ZONE RUN - OUR CALCULATIONS ;
******************************************* ; 
%if %eval("&national."="YES") %then %do ;
	%cluster(jtw1990,inlib=OUTPUTS,outlib=WORK) ;

	%review(jtw1990,0.9418,inlib=WORK,outlib=WORK) ;

	data nationalrun (keep =cty cluster)  ;
		length cty $5. ;
		set clusfin_jtw1990 (rename = (_PARENT_ = cluster));
		cty = substr(_NAME_,4,5);
	run; 
	%objectivefunction(nationalrun,&year.,inlib=WORK,outlib=WORK); 
	
	data clusters_national  (rename=(objfn=national));
		set objectivefn ; 
	run; 

%end; 
***********************************************;
* FASTCLUS ;
***********************************************;
%if %eval("&fastclus."="YES") %then %do;
	*%fastclus_prep ;
	*%fastclus_loop(ctycoors,500,600,20,inlib=WORK,noprint_obj=YES) ;


	data clusters_fast ;
		set OUTPUTS.bestclusters_ctycoors ;
	run; 
	
	%objectivefunction(clusters_fast,&year.,inlib=WORK,outlib=WORK); 
		data fastclus (rename=(objfn=fastclus)) ;
			set objectivefn ; 
		run; 
%end; 
********************************************* ;
* STATE CLUSTERS;
********************************************* ;
%if %eval("&state."="YES") %then %do;
	data clusters_state (rename=(home_cty = cty)); 
		set OUTPUTS.reslf_lodes (where=(home_cty ne '')) ; 
		cluster = substr(home_cty,1,2);
	run;
	proc sort data = clusters_state ;
		by cty ;
	run; 
	%objectivefunction(clusters_state,&year.,inlib=WORK,outlib=WORK); 
		data stateclus (rename = (objfn=state)) ;
			set objectivefn ; 
		run; 
%end;  

********************************************* ;
* CBSA CLUSTERS (including remainder of state);
********************************************* ;
%if %eval("&msa."="YES") %then %do;
	proc sort data = GEO.blk_xwalk_wide out=cbsa (keep=fipsstco cbsaid) nodupkey; 
		by fipsstco;
	run;
	
	proc freq data = cbsa ;
		table cbsaid ;
	run;
	 
	data clusters_msa; 
		set cbsa (rename=(fipsstco=cty cbsaid=cluster_num)) ;
		cluster = put(cluster_num,8.) ;
		if cluster=929 then cluster= substr(cty,1,2)||'999'; /*Rest of state*/ 
	run;
	
	proc freq data = clusters_msa ;
		table cluster; 
	run; 

	%objectivefunction(clusters_msa,&year.,inlib=WORK,outlib=WORK); 
		data msaclus (rename=(objfn=msa));
			set objectivefn ; 
		run; 	
%end;

********************************************* ;
* CBSA CLUSTERS (only CBSAs);
********************************************* ;
%if %eval("&msaonly."="YES") %then %do;
	proc sort data = GEO.blk_xwalk_wide out=cbsa (keep=fipsstco cbsaid) nodupkey; 
		by fipsstco;
	run;
	
	proc freq data = cbsa ;
		table cbsaid ;
	run;
	 
	data clusters_msaonly; 
		set cbsa (where = (cluster_num ne 929 ) rename=(fipsstco=cty cbsaid=cluster_num)) ;
		cluster = put(cluster_num,8.) ;
	run;
	
	proc freq data = clusters_msa ;
		table cluster; 
	run; 

	%objectivefunction(clusters_msaonly,&year.,inlib=WORK,outlib=WORK); 
		data msaonlyclus (rename=(objfn=msaonly));
			set objectivefn ; 
		run; 	
%end;

**************************************;
* Random clusters (baseline);
* I am going to loop over multiple times
**************************************;

proc sort data=OUTPUTS.reslf_jtw1990 out=counties_rand (keep=home_cty) nodupkey ; 
	by home_cty ; 
run; 


%do ii = 1 %to 50 ; 

data counties_random (rename=(home_cty=cty)); 
	set counties_rand ; 
	randomnumber=ranuni(_N_*&ii.) ;
run; 

proc sort data = counties_random;
	by randomnumber ;
run; 

data clusters_random (keep=cty cluster); 
	set counties_random ;
	cluster = ceil(_N_/5) ;
run; 

	%objectivefunction(clusters_random,&year.,inlib=WORK,outlib=WORK,otherlib=OUTPUTS,noprint=YES); 

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

proc summary data=random_objfn; 
	var objfn;
	output out = random_objfn mean(objfn)=random ;
run; 

	data random_objfn (rename=(objfn=random));
		set objectivefn ; 
	run; 
****************************************** ;
* MERGING (based on which ones are turned on); 
****************************************** ;

data objectivefn_graph_&year. ;
	merge 
		%if %eval("&fastclus."="YES") %then %do;
			fastclus 
		%end; 
		%if %eval("&national." = "YES") %then %do;
			clusters_national
		%end; 
		%if %eval("&cz2000."="YES") %then %do;
			cluster2000 
		%end ;
		%if %eval("&cz1990."="YES") %then %do;
			cluster1990 
		%end;
		%if %eval("&state."="YES") %then %do ;
			stateclus
		%end;
		%if %eval("&msa."="YES") %then %do;
			msaclus
		%end;	
		%if %eval("&msaonly."="YES") %then %do;
			msaonlyclus
		%end;
		random_objfn;
	year = input(&year.,best32.) ;
run ;

proc print data = objectivefn_graph_&year. ; 
run; 

%if "&noprint."="YES" %then %do ;
%printlog 

 %put "LEAVING OBJFNCOMPARE.SAS" ;
%end; 

%mend objfn_compare ;


