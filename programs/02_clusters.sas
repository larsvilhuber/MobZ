* Mobility Zones (MobZ);
* Execute control program to run selected modules;	
options  mlogic symbolgen spool fullstimer;
* Modules, set to 1 to run, otherwise 0;	

%include(config.sas) ;

/******************************
  Runs the average-distance clustering
  algorithm   

Creates two files: 
            clustermatrix_&dset.
            clustertree_&dset. (output from clustering clustermatrix)
********************************/               

%let run_clustjtw1990=1;
%let run_clustjtw2009=0;
            
/*****************************
     Takes the &cutoff, and clustertree_&dset.,
     and outputs the clusters
     (as clusfin_&dset.)
******************************/            

%let run_reviewjtw1990=1;
%let run_reviewjtw2009=0;  

* Cluster threshold;
%let cutoff=0.9418 ; /*national cutoff for their way*/
*%let cutoff=0.98 ; 

/*Eventually, do a cutoff specific to each year*/
%let cutoff_jtw1990 =0.9418 ;
%let cutoff_jtw2000 = 0.98 ; 
%let cutoff_jtw2009 = 0.96 ;


/*-----------------------------------------------------------
  Structure of this program
  - the macro %runall will do a bit of config, and run module macros
  - module macros are in the second part of the file
  - the actual calls are at the end
  - some macros that actually do stuff are in the &dirprog/macros directory
-------------------------------------------------------------*/

/* Overall Macro */

* Modules;
%macro runmod(val,modname);/*========================================*/
%put module &modname.;
%let logdir=&dirprog./logs;

%if (&val.=1) %then %do;
x mkdir -p &logdir.;
proc printto
    log="&logdir./module_&modname..log" new
    print="&logdir./module_&modname..lst" new;
run;

/* run the module */
%&modname.;	
	
%end;
%mend runmod; /*========================================*/


/* individual modules */

%macro reviewjtw1990;

    %review(jtw1990, 0.9385,inlib=OUTPUTS,outlib=WORK) ;
    
    *proc print data= OUTPUTS.clusfin_jtw1990 ;
    *run;
    
    data cz1990 (rename=(cty = county cz1990 = cluster )) ;
        set OUTPUTS.cz1990 ;
    run;
        
    data reslf ; 
        set OUTPUTS.reslf_jtw1990 ;
    run;
             
    %cluster_naming(cz1990,cz1990_named,reslf_jtw1990,inlib=WORK,outlib=WORK,otherlib=OUTPUTS) ;
    
    %cluster_naming(clusfin_jtw1990,clusnamed_jtw1990,reslf_jtw1990,inlib=OUTPUTS,outlib=WORK,otherlib=OUTPUTS) ;
    
    %cluster_compare(clusnamed_jtw1990,cz1990_named,reslf,inlib=WORK,outlib=WORK,noprint=NO,mlib=WORK)
    
    %clustermap(clusfin_jtw1990,mapyear=1990,inlib=OUTPUTS,name=none,mapfile=1990_replicationmap,mappath=/programs/projects/mobz2/paper/figures,imgformat=png) ;
    
    %cluster_statistics(clusfin_jtw1990,inlib=OUTPUTS,outlib=OUTPUTS,matching=YES) ;
    
    proc print data=statistics ;
        title 'statistics replication' ; 
    run;  
    
    %commutingflows(clusfin_jtw1990,1990,inlib=WORK,outlib=WORK);
    
    proc print data=objectivefn ;
    run;
    
    %cluster_statistics(cz1990,inlib=WORK,outlib=WORK,matching=YES) ;
    
    proc print data=statistics ; 
       title 'statistics - ts1990' ; 
    run;
    
    %commutingflows(cz1990,1990,inlib=WORK,outlib=WORK);
    
    proc print data=objectivefn ;
    run;
    
    proc freq data=OUTPUTS.clusfin_jtw1990 ;
        title 'clusters tabulation' ;
        tables cluster;
    run;

%mend;

* run each module ;

%runmod(&run_clustjtw1990, cluster );  /* defaults to jtw1990 */
%runmod(&run_reviewjtw1990., reviewjtw1990) ;

