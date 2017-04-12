* Mobility Zones (MobZ);
* Execute control program to run selected modules;	
options  mlogic symbolgen spool fullstimer;
* Modules, set to 1 to run, otherwise 0;	

    /******************************
Runs the average-distance clustering
algorithm   

Creates two files: 
            clustermatrix_&dset.
            clustertree_&dset. (output from clustering clustermatrix)
********************************/               

%let run_clustlodes=0;
%let run_clustjtw1990=0;
%let run_clustjtw2000=0;	
%let run_clustjtw2009=0;
            
/*****************************
     Takes the &cutoff, and clustertree_&dset.,
     and outputs the clusters
     (as clusfin_&dset.)
******************************/            

%let run_reviewlodes  =0;
%let run_reviewjtw1990=0;
%let run_reviewjtw2000=0;
%let run_reviewjtw2009=0;  

/*******************************
SPECTRAL CLUSTERING
********************************/

%let run_spectral = 0 ;         
%let run_optimalspectral = 0; 
%let run_optimalspectral_parallel = 1;

/* ALSO, THESE DO CLUSTERING AT REGIONAL LEVEL - NO LONGER USED 
            ALSO REGIONREVIEW DOES SAME AS REVIEW ABOVE*/            
%let run_regclustjtw1990 = 0;
%let run_regclustjtw2000 = 0 ;
%let run_regclustjtw2009 = 0 ; 
%let run_regclustlodes = 0 ;               

%let run_regionreviewjtw1990 = 0;  
            
/* ALTERNATE METHODOLOGY: FAST CLUS (k-means) or FAST CLUS SEEDS */
%let run_fastclus = 0; 
%let run_fastclusseeds = 0;            
     /* not used anymore*/
%let run_alternateclusters = 0 ;
            
/*************** 
 RECESSION DIFFERENCES 
1. %preprecession and
2. %clusterrecession 
***************************/            
%let run_recession =0;
/************************
RUNS DIFFERENCES BY INDUSTRY
**************************/            
%let run_industry = 0  ;
            
            
/* TEST OF k-means with playdataset*/            
%let run_test = 0;          

*LODES ;
* job type;
%let jt=00;
* year ; 
%let year=2008;

* Cluster threshold;
%let cutoff=0.9418 ; /*national cutoff for their way*/
*%let cutoff=0.98 ; 

/*Eventually, do a cutoff specific to each year*/
%let cutoff_jtw1990 =0.9418 ;
%let cutoff_jtw2000 = 0.98 ; 
%let cutoff_jtw2009 = 0.96 ;
%let cutoff_lodes = 0.98 ;	

* Paths;
%let dirprog=.;
%let dirdata=.;
libname OUTPUTS "&dirdata./outputs";
libname LODES "&dirdata./lodes" access=readonly;
libname GEO "&dirdata./geo" ;
options sasautos="&dirprog./macros" mautosource nocenter ps=1000
        sascmd='sas' autosignon;

%global tstamp;
%let t=%sysfunc(today());
%let tt=%sysfunc(time());
%let dstamp=%trim(%sysfunc(year(&t.),z4.))%trim(%sysfunc(month(&t.),z2.))%trim(%sysfunc(day(&t.),z2.));
%let tstamp=&dstamp._%trim(%sysfunc(hour(&tt.),z2.))%trim(%sysfunc(minute(&tt.),z2.))%trim(%sysfunc(second(&tt.),z2.));

/* Overall Macro */
%macro runall;

* Modules;
%macro runmod(val,modname);
%put module &modname.;
%if (&val.=1) %then %do;
proc printto
    log="&dirprog./loglst/module_&modname..log" new
    print="&dirprog./loglst/module_&modname..lst" new;
run;
%include "&dirprog./modules/10.cluster/module_&modname..sas";			
proc printto
    log="&dirprog./ctrl_mobz.log" new
    print="&dirprog./ctrl_mobz.lst" new;
run;
%end;
%mend runmod;

* Create one for each module;

%runmod(&run_clustlodes.,clustlodes) ;
%runmod(&run_clustjtw1990.,clustjtw1990) ;
%runmod(&run_clustjtw2000.,clustjtw2000) ;
%runmod(&run_clustjtw2009.,clustjtw2009) ;


%runmod(&run_reviewlodes.,   reviewlodes);
%runmod(&run_reviewjtw1990., reviewjtw1990) ;
%runmod(&run_reviewjtw2000., reviewjtw2000);
%runmod(&run_reviewjtw2009., reviewjtw2009); 

%runmod(&run_regclustjtw1990.,regclustjtw1990) ;
%runmod(&run_regclustjtw2000.,regclustjtw2000) ;
%runmod(&run_regclustjtw2009.,regclustjtw2009) ;
%runmod(&run_regclustlodes.,regclustlodes) ;

%runmod(&run_regionreviewjtw1990., regionreviewjtw1990) ;

%runmod(&run_alternateclusters., alternateclusters); 

%runmod(&run_fastclus.,fastclus) ;	

%runmod(&run_fastclusseeds.,fastclusseeds) ;

%runmod(&run_industry.,industry) ;


%runmod(&run_spectral.,spectral) ;	
%runmod(&run_optimalspectral.,optimalspectral) ;
%runmod(&run_optimalspectral_parallel.,optimalspectral_parallel) ;


%mend runall;
* run all;
%runall;
