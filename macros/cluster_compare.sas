/************************
This macro requires three inputs:
master cluster list (dsetm)
alternate cluster list (dset_alt)
outlib (default OUTPUTS)
        
Additionally, both dsetm and dsetalt 
need to be ran through "cluster_naming"         
************************/

%macro
cluster_compare(dsetm,dsetalt,resdat,inlib=OUTPUTS,outlib=OUTPUTS, noprint=NO , mlib=OUTPUTS, spectral=NO);

%if "&noprint."="YES" %then %do ;
    %put "ENTERING CLUSTER COMPARE " ;
    %printjunk ;
%end;

/*------------ SKIPPING THIS SECTION -----------*/
    %macro skip ;
/* If using industry, then use reslf_lodes */
%if "&spectral."="NO" %then %do ;
%if %sysfunc(index(&dsetm.,ind))>0 %then %do ; 

    %put "MADE IT IN - NOW SORTING reslf_&dsetm. " ;
	
	proc sort data = &mlib..reslf_lodes_2012 out = reslf_c ;
		by home_cty ; 
	run ;
%end;  
%else %do ; 
	proc sort data = &mlib..reslf_&dsetm. out = reslf_c ;
		by home_cty ; 
	run ;
%end ; 
%end ; 

%else %if "&spectral."="YES" %then %do ;
proc contents data=reslf ; 
    title 'reslf in cluster compare';
run; 
proc sort data= reslf  out= reslf_c (rename=(cty=home_cty));
    by cty ;
run;
%end; 
%mend skip ;
    /*-------------- ending skip ------------*/
    
    proc sort data= &inlib..&resdat. out=reslf_c (rename=(cty=county));
        by cty ;
    run;     
        
        
proc sort data = &inlib..&dsetm. 
	out=clustermaster;
	by county ;
run; 

proc sort data = &inlib..&dsetalt. 
	out=clusteralt (rename =(clustername=cluster_alt));
	by county ;
run ;


data test;					
	merge clustermaster (in=a)
		clusteralt (in=b) 
		reslf_c (in=resmerge);
	by county ; 
	
	if clustername ne cluster_alt then mismatch = 1 ;
	else mismatch = 0 ; 
run ; 

proc summary data = test ; 
	var mismatch ;
	output out = &outlib..mismatch_share mean(mismatch)=share_mismatch;
run ;				

proc summary data = test ; 
	var mismatch ;	
	output out = &outlib..mismatch_total sum(mismatch)=total_mismatch ;
run ;

proc summary data = test ; 
	var mismatch /
	weight = reslf ;
	output out = &outlib..mismatch_share_wgt mean(mismatch)=share_mismatch_wgt ;
run ;


proc sort data=&inlib..&dsetm. out = masterclus nodupkey ; 
	by clustername ; 
run; 

proc sort data = &inlib..&dsetalt. out = altclus nodupkey ; 
	by clustername ; 
run ;

data test ;
	merge masterclus (in=a)
		altclus (in=b);
	by clustername ; 
	
	if (a and not b) then clusa = 1 ;
	if (b and not a) then clusb = 1 ;
run ;

proc summary data = test ; 
	var clusa ;
	output out = &outlib..sample_merged sum(clusa) = total_samplemerged;
run; 
				
proc summary data = test ; 
	var clusb ;
	output out = &outlib..master_merged sum(clusb) = total_mastermerged;
run; 

%if "&noprint."="YES" %then %do ;

%printlog ;
%put "LEAVING CLUSTER COMPARE" ;
%end; 


%mend ; 
