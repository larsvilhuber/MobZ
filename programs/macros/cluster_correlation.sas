%macro cluster_correlation(clusdset,corrlongdset,classvar,corrvar) ;
/*
proc contents data=&corrlongdset. ;
run;
  
proc contents data=&clusdset. ;
    run; 
*/
/*only for testing*/


proc sort data=&corrlongdset.(where=(work_cty ne ''))  out=corrdat ; 
    by home_cty work_cty ; 
run; 
/*    
proc print data=corrdat (obs=20);
    title 'corelation dataset' ;
run;    
*/            
proc sort data=&clusdset. out=clus (keep=county cluster) ; 
    by county ;
run;
            
data clusa (rename=(county=home_cty)) clusb (rename=(county=work_cty)) ;
     set clus ;
    output clusa;
    output clusb;
run;    
    
proc sql nowarn; 
    create table clusterjoin as 
        select clusa.*, clusb.work_cty 
        from
            clusa a, 
            clusb b
        where a.cluster = b.cluster  ; 
quit;
          
proc sort data=clusterjoin (keep=home_cty work_cty cluster) ; 
    by home_cty work_cty ; 
run;

data corrclus ; 
    merge  clusterjoin (in=a keep=home_cty work_cty cluster) corrdat ;
    by home_cty work_cty ;    
    if a ;
    
    if &corrvar. = . then do ;
        if home_cty = work_cty then &corrvar. = 1 ;
        else if home_cty ne work_cty then &corrvar. = 0.5 ;
    end; 
run; 
/*    
    proc print data=corrdat (obs=50) ;
        title 'before merge' ;     
    run;
 */   
proc summary data=corrclus nway; 
        var &corrvar.  ;
        class &classvar. ; 
        output out=corrclusters mean(&corrvar.)=mean_&corrvar. ;
run;     
proc sort data=corrclus (where=(cluster ne . ) ); 
    by cluster ;
run;
/*
proc contents data=corrclusters;  
    title 'Output dataset from cluster_correlation' ;
run;
    */
proc print data=corrclusters (obs=50) ;
        title 'after merge' ;
run;

/* This is a QA check */
/*
data corr_missing ; 
    set corrclusters (where=(mean_corr=.)) ;
run;
    
proc  sort data= corr_missing ;
    by cluster ; 
run;
    
proc sort data= corrclus ;
    by cluster ;
run;        
    
data corr_missing ;
    merge corrclus corr_missing (in=a) ; 
    by cluster; 
    if a;
run;
 */
    /*
proc print data= corr_missing ; 
    title 'missing correlations' ;
run;
        
proc print data=corrclusters(where=(mean_corr=.)) ;
        title 'missing clusters' ;
run;   */     
    

%mend cluster_correlation ; 
