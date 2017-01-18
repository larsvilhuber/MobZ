/**********************************
    THIS MODULE RUNS SPECTRAL CLUSTERING
    FOR EACH NUMBER OF CLUSTERS,
    AND THEN COMPARES THEM ACCORDING 
    TO THE OBJECTIVE FUNCTION
    VALUES
**********************************/    
%prepspectral(infile=clustermatrix_jtw1990,outfile=specclus_jtw1990,indir=OUTPUTS,outdir=WORK);    
    
%macro optimal(infile=,outfile=,minclus=,maxclus=,indir=OUTPUTS,outdir=WORK,random=YES) ; 

*%prep_objfn(1990,outlib=WORK) ; 

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
/************* LOOPING OVER CLUSTER NUMS ****************/
%let bestobjfn = 10000.0;  
        
        
%do clusnum = &minclus. %to &maxclus. ; 

    %spectral_cluster(infile=specclus_jtw1990,outfile=iteration,        
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
    /************************
        compare current objfn value to best previous 
        (NOTE: initialized to 10000 to ensure first iteration replaces it ) 
    **********************/
/*read this into a datastep?*/
/*
    data _NULL_ ;
        
    run; 
    %if %eval(&bestobjfn.>&objfnvalue.) %then %do ;
	%put "OBJECTIVE FUNCTION VALUE REPLACED: 
                &bestobjfn. is greater than &objfnvalue." ;
	%let bestobjfn = &objfnvalue. ;
						
	data bestclusters ;
            set iteration ;
            numclusters = &clusnum.;
        run;		
    %end; 
*/
    
    
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
    by descending objfn ;
run; 

proc print data= functionoutcome ;  
    title 'objective function results' ;                                    

run;

data _NULL_ ;
    set functionoutcome;
    if _N_ = 1 then call symput('optclus',clusnum) ;
run;
    
    %put "Best clusters are: &optclus." ;
    
    %spectral_cluster(infile=specclus_jtw1990,outfile=bestclusters,numclus=&optclus.,indir=WORK,outdir=WORK) ;

%mend optimal ; 

%optimal(infile=,outfile=results,minclus=600,maxclus=602,indir=OUTPUTS,outdir=WORK,random=NO) ;

proc contents data=bestclusters ;
    title 'contents of bestclusters' ;
run;    
        
proc print data=bestclusters (obs=20);
    title 'optimal clusters output' ;
run;        

proc sort data=bestclusters out=OUTPUTS.optimal_spectral ;
    by county; 
run;
    
proc print data=OUTPUTS.optimal_spectral ;
run;
/*for potential graphing later*/    
proc sort data=functionoutcome out=OUTPUTS.spectral_objfn  ;
    by clusnum ; 
run;    
           

%clustermap(optimal_spectral,mapyear=1990,inlib=OUTPUTS,name=optimal_spectral,
            mapfile=optimal_spectral) ;
