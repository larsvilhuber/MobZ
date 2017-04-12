%macro cutoff_objfn(dset,lowerbound,upperbound,step=1,diverg=NO);

/*====== calculating normalization factors ======*/
%randomcounties_norm(1990,noprint=NO);

data _NULL_ ;
	set random_objfn ; 
	call symput('inflows',rand_inflows);
	call symput('outflows',rand_outflows);
	call symput('sdurate',rand_corrurate);
	call symput('sdearn',rand_correarn); 
run;
        
proc print data=random_objfn; 
    title 'random objective function';
run;      

         
                        
%let lower = %sysevalf(&lowerbound.*10000) ;
%let upper = %sysevalf(&upperbound.*10000) ;

%do cutoff = &lower. %to &upper. %by &step. ; 
    %let cutoffcorr = %sysevalf(&cutoff./10000) ;
    
    /************
    This loop calls the review
    macro, and then calculates the
    objective function.
    ***************/    

    %review(&dset.,&cutoffcorr.,inlib=OUTPUTS,outlib=WORK,noprint=YES) ;

    data _NULL_ ;
        set clustercount ;
        call symput('clusnum',numclusters) ;
    run;
    
    %objectivefunction(clusfin_&dset.,1990,inlib=WORK,outlib=WORK) ;
    data objectivefn;
        set objectivefn; 
        cutoff=&cutoffcorr. ;
        clusnum = &clusnum. ; 
    run;
        
    data cutoff_objfn ;
        set objectivefn 
            %if %eval(&cutoff.>&lower.) %then %do ;
                cutoff_objfn 
            %end;
            ;
    run;
              
%end;  

proc sort data=cutoff_objfn ;
    by cutoff ; 
run;
    
proc export data=cutoff_objfn
        outfile='./outputs/objfn_cutoff.dta' replace;
run;    


%mend cutoff_objfn; 

%cutoff_objfn(jtw1990,0.9,0.97,step=5) ; 
