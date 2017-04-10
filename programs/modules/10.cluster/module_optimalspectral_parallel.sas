/**********************************
    THIS MODULE RUNS SPECTRAL CLUSTERING
    FOR EACH NUMBER OF CLUSTERS,
    AND THEN COMPARES THEM ACCORDING 
    TO THE OBJECTIVE FUNCTION
    VALUES
**********************************/    
%prepspectral(infile=clustermatrix_jtw1990,outfile=specclus_jtw1990,indir=OUTPUTS,outdir=WORK);    
        
%macro optimal_parallel(infile=,outfile=,minclus=,maxclus=,indir=OUTPUTS,outdir=WORK,random=YES) ; 

*%prep_objfn(1990,outlib=WORK) ; 

%randomcounties_norm(1990,noprint=NO);

%if "&random." = "YES" %then %do ;
    data _NULL_ ;
	set OUTPUTS.random_objfn ; 
	call symput('inflows',rand_inflows);
	call symput('outflows',rand_outflows);
	call symput('sdurate',rand_corrurate);
	call symput('sdearn',rand_correarn); 
    run;
%end ; 
%else %do; /*If not normalizing by random results, then set to one */
    %let inflows = 1 ; 
    %let outflows = 1 ;
    %let sdurate =1 ;
    %let sdearn = 1 ;
%end ;
/* only normalizes the commuting measures */
/*
data _NULL ;
    set OUTPUTS.random_objfn;
    call symput('inflows',rand_inflows);
    call symput('outflows',rand_outflows) ;
run;
*/

/**************DOING STEP 1 OF PROC IML STEP ***********/
data flows_num ;
     set specclus_jtw1990 ;
run;         
            
data _null_;
    set ctylist end=eof;
    if eof then call symput('countycount',_N_);
run;   

%prociml_step1(&countycount.) ;

/************* LOOPING OVER CLUSTER NUMS ****************/
%let bestobjfn = 100000;  

%let range = %eval(&maxclus. - &minclus.) ;         
%let chunks = 20 ; /* the max number of parallel processes */


/* ---------------------------- START ii LOOP ------------------ */
%do ii = &minclus. %to &maxclus. %by &chunks. ; 

/* ______________________ START CHUNK LOOP ________________ */

%do chunk = 0 %to %eval(&chunks.-1) ;
        
    /* first, I need to prep for the parallelization */
    %let j = %eval(&ii.+&chunk.) ;    
%if %eval(&j.<=&maxclus.) %then %do  ; /************ J CONDITION *************/    
        
    /***** PREPPING THINGS FOR PARALLELIZING ****/
        
    data specclus_jtw1990_&chunk. ; 
        set specclus_jtw1990 ; 
    run;
        
    data corrlong_earnings_&chunk. ;
        set OUTPUTS.corrlong_earnings; 
    run;
        
    data corrlong_urates_&chunk. ;
        set OUTPUTS.corrlong_urates ; 
    run;
    
    data flows_&chunk ;
        set OUTPUTS.flows_jtw1990 ;
    run;
    
    data reslf_&chunk. ;
        set OUTPUTS.reslf_jtw1990 ;
    run;
    
    /****** SETUP FOR PARALLELIZATION *******/
    SIGNON chunk&chunk. ;
    	   %syslput mywork=%sysfunc(pathname(WORK))/remote=chunk&chunk.;
           %syslput dirprog=&dirprog.            /remote=chunk&chunk. ;
	   %syslput ii=&ii.                          /remote=chunk&chunk.;
	   %syslput j=&j.                          /remote=chunk&chunk.;
	   %syslput chunk=&chunk.                  /remote=chunk&chunk.;
	   %syslput numclus=&j.                     /remote=chunk&chunk.;
           %syslput countycount = &countycount.    / remote=chunk&chunk.;
           %syslput inflows=&inflows                /remote=chunk&chunk.;
           %syslput outflows=&outflows.             /remote=chunk&chunk.;
           %syslput sdurate = &sdurate.             /remote=chunk&chunk. ;
           %syslput sdearn = &sdearn.               /remote=chunk&chunk.;
    RSUBMIT chunk&chunk. WAIT=NO;
    options sasautos="&dirprog./macros" mautosource fullstimer  ;
    /*inside parallel process now */
    libname MYWORK "&mywork." ;
    
    
    %spectral_cluster(infile=specclus_jtw1990_&chunk.,outfile=iteration_&chunk.,        
                    numclus=&numclus.,indir=MYWORK,outdir=MYWORK);
    
    %objectivefunction_parallel(iteration_&chunk.,flows_&chunk.,reslf_&chunk.,corrlong_earnings_&chunk.,corrlong_urates_&chunk.,inlib=MYWORK,outlib=MYWORK) ;
    proc print data=MYWORK.objectivefn; 
            title 'for number of clusters: &j.';
    run;
    data MYWORK.outcome_&chunk. ;
       set MYWORK.objectivefn;
       clusnum=&j. ;
    run;
            
    ENDRSUBMIT ;
    /*done with parallel process */
    
