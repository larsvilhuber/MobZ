/* This macro creates a bunch of definitions of commuting zones, based on
where the cutoff is (for use in estimation)
These are then merged together 
*/



%macro cutoff(dset,lowerbound,upperbound,step=1,diverg=NO) ;

%let lower = %sysevalf(&lowerbound.*10000);
%let upper = %sysevalf(&upperbound.*10000); 

%put "*****************************************";
%put "STARTED AT &systime. ";
%put "******************************************";

%geoagg(&dset.,inlib=OUTPUTS,outlib=WORK);
%cluster(&dset.,inlib=WORK,outlib=WORK);
%review(&dset.,0.9385,inlib=WORK,outlib=WORK);   
%cluster_naming(clusfin_&dset.,clusnamed_master,reslf_&dset.,inlib=WORK,outlib=WORK,otherlib=WORK) ;
        
        %cluster_compare(clusnamed_master,clusnamed_master,reslf_&dset.,inlib=WORK,outlib=WORK,noprint=NO,mlib=WORK) ;
        %cluster_statistics(clusfin_&dset.,inlib=WORK,outlib=WORK) ;    

proc print data=statistics ;
    title 'statistics' ; 
run;
    
%do cutoff = 	&lower. %to &upper. %by &step. ;
	%let cutoff_corr = %sysevalf(&cutoff/10000);

	/******************
	This loop calls two macros,
	%review and %divergence
	for each cutoff value

	I then store the outputs:
	- Similarity for CZ and CLUSTER
	- Average cluster size
	- Median cluster size
	******************/

	%review(&dset.,&cutoff_corr.,inlib=WORK,outlib=WORK,noprint=YES) ;
        
        data clust_cut (keep=county clus&cutoff) clus_num (keep=cutoff clus&cutoff. )
             clusnm (keep=county clus&cutoff. rename=(clus&cutoff.=cluster));
            set clusfin_&dset. (rename=(_PARENT_ = clus&cutoff.)) ;
            county = substr(_NAME_,4,5) ;
            
            output clust_cut clus_num clusnm; 
        run;
        %cluster_naming(clusnm,clusname_&cutoff.,reslf_&dset.,inlib=WORK,outlib=WORK,otherlib=WORK) ;
        %cluster_compare(clusname_&cutoff.,clusnamed_master,reslf_&dset.,inlib=WORK,outlib=WORK,noprint=NO,mlib=WORK) ;
        %cluster_statistics(clusfin_&dset.,inlib=WORK,outlib=WORK) ;

        data clus_obj ;
            set clusname_&cutoff. (rename=(clustername=cluster)) ;
        run;
        %commutingflows(clus_obj,1990,inlib=WORK,outlib=WORK) ;
        proc sort data=clust_cut ; 
            by county; 
        run;
            
        proc sort data=clus_num nodupkey ;
            by clus&cutoff ; 
        run;
            
        data clus_num (keep=cutoff clusnum);
            retain clusnum ;
            set clus_num  end = eof;
            if _N_ = 1 then clusnum = 0 ; 
            clusnum = clusnum + 1 ;         
            if eof then do ; 
                cutoff = &cutoff. ;
                output ;
            end; 
        run;
        
        data clus_num ; 
            merge clus_num statistics objectivefn ;
        run;
                                        
        %if %eval(&cutoff.=&lower.) %then %do ;
            data clus ;
                set clust_cut ;
            run;               
            
            data clusnum_cutoff ;
                set clus_num ; 
            run;
        %end; 
                
        %else %do ;
            data clus ;
                merge clus clust_cut ;
                by county; 
            run; 
                
            data clusnum_cutoff ;
                set clusnum_cutoff clus_num;
            run;
        %end; 
%end;         

proc print data= clus (obs = 50) ;
run;                


proc sort data=clus out=OUTPUTS.cluster_cutoff_&dset. (rename=(county=fips)) ;
    by county ; 
run;                



%mend cutoff;

                
%cutoff(jtw1990,0.90,0.97,step=5 ) ;               

proc export data=OUTPUTS.cluster_cutoff_jtw1990 
            outfile = '[outdir]/clusters_cutoff_jtw1990.dta' replace; 
run;

    
proc export data=clusnum_cutoff 
            outfile = '[outdir]/clusnum_cutoff.dta' replace; 
run;                    
    
proc print data=clusnum_cutoff;
run;
