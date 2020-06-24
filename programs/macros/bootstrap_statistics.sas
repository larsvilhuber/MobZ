%macro bootstrap_statistics(dset,iterations,cutoff=&cutoff_jtw2009.,inlib=OUTPUTS,outlib=OUTPUTS) ; 

/**********************
First run master file
**********************/

%geoagg(&dset.,inlib=&inlib.,outlib=WORK);
%cluster(dset=&dset.,inlib=WORK,outlib=WORK);
%review(&dset.,&cutoff.,inlib=WORK,outlib=WORK);

/**************** EXTRACTING " TRUE " VALUES ***************/

	data _NULL_ ;
		set mean_clussize;
		call symput('meanclussize',mean_clussize);
	run;

	data _NULL_ ;
		set clustercount ;
		call symput('numclusters',numclusters) ;
	run; 

%put " Mean cluster size is : &meanclussize. and number of clusters is &numclusters." ;


%cluster_naming(clusfin_&dset.,clustersnamed_&dset.,reslf_&dset.,
                            inlib=WORK,outlib=WORK,otherlib=WORK);
            
proc sort data= clustersnamed_&dset. ;
    by county;
run;            
/******************** BOOTSTRAP LOOP *******************/
%do ii = 1 %to &iterations. ;

	%perturb_alt(&dset.,&ii.,inlib=&inlib.,outlib=WORK) ;
	
	%geoagg(&dset._p&ii.,inlib=WORK,outlib=WORK);
	
	%cluster(dset=&dset._p&ii.,inlib=WORK,outlib=WORK,noprint=YES);
	
	%review(&dset._p&ii.,&cutoff.,inlib=WORK,outlib=WORK,noprint=YES) ;	
	
	/***********************************
	   CALCULATE RELEVANT STATISTICS	
	***********************************/
	%cluster_naming(clusfin_&dset._p&ii.,clustersnamed_&dset._p&ii.,reslf_&dset._p&ii.,
                                inlib=WORK,outlib=WORK,otherlib=WORK);
	%cluster_compare(clustersnamed_&dset.,clustersnamed_&dset._p&ii.,
                            reslf_&dset._p&ii.,
                                inlib=WORK,outlib=WORK,noprint=NO,mlib=WORK) ;
	%cluster_statistics(clusfin_&dset._p&ii.,inlib=WORK,worklib=WORK) ;

	data statistics ;
		set statistics ;
		iteration = &ii. ;
	run;
	
		data &outlib..finalstats_&dset._new2 ;
			set statistics 
                        %if %eval(&ii. ne 1) %then %do;
                            &outlib..finalstats_&dset._new2 
                        %end; 
                        ;
		run; 		
	/***********************************
	   DELETE INTERMEDIATE FILES
	   IN ORDER TO NOT OVERWHELM
	   SERVER
	***********************************/
	proc datasets library=work ;
		delete flows_&dset._p&ii. ctypairs_&dset._p&ii. reslf_&dset._p&ii.
			clustertree_&dset._p&ii. clusfin_&dset._p&ii.;
	run; 	

        proc sort data=clustersnamed_&dset._p&ii. ;
            by county ;
        run;
%end ;

data &outlib..bootclusters_&dset. (rename=(county=fips));
    merge clustersnamed_&dset. 
    %do ii = 1 %to &iterations. ;
         clustersnamed_&dset._p&ii.  (rename=(clustername = clustername_&ii.))  
    %end;            
    ;
    by county;
    clus_switched = . ;
    %do ii = 2 %to &iterations. ;
        if  (clustername_1 ne clustername_&ii.) then clus_switched = 1 ; 
    %end ; 
        if clus_switched = . then clus_switched = 0 ;
run;     
    
proc print data= &outlib..bootclusters_&dset. (obs=  50) ;
    title 'Cluster realizations' ;
run;
    
proc freq data= &outlib..bootclusters_&dset. ;
    table clus_switched ;
run;    

proc print data= &outlib..finalstats_&dset._new2 ;
    title 'Final stats of bootstrap procedure' ;
run ;

proc export data=&outlib..finalstats_&dset._new2 
            outfile= "&dirinterwrk./finalstats_&dset._new2.dta" replace;
run;            

proc means data = &outlib..finalstats_&dset._new2 mean std min p25 p50 p75 max;
	var mean_clussize median_clussize numclusters /*share_mismatch
		share_mismatch_wgt total_mismatch*/ ;
	title1 'Summary statistics from Bootstrap procedure' ;
run ;	

ods graphics on /imagefmt=png imagename = "mean_clussize_&dset." ;
ods listing gpath = "&dirfig." ;

proc sgplot data = &outlib..finalstats_&dset._new2 noautolegend ;
	histogram mean_clussize ; 
	density mean_clussize/
		name=  "Average Cluster Size"
		type = kernel ;
	refline &meanclussize. /axis = X lineattrs=(color=red thickness =5
	pattern=LongDash);
run ;	

ods graphics on /imagefmt=png imagename = "numclusters_&dset." ;
ods listing gpath = "&dirfig." ;

proc sgplot data = &outlib..finalstats_&dset._new2 noautolegend;
	histogram numclusters ;
	density numclusters/
		name = "Distribution of Cluster Count" 
		type = kernel;
	refline &numclusters. /axis = X lineattrs=(color=red thickness =5
	pattern=LongDash) ;
run ; 

ods graphics on /imagefmt=png imagename = "mismatchedcounties_&dset." ;
ods listing gpath = "&dirfig." ;

proc sgplot data = &outlib..finalstats_&dset._new2 noautolegend;
	histogram total_mismatch ;
	density total_mismatch/
		name = "Distribution of Mismatched Counties" 
		type = kernel;
run;	

proc export data=&outlib..finalstats_&dset._new2 
        outfile="&dirinterwrk./finalstats_&dset._moe_new2.dta" replace;
run;

*ods close ; 

******** BROKE HERE NOT SURE WHY ***************** ;

proc sort data = clustersnamed_&dset. out = clusname ;
	by clustername; 
run; 


data masterclus ; 
	set clusname; 
	x=1 ;
run; 
%macro skip ; 
proc summary data = masterclus nway; 
	var x ; 
	class _PARENT_ ;
	output out = clussize 	N(x) = numcounties ; 
run;

proc freq data = masterclus nlevels;
	table clustername ; 
run;

proc summary data = clussize ; 
	var numcounties;	
	output out = mean mean(numcounties) = mean_clussize;
run; 

proc summary data = masterclus ; 
	var numcounties;
	output out = median p50(numcounties) = median_clussize;
run;

data test ;	
	merge mean_clussize median_clussize ;
run; 
%mend skip ;
proc print data = test ; 
	title 'Summary statistics for master cluster' ;
run; 



%mend bootstrap_statistics ;
