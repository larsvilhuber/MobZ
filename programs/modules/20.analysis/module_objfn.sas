*%objfn_prep ;


/* normalization factors */
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

/*****************
OBJECTIVE FUNCTION OF SPECTRAL
******************/                

data spectral ; 
    set OUTPUTS.optimal_spectral_par ;
run;

proc sort data=spectral ;
    by cluster;
run;
    
proc print data=spectral ;
    title 'spectral' ;
run;    
    
%objectivefunction(spectral,1990,inlib=WORK,outlib=WORK) ;  
    
proc print data=objectivefn;
    title 'spectral' ;
run;         
    data spectral_objfn; 
        set objectivefn;
        type = 'spectral' ;
    run;
        
/* CZ 1990 */
    
data cz1990 (keep=county cluster) ;
    set OUTPUTS.cz1990 ; 
    county = cty ; 
    cluster = input(cz1990,8.) ;
    if substr(county,1,2) not in ('02','15') ;
run;    
        


%objectivefunction(cz1990,1990,inlib=WORK,outlib=WORK) ;   
        
proc print data=objectivefn;
    title 'cz 1990 ' ;
run;        
    data commutingzones;
        set objectivefn;
        type= 'commuting zones' ;
    run;        
    
/* STATES */

data states (keep=county cluster);
    format cluster 5. ;
    set OUTPUTS.reslf_jtw1990 ;
    county=home_cty ;
    cluster = input(substr(home_cty,1,2),2.) ;
run;
/*
proc print data=states ;
    title 'states pre objective fn' ;
run;
  */  
%objectivefunction(states,1990,inlib=WORK,outlib=WORK) ;
        
proc print data=objectivefn;
    title 'states ' ;
run;    
    data states ;
        set objectivefn;
        type = 'states'  ;
    run;        

/* MSA AND REST OF STATE */

proc sort data = GEO.blk_xwalk_wide out=cbsa (keep=fipsstco cbsaid) nodupkey; 
    by fipsstco;
run;
	
proc freq data = cbsa ;
    table cbsaid ;
run;
	 
data clusters_msa; 
    set cbsa (rename=(fipsstco=county cbsaid=cluster)) ;
    *cluster = put(cluster_num,8.) ;
    if cluster=929 then cluster= substr(county,1,2)||'999'; /*Rest of state*/ 
run;    

%objectivefunction(clusters_msa,1990,inlib=WORK,outlib=WORK) ;
        
proc print data=objectivefn;
    title 'msa and rest of state ' ;
run;     
    
    data msa ;
        set objectivefn; 
        type = 'msa' ;
    run;

/* Counties as clusters */
    
data county (keep=county cluster) ;
    format cluster 5. ;
    set OUTPUTS.reslf_jtw1990 ;
    county = home_cty ;
    cluster = input(home_cty,5.) ;
run;
    
%objectivefunction(county,1990,inlib=WORK,outlib=WORK) ;
    
proc print data=objectivefn ;
    title 'counties as clusters' ;
run;
            
data countyoutcomes ;
    set objectivefn ;
    type = 'county' ;
run;
            
proc sort data = GEO.blk_xwalk_wide out=cbsa (keep=fipsstco cbsaid) nodupkey; 
    by fipsstco;
run;            


data onlymsa ;
    set cbsa (rename=(fipsstco=county cbsaid=cluster) where=(cluster ne 929)) ;            
run;/*only cbsa, not rest of state*/
    
%objectivefunction(onlymsa,1990,inlib=WORK,outlib=WORK) ;
    
    proc print data=objectivefn;
        title 'only msa' ;
    run;        
            
    data onlymsaoutcomes ;
            set objectivefn; 
            type = 'only msa' ;
    run;            
    

/************************
Setting them all together
************************/

data all_objfn;
    set spectral_objfn
        commutingzones
        states
        msa
        onlymsaoutcomes 
        countyoutcomes ;
    objfn_comm = (-share_inflows - share_outflows)/2 ; 
        /* just creating an objective function with commuting*/
run;
    
proc print data=all_objfn;
    title 'all LLM defns' ;
run;                

proc export data=all_objfn
        outfile='./outputs/objectivefn_outputs.dta' replace;
run;        
