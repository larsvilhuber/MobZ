%macro optimal_spectralparallel(infile=,outfile=,minclus=,maxclus=,indir=OUTPUTS,outdir=WORK,random=YES,noprint=NO) ; 
        
%if "&noprint."="YES" %then %do ;
%put "ENTERING REVIEW " ;
%printjunk ;

%end;
        
/*need to fix this */
%prep_objfn(1990,outlib=WORK) ; 

/******************* ONLY FOR RANDOM **************/        

        
/************* LOOPING OVER CLUSTER NUMS ****************/
%let bestobjfn = 10000.0;  
        
%let range = %eval(&maxclus. - &minclus.) ;         
%let chunks = &chunks. ; /* the max number of parallel processes */

*%prociml_step1b(&chunks.) ; /*create 10 different work spaces*/
        
/*------------ LOOPING OVER CLUSTER VALUES -------------*/
%do clusnum = &minclus. %to &maxclus. %by &chunks. ; 

/*_______________ START CHUNK LOOP _______________*/

%do chunk = 0 %to %eval(&chunks.-1) ;

    /*prep for parallelization*/
    %let j = %eval(&clusnum.+&chunk.) ;
%if %eval(&j. le &maxclus.) %then %do ; /*----- j condition -----*/
/* only do this step once*/
      
        /****** SETUP FOR PARALLELIZATION *******/
    SIGNON chunk&chunk. ;
    	   %syslput mywork=%sysfunc(pathname(WORK))/remote=chunk&chunk.;
           %syslput dirprog=&dirprog.            /remote=chunk&chunk. ;
	   %syslput clusnum=&clusnum.                    /remote=chunk&chunk.;
	   %syslput j=&j.                          /remote=chunk&chunk.;
	   %syslput chunk=&chunk.                  /remote=chunk&chunk.;
	   %syslput numclus=&j.                     /remote=chunk&chunk.;
           %syslput sdurate = &sdurate              /remote=chunk&chunk.;
           %syslput sdearn = &sdearn                /remote=chunk&chunk.;      
           %syslput inflows = &inflows.             /remote=chunk&chunk.;
           %syslput outflows=&outflows.             /remote=chunk&chunk.;
    RSUBMIT chunk&chunk. WAIT=NO;
    options sasautos="&dirprog./macros" mautosource  ;
    /*inside parallel process now */
    libname MYWORK "&mywork." ;    
    %spectral_cluster(infile=spec_&chunk.,outfile=iteration_&chunk.,        
                    numclus=&j.,indir=MYWORK,outdir=MYWORK,noprint=NO,instor=IMLSTOR_%eval(&chunk.+1),eigen=eigen_&chunk.);

    %objectivefunction_parallel(iteration_&chunk.,flows_&chunk.,reslf_&chunk.,corrlong_earnings_&chunk.,
        corrlong_urates_&chunk.,objfn_&chunk.,inlib=MYWORK,outlib=MYWORK) ;
        
    data MYWORK.objfn_&chunk. ;
        set MYWORK.objfn_&chunk. ;
        clusnum = &j. ;
    run;
        
    ENDRSUBMIT ;
        
    /*done with parallel process*/ 
%end; /*____________ end j condition ______________ */
%end; /* _________________ end chunk condition _____________*/  
        %put "made it out of parallel process!" ;
         
    WAITFOR _ALL_  /* collecting the pieces before proceeding */
    %do chunk = 0 %to %eval(&chunks.-1) ;
        %let j = %eval(&clusnum.+&chunk.) ;
    
        %if ( &j. le &maxclus. ) %then %do ; 
            chunk&chunk. 
        %end; 
    %end;    
    ;
    
   data functionoutcome ;
        set %if %eval(&clusnum.>&minclus.) %then %do ; 
            functionoutcome 
            %end;
            %do chunk = 0 %to %eval(&chunks.-1) ;
            %let jj = %eval(&clusnum.+&chunk.) ;
            %if (&j. le &maxclus.) %then %do ;
                 objfn_&chunk. 
            %end; 
            %end;
            ; 
    run;
        

%end;/*---------- end of loop ---------------*/
proc sort data=functionoutcome  ;
    by objfn ;
run; 

proc print data= functionoutcome ; 
run;

data _NULL_ ;
    set functionoutcome;
    if _N_ = 1 then call symput('optclus',clusnum) ;
run;
    
    %put "Best clusters are: &optclus." ;
    
    %spectral_cluster(infile=&infile.,outfile=&outfile.,numclus=&optclus.,indir=WORK,outdir=&outdir.,instor=IMLSTOR,eigen=eigen_vectors) ;


%if "&noprint."="YES" %then %do ;
%printlog ;
%put "LEAVING OPTIMAL SPECTRAL" ;
        %put "Best clusters are: &optclus." ;
%end;         
        
        
%mend optimal_spectralparallel ; 
