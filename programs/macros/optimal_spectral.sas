%macro optimal_spectral(infile=,outfile=,minclus=,maxclus=,indir=OUTPUTS,outdir=WORK,random=YES,noprint=NO) ; 
        
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
        
        
%do clusnum = &minclus. %to &maxclus. ; 

    %spectral_cluster(infile=&infile.,outfile=iteration,        
                    numclus=&clusnum.,indir=WORK,outdir=WORK);
    
    /************************************
    OUTPUT OF FILE:
    state (2dig float)
    county (3dig float)
    cluster (number)
    ************************************/
    *formatting for objective function; 
    data iteration ;
        set iteration ; 
        cty = state*1000 + county ;
    run;         

    %objectivefunction(iteration,1990,inlib=WORK,outlib=WORK) ;
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
        clusnum = &clusnum.;
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
    
    %spectral_cluster(infile=specclus_jtw1990,outfile=&outfile.,numclus=&optclus.,indir=WORK,outdir=&outdir.) ;


%if "&noprint."="YES" %then %do ;
%printlog ;
%put "LEAVING OPTIMAL SPECTRAL" ;
        %put "Best clusters are: &optclus." ;
%end;         
        
        
%mend optimal_spectral ; 
