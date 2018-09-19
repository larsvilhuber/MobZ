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
    SIGNON chunk&chunk. ;
        %syslput mywork = %sysfunc(pathname(WORK))/ remote=chunk&chunk. ;
        %syslput ii = &ii.                        / remote=chunk&chunk. ;
        %syslput jj = &jj.                        / remote=chunk&chunk. ;
        %syslput dset = &dset.                    / remote=chunk&chunk. ;
        %syslput dirprog=&dirprog.                / remote=chunk&chunk. ;
        %syslput cutoff = &cutoff.                / remote=chunk&chunk. ; 
        %syslput chunk = &chunk.                  / remote=chunk&chunk. ;  
    RSUBMIT chunk&chunk. WAIT=NO ;
    options sasautos = "&dirprog./macros" mautosource fullstimer ; 
    libname MYWORK "&mywork." ;                                                
    
    %perturb_parallel(&dset._&chunk.,flows_&dset._p&chunk.,&jj.,inlib=MYWORK,outlib=MYWORK) ;
    
    %geoagg(&dset._p&chunk.,inlib=MYWORK,outlib=MYWORK) ; 
                                                
    %cluster(&dset._p&chunk.,inlib=MYWORK,outlib=MYWORK) ;
    
    %review(&dset._p&chunk.,&cutoff.,inlib=MYWORK,outlib=MYWORK,noprint=NO) ;
                                                    
    /* calculating relevant stats */
    %cluster_naming(clusfin_&dset._p&chunk.,clusname_&dset._p&jj._par,
             reslf_&dset._p&chunk.,  inlib=MYWORK,outlib=MYWORK,otherlib=MYWORK);
    %cluster_compare(clustersnamed_&dset.,clusname_&dset._p&jj._par,
                            reslf_&dset._p&chunk.,
                            inlib=MYWORK,outlib=WORK,noprint=NO,mlib=MYWORK) ;
    %cluster_statistics(clusfin_&dset._p&chunk.,inlib=WORK,outlib=MYWORK) ;
    
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
                    chunk&chunk. 
             %end; 
        %end; 
        ;

%put "FINISHED THE LOOP THAT STARTED FROM &ii." ;
%end; /*---------------- end of ii loop -----------------*/
        
    data OUTPUTS.finalstats_&dset._new ;
        set 
        %do ii = 1 %to &iterations. ;
            statistics_&ii. 
        %end;
        ;
    run;

    proc print data=clustersnamed_&dset. (obs=100) ;
        title 'clusters named - orig dataset' ;
    run;
        
    data OUTPUTS.bootclusters_&dset._new (rename=(county=fips)) ;
        merge clustersnamed_&dset.
        %do ii = 1 %to &iterations. ;
            clusname_&dset._p&ii._par (rename=(clustername=clustername_&ii.)) 
        %end;
        ;
        by county ;
    run;
            
proc export data=OUTPUTS.finalstats_&dset._new 
            outfile= "[outdat]/finalstats_&dset._new.dta" replace;
run;   
      
%mend bootstrap_parallel ;