%end ;  /*________________ end j condition _____________ */
%end ; /*______________ end chunk condition _______________ */  
%put "made it out of parallel processs!" ;    
    WAITFOR _ALL_  /* collecting the pieces before proceeding */
    %do chunk = 0 %to %eval(&chunks.-1) ;
        %let j = %eval(&ii+&chunk.) ;
    
        %if ( &j. le &maxclus. ) %then %do ; 
            chunk&chunk. 
        %end; 
    %end;  
    ; /*collected*/
                                        
      /* collecting the log files */
    %do chunk = 0 %to %eval(&chunks.-1) ;
        %let j = %eval(&ii+&chunk.) ;    
        %if ( &j. le &maxclus. ) %then %do ; 
           RGET  chunk&chunk. ;
        %end; 
    %end;  
     /*collected*/    
            
            
    data functionoutcome;  
        set %if &ii. > &minclus. %then %do ;
            functionoutcome
            %end; 
            %do chunk = 0 %to %eval(&chunks.-1) ;
                %let  j = %eval(&ii.+&chunk.) ;
                %if &j. le &maxclus. %then %do;
                    outcome_&chunk.
                %end;
            %end; 
            ;
    run;
    
    /* moved objective function inside the parallized process */
 %macro skip ;    
    %do chunk = 0 %to %eval(&chunks.-1) ; /* ------- start of chunk loop ----- */
        %let j = %eval(&ii.+&chunk.)     ;
        %if (&j. le &maxclus. ) %then %do ; /* ---- start of j condition ---- */
    
            %objectivefunction(iteration_&chunk.,1990,inlib=WORK,outlib=WORK) ;

        /************************
        compare current objfn value to best previous 
        (NOTE: initialized to 10000 to ensure first iteration replaces it ) 
        **********************/
       /* %if %eval(&bestobjfn. > &objfnvalue.) %then %do ;
            %put "OBJECTIVE FUNCTION VALUE REPLACED: 
                    &bestobjfn. is greater than &objfnvalue." ;
        	%let bestobjfn = &objfnvalue. ;
						
            data bestclusters ;
                set iteration_&chunk. ;
                numclusters = &j.;
            run;		
        %end; 
       */     
        /* storing objective function outcome */
        data outcome ;
            set objectivefn; 
            clusnum = &j.;
        run;
        data functionoutcome ;
            set %if &j. > &minclus. %then %do ;
                functionoutcome 
                %end; 
                outcome ; 
        run;                
        
        %end ; /* ---- end of the j condition ----*/
    
    
    %end;  /* ----- end of the chunk loop ---- */
%mend skip ; 
    
%end; /***** ======================= END OF ii LOOP ================== *****************/
        
proc sort data=functionoutcome ;
   by descending objfn ; 
run;  
        
proc print data=functionoutcome (obs=100); 
    title 'cluster objective functions';
run; 

proc sort data=functionoutcome out=OUTPUTS.spectral_objfn_outcomes ;
    by clusnum;
run;    

data _NULL_ ;
    set functionoutcome ; 
    if _N_ = 1 then call symput('optclus',clusnum) ;
run;
    
%put "Best clusters are: &optclus." ;
    
%spectral_cluster(infile=specclus_jtw1990,outfile=bestclusters,numclus=&optclus.,indir=WORK,outdir=&outdir.) ;    


/******************************************
Also calculating optimal cluster if 
commuting is only criterion
*******************************************/

data functionoutcome_comm (keep = share_inflows share_outflows objfn_comm clusnum); 
    set functionoutcome ;
    objfn_comm = (-share_inflows-share_outflows)/2 ; 
run;

proc sort data=functionoutcome_comm ;
    by descending objfn_comm ; 
run;

data _NULL_ ;
    set functionoutcome_comm; 
    if _N_ =1 then call symput('optclus_comm',clusnum) ;
run;    
    
proc print data=functionoutcome_comm (obs=15) ;
    title 'Objective function - just commuting' ; 
run;
    
%put "Best clusters using only commuting flows are : &optclus_comm." ;
    
%spectral_cluster(infile=specclus_jtw1990,outfile=bestclusters_comm,numclus=&optclus_comm.,indir=WORK,outdir=&outdir.) ;


%mend optimal_parallel ; 

%optimal_parallel(infile=,outfile=results,minclus=500,maxclus=800,indir=OUTPUTS,outdir=OUTPUTS,random=NO) ;

proc sort data=OUTPUTS.bestclusters out=OUTPUTS.optimal_spectral_par (keep= county cluster ) ;
    by county ;
run;
    
proc print data=OUTPUTS.optimal_spectral_par;
    title 'optimal clusters' ;
run;
    
%clustermap(optimal_spectral_par,mapyear=1990,inlib=OUTPUTS,name=optimal_spectral_par,
                mapfile=optimal_spectral_par,mappath=./paper/figures) ;

%cluster_statistics(optimal_spectral_par,inlib=OUTPUTS,outlib=OUTPUTS,matching=NO) ;
                        
proc print data=statistics ; 
    title 'summary stats for spectral clusters' ;
run;                        

proc export data=OUTPUTS.spectral_objfn_outcomes
    outfile = './outputs/spectral_objfn_outcomes.dta' replace ; 
run;    
