%macro bootstrap_spectral(dset,iterations,minclus,maxclus,parallel=NO) ;

/*******
First get the optimal clusters (or load in saved clusters) 
***********/
    %prepspectral(infile=clustermatrix_&dset.,outfile=specclus_&dset.,
                 indir=OUTPUTS,outdir=WORK);
%if "&parallel." = "NO" %then %do ;                 
    %optimal_spectral(infile=specclus_&dset.,outfile=results,
                            minclus=&minclus,maxclus=&maxclus.,
                            indir=WORK,outdir=WORK,random=NO,noprint=YES) ;
%end ; 
%else %if "&parallel."="YES" %then %do ; 
    %optimal_spectralparallel(infile=specclus_&dset.,outfile=results,
                            minclus=&minclus,maxclus=&maxclus.,
                            indir=WORK,outdir=WORK,random=NO,noprint=NO) ;
%end;  
    %cluster_naming(results,results_named,reslf,inlib=WORK,outlib=WORK,
                    otherlib=WORK) ;


/****----------- BOOTSTRAP LOOP -----------***/

%do ii = 1 %to &iterations. ;

    /*perturb the flows*/
    %perturb_alt(jtw1990_moe,&ii.,inlib=OUTPUTS,outlib=WORK) ;
    
    /*create the clustering matrix*/
    %geoagg_spectral(flows_jtw1990_moe_p&ii.,clusmat,inlib=WORK,outlib=WORK) ;
    
    %prepspectral(infile=clusmat,outfile=specclus_&ii.,indir=WORK,
                outdir=WORK);
    %if "&parallel." = "NO" %then %do ; 
        %optimal_spectral(infile=specclus_&ii.,outfile=results_&ii.,
                            minclus=&minclus,maxclus=&maxclus.,
                            indir=WORK,outdir=WORK,random=NO,noprint=NO) ;
    %end ; 
    %else %if "&parallel." = "YES" %then  %do ;
        %optimal_spectralparallel(infile=specclus_&ii.,outfile=results_&ii.,
                            minclus=&minclus,maxclus=&maxclus.,
                            indir=WORK,outdir=WORK,random=NO,noprint=YES) ;
    %end;  
/*
        proc print data=results_&ii. ;
            title "optimal clusters for iteration &ii." ;
        run;
            
        proc freq data=results_&ii. ;
            title "tabulation of clusters for iteration &ii." ;
            table cluster ;
        run;
*/
    %cluster_naming(results_&ii.,results_&ii._named,reslf,inlib=WORK,
                        outlib=WORK,otherlib=WORK) ;
    %cluster_compare(results_named,results_&ii._named, reslf,inlib=WORK,outlib=WORK,
                                      noprint=NO,mlib=WORK,spectral=YES) ;
                                                        
    %cluster_statistics(results_&ii.,inlib=WORK,outlib=WORK) ;
    
    data statistics;
        set statistics ;
        iteration = &ii. ;
    run;
    %if %eval(&ii.=1) %then %do ; 
         data OUTPUTS.finalstats_spectral ;
                set statistics; 
         run;
    %end; 
    %else %do ;                 
    proc append base= OUTPUTS.finalstats_spectral data=statistics ; 
    run; 
    %end;
%end;

                
/* HERE, I should print out the final stats, and also
         merge together all of the realized clusters for future analysis*/  

proc print data=OUTPUTS.finalstats_spectral ;
    title 'final stats spectral' ; 
run;              
    
data OUTPUTS.spec_iterations_clusters ;
     merge %do ii = 1 %to &iterations. ;
        results_&ii. (rename=(cluster=cluster_&ii.))
        
        %end; 
        ;
     by county; 
run;
    
                
%mend bootstrap_spectral ;

        %bootstrap_spectral(jtw1990,1000,500,800,parallel=YES) ;
