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

	%review(&dset.,&cutoff_corr.,inlib=OUTPUTS,outlib=WORK,noprint=YES) ;

        data clust_cut (keep=county clus&cutoff) ;
            set clustersfinished_&dset. (rename=(_PARENT_ = clus&cutoff.)) ;
            county = substr(_NAME_,4,5) ;
        run;
                
        proc sort data=clust_cut ; 
            by county; 
        run;                                                        
        
        %if %eval(&cutoff.=&lower.) %then %do ;
            data clus ;
                set clust_cut ;
            run;               
        %end; 
                
        %else %do ;
            data clus ;
                merge clus clust_cut ;
                by county; 
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
            outfile = './outputs/clusters_cutoff_jtw1990.dta' replace; 
run;
