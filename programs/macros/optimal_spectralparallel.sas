%macro optimal_spectralparallel(infile=,outfile=,minclus=,maxclus=,indir=OUTPUTS,outdir=WORK,random=YES,noprint=NO) ; 
        
%if "&noprint."="YES" %then %do ;
%put "ENTERING REVIEW " ;
%printjunk ;

%end;
        
/*need to fix this */
%prep_objfn(1990,outlib=WORK) ; 

/******************* ONLY FOR RANDOM **************/        
%if "&random." = "YES" %then %do ;

%randomcounties_norm(&year.,noprint=NO);

data _NULL_ ;
	set random_objfn ; 
	call symput('inflows',rand_inflows);
	call symput('outflows',rand_outflows);
	call symput('sdurate',rand_sdurate);
	call symput('sdearn',rand_sdearn); 
run;
%end ; 
%else %do; /*If not normalizing by random results, then set to one */
    %let inflows = 1 ; 
    %let outflows = 1 ;
    %let sdurate =1 ;
    %let sdearn = 1 ;
%end ;
/********************** RANDOM CLUSTERS END******************/        
        
/************* LOOPING OVER CLUSTER NUMS ****************/
%let bestobjfn = 10000.0;  
        
%let range = %eval(&maxclus. - &minclus.) ;         
%let chunks = 10 ; /* the max number of parallel processes */
        
/*------------ LOOPING OVER CLUSTER VALUES -------------*/
%do clusnum = &minclus. %to &maxclus. %by &chunks. ; 

/*_______________ START CHUNK LOOP _______________*/

%do chunk = 0 %to %eval(&chunks.-1) ;
    /*prep for parallelization*/
    %let j = %eval(&clusnum.+&chunk.) ;
%if %eval(&j. le &maxclus.) %then %do ; /*----- j condition -----*/
    data spec_&chunk.;
        set &infile. ;
    run;
        
        /****** SETUP FOR PARALLELIZATION *******/
    SIGNON chunk&chunk. ;
    	   %syslput mywork=%sysfunc(pathname(WORK))/remote=chunk&chunk.;
           %syslput dirprog=&dirprog.            /remote=chunk&chunk. ;
	   %syslput clusnum=&clusnum.                    /remote=chunk&chunk.;
	   %syslput j=&j.                          /remote=chunk&chunk.;
	   %syslput chunk=&chunk.                  /remote=chunk&chunk.;
	   %syslput numclus=&j.                     /remote=chunk&chunk.;
    RSUBMIT chunk&chunk. WAIT=NO;
    options sasautos="&dirprog./macros" mautosource  ;
    /*inside parallel process now */
    libname MYWORK "&mywork." ;    
    %spectral_cluster(infile=spec_&chunk.,outfile=iteration_&chunk.,        
                    numclus=&numclus.,indir=MYWORK,outdir=MYWORK);
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
    
    /************************************
    OUTPUT OF FILE:
    state (2dig float)
    county (3dig float)
    cluster (number)

    *formatting for objective function; 
    data iteration ;
        set iteration ; 
        cty = state*1000 + county ;
    run;         
    ************************************/
    
%do chunk = 0 %to %eval(&chunks.-1) ; /* ------- start of chunk loop ----- */
    %let j = %eval(&clusnum.+&chunk.) ;
%if (&j. le &maxclus. ) %then %do ; /* ---- start of j condition ---- */
    
        %objectivefunction(iteration_&chunk.,1990,inlib=WORK,outlib=WORK) ;
    /*
    proc print data=objectivefn ;
    run; 
    */
    data _NULL_ ;
        set objectivefn;
        call symput('objfnvalue',objfn) ;
    run;
    
    /* storing objective function outcome */
    data outcome ;
        set objectivefn; 
        clusnum = &j.;
    run;
        
    %if &clusnum. = &minclus. %then %do ; 
        data functionoutcome ;
            set outcome ; 
        run;             
    %end; 
    %else %do ;
        data functionoutcome ;
            set functionoutcome outcome ; 
        run; 
    %end;  
    
%end ; /* ---- end of the j condition ----*/
    
    
%end;  /* ----- end of the chunk loop ---- */        

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
    
    %spectral_cluster(infile=&infile.,outfile=&outfile.,numclus=&optclus.,indir=WORK,outdir=&outdir.) ;


%if "&noprint."="YES" %then %do ;
%printlog ;
%put "LEAVING OPTIMAL SPECTRAL" ;
        %put "Best clusters are: &optclus." ;
%end;         
        
        
%mend optimal_spectralparallel ; 
