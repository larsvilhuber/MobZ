%macro bootstrap_parallel(dset,iterations,cutoff=&cutoff_jtw2009.) ; 

/**********************
First run master file
**********************/

%geoagg(&dset.,inlib=OUTPUTS,outlib=WORK);
%cluster(&dset.,inlib=WORK,outlib=WORK);
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
      
%let chunks = 20; 
        
%do chunk = 0 %to %eval(&chunks.-1) ;

    /* first I need to prep for parallelization */
    data flows_&dset._&chunk. ; 
        set OUTPUTS.flows_&dset. ; 
    run;

%end; 
        
/************* BOOTSTRAP LOOP ******************/

/* start ii loop */
%do ii = 1 %to &iterations. %by &chunks. ; 

/* _______________________ START CHUNK LOOP ______________ */

%do chunk = 0 %to %eval(&chunks.-1) ;

/* parallel */        
    %let jj = %eval(&ii.+&chunk.) ;
    %let counter = &jj. ;
    %if (&jj. le &iterations. ) %then %do ; 
/********setup for parallelization ********/
    SIGNON chunk&counter. ;
        %syslput mywork = %sysfunc(pathname(WORK))/ remote=chunk&counter. ;
        %syslput ii = &ii.                        / remote=chunk&counter. ;
        %syslput jj = &jj.                        / remote=chunk&counter. ;
        %syslput dset = &dset.                    / remote=chunk&counter. ;
        %syslput dirprog=&dirprog.                / remote=chunk&counter. ;
        %syslput cutoff = &cutoff.                / remote=chunk&counter. ; 
        %syslput chunk = &chunk.                  / remote=chunk&counter. ;  
    RSUBMIT chunk&counter. WAIT=NO ;
    options sasautos = "&dirprog./macros" mautosource fullstimer ; 
    libname MYWORK "&mywork." ;                                                
    
    %perturb_parallel(&dset._&chunk.,flows_&dset._&chunk.,&jj.,inlib=MYWORK,outlib=MYWORK) ;
    
    %geoagg(&dset._&chunk.,inlib=MYWORK,outlib=MYWORK) ; 
                                                
    %cluster(&dset._&chunk.,inlib=MYWORK,outlib=MYWORK) ;
    
    %review(&dset._&chunk.,&cutoff.,inlib=MYWORK,outlib=MYWORK,noprint=NO) ;
                                                    
    /* calculating relevant stats */
    %cluster_naming(clusfin_&dset._&chunk.,clusname_&dset._p&jj._par,
             reslf_&dset._&chunk.,  inlib=MYWORK,outlib=MYWORK,otherlib=MYWORK);
    %cluster_compare(clustersnamed_&dset.,clusname_&dset._p&jj._par,
                            reslf_&dset._&chunk.,
                                inlib=MYWORK,outlib=WORK,noprint=NO,mlib=MYWORK) 
    %cluster_statistics(clusfin_&dset._&chunk.,inlib=WORK,outlib=MYWORK) ;
    
    data MYWORK.statistics_&jj. ;
        set statistics ;
        iteration = &jj.  ;
    run;
        
    ENDRSUBMIT ;
    /* done with parallel process */
%end; /* ___________ end j condition ______________ */
%end;  /* ________________ end chunk loop ________ */

        WAITFOR _ALL_ 
        %do chunk = 0 %to %eval(&chunks.-1) ;
             %let j = %eval(&ii.+&chunk.) ;
             %if (&j. le &iterations.) %then %do ;
                    chunk&j. 
             %end; 
        %end; 
        ;

%put "FINISHED THE LOOP THAT STARTED FROM &ii." ;
%end; /*---------------- end of ii loop -----------------*/
        
    data OUTPUTS.finalstats_&dset. ;
        set 
        %do ii = 1 %to &iterations. ;
            statistics_&ii. 
        %end;
        ;
    run;
        
    data OUTPUTS.bootclusters_&dset. (rename=(county=fips)) ;
        merge clustersnamed_&dset.
        %do ii = 1 %to &iterations. ;
            clusname_&dset._p&ii._par (rename=(clustername=clustername_&ii.)) 
        %end;
        ;
    run;
            
proc export data=OUTPUTS.finalstats_&dset. 
            outfile= "/data/working/mobz/outputs/finalstats_&dset..dta" replace;
run;   
      
%mend bootstrap_parallel ;
