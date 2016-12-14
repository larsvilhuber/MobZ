/**********************
INPUT: dsetm should have county and cluster
       dsetalt should have county and cluster
    
    This calculation is based on the divergence equation in Fowler Rhubart and Jensen (2016) eqn 3.
***********************/
    
%macro cluster_similarity(dsetm,dsetalt,resdat,inlib=OUTPUTS,outlib=OUTPUTS,noprint=NO) ;
    
%if "&noprint."="YES" %then %do ;
    %put "ENTERING CLUSTER COMPARE " ;
    %printjunk ;
%end;    
    
/************************ START OF SIMILARITY CALCULATION ************/
        
data master ;
   set &inlib..&dsetm.;
   x =1 ;
run;        
    
proc summary data=master nway;
    var x;  
    class cluster;
    output out=master_count sum(x) = numctys_a ; 
run;
        
data alternate ; 
    set &inlib..&dsetalt ;
    x = 1 ;
run;        
    
proc summary data=alternate nway;
    var x; 
    class cluster ; 
    output out=alternate_count sum(x) = numctys_b ;
run;
    
proc sort data=&inlib..&dsetm. out=clusa (rename=(cluster=clusa));
    by county ; 
run; 
    
proc sort data=&inlib..&dsetalt. out=clusb (rename=(cluster=clusb));
    by county; 
run;
    
/*********************
    MERGING THEM TOGETHER
    ********************/
    
data clusmerged;
    merge clusa (in=a) clusb (in=b) ;
    by county ; 
    if a and b ; 
run;
            
proc sort data=clusmerged;
     by clusa ;
run;
            
data clusmerged ;
    merge clusmerged (in=a) master_count (in=m rename=(cluster=clusa)) ;
    by clusa;
    if a ;
run;
    
proc sort data=clusmerged;
    by clusb ; 
run;
    
data clusmerged;
    merge clusmerged (in=a) alternate_count (in=alt rename=(cluster=clusb)) ;
    by clusb ;
    if a ;
run; 
    /* qa check */    
                                   
   
/* ----------- LOOP OVER COUNTIES ------------*/    
    
%do ii = 1 %to 3141 ;
    data _NULL_ ;
        set clusmerged ; 
        if _N_ = &ii. then do ; 
            %put "Got into the loop on &ii. observation" ;
            put county clusa clusb ;    
            call symput('cty',county) ;
            call symput('clusa',clusa) ;
            call symput('clusb',clusb) ;
            call symput('counta',numctys_a) ;
            call symput('countb',numctys_b) ;
        end;
    run;
    
    data subset ; 
        set clusmerged ; 
        if clusa=&clusa. or clusb=&clusb. ;
    run;
            
    data divergence (keep=cty F_ixy clustera clusterb counta countb);
        set subset end=eof;
        /*if clusa=&clusa. or clusb = &clusb. ;*/
        retain counta countb ;
        if _N_=1 then do ;
            counta = 0 ;
            countb = 0 ; 
        end;
            
        if clusa = &clusa. then do ;
                  if cluscounta = counta+1 ;
        if clusb = &clusb. then countb = countb+1 ;
            
        if eof then do ;
            clustera = "&clusa." ;
            clusterb = "&clusb." ;
            *F_ixy = .5*((counta/%eval(&counta.))+(countb/%eval(&countb.))) ;
            cty = "&cty." ;
            output divergence ;
        end;    
    run;            
    
    /*appending to whole data*/
                    
        data county_divergence ;
            set divergence 
                %if &ii. > 1 %then %do;
                    county_divergence 
                %end;
                ;
         run;                   
%end ;     
    
/** ----------SUMMARIZING DIVERGENCE---------- **/
                        proc contents data=county_divergence ;
                            title 'checking formats';
                         run;
                        proc print data=county_divergence ;
                            title 'checking formats' ;
                        run;
            
proc sort data=county_divergence ;
    by clustera;
run;
    
data county_divergence ; 
    merge county_divergence (in=a rename=(clustera=clusa)) 
                master_count (rename=(cluster=clusa)) ; 
    by clusa;
    if a ;
run;
    
proc sort data=county_divergence ; 
    by clusterb ;
run;
    
data county_divergence ;
    merge county_divergence (in=a rename=(clusterb=clusb)) 
                 alternate_count (rename=(cluster=clusb));
    by clusb ; 
    F_ixy = .5*((counta/numctys_a)+(countb/numctys_b)) ;
run;
    
                
data county_divergence;
    set county_divergence ;
    stfip = substr(cty,1,2) ;  
run;
    
proc means data=county_divergence  mean p25 p50 p75;
    class stfip ;
    var F_ixy ;
run;
    
proc means data=county_divergence mean p25 p50 p75 ;
    var F_ixy ;
run;        
    
proc print data=county_divergence;
        title 'print of all counties outcomes';
run;
        
        
    
    
    
%if "&noprint."="YES" %then %do ;
    %put "ENTERING CLUSTER COMPARE " ;
    %printjunk ;
%end;   
    
%mend cluster_similarity ; 
    
