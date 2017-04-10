%macro objfn_compare_fastclus(year,cz1990=YES,fastclus=YES,fastclus_alt=YES);

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

***********************************************;
* FASTCLUS ;
***********************************************;
%if %eval("&fastclus."="YES") %then %do;
	*%fastclus_prep ;
	*%fastclus_loop(ctycoors,500,600,20,inlib=WORK,noprint_obj=YES) ;


	data clusters_fast ;
		set OUTPUTS.bestclusters_norm ;
	run; 
	
	%objectivefunction(clusters_fast,&year.,inlib=WORK,outlib=WORK); 
		data fastclus (rename=(objfn=fastclus_norm)) ;
			set objectivefn ; 
		run; 
%end; 

/*********************************************
Fast clus alternative
**********************************************/
%if %eval("&fastclus_alt."="YES") %then %do;

	data clusters_fast ;
		set OUTPUTS.bestclusters_alt ;
	run; 
	
	%objectivefunction(clusters_fast,&year.,inlib=WORK,outlib=WORK); 
		data fastclus_alt (rename=(objfn=fastclus_alt)) ;
			set objectivefn ; 
		run; 
%end; 
****************************************** ;
* MERGING (based on which ones are turned on); 
****************************************** ;

data objectivefn_graph_&year. ;
	merge 
		%if %eval("&fastclus."="YES") %then %do;
			fastclus 
		%end; 
		%if %eval("&fastclus_alt."="YES") %then %do;
			fastclus_alt 
		%end;  
		%if %eval("&cz1990."="YES") %then %do;
			cluster1990 
		%end;
		;
	year = input(&year.,best32.) ;
run ;

proc print data = objectivefn_graph_&year. ; 
run; 

%mend objfn_compare ;


