
%macro inset ; 

%do ii = 800 %to 1000 %by 20

%let cutoff = &ii./1000 ;

%review(jtw1990, &cutoff.) ;

proc contents data=OUTPUTS.clusfin_jtw1990 ; 
run; 

proc print data=OUTPUTS.clusfin_jtw1990 (obs=30) ;
run; 

%clustermap_subset(clusfin_jtw1990,state=6,inlib=OUTPUTS,name=california,mapfile=california_clustermap_&ii.,mappath=./maps/,imgformat=png) ;

%end; /* --- end of loop */

%mend inset ; 

*%inset;

*%review(jtw1990,0.94,inlib=OUTPUTS,outlib=WORK) ;

*%clustermap_subset(clusfin_jtw1990,state=6,inlib=WORK,name=california,mapfile=testmap,mappath=./maps/,imgformat=png) ;


/***********************
making insets of TX and CA of optimal spectral and CZ1990
***********************/
/*ca*/
%clustermap_subset(optimal_spectral_par,state=6,inlib=OUTPUTS,name=none,mapfile=cali_spec,mappath=./paper/figures/insetmaps,imgformat=png) ;
                                                                                        
                                                                                        
/*tx*/                                                                                        

%clustermap_subset(optimal_spectral_par,state=48,inlib=OUTPUTS,name=none,mapfile=tex_spec,mappath=./paper/figures/insetmaps,imgformat=png) ;

/*cz1990*/
data commutingzones (keep=cluster county);
    set OUTPUTS.cz1990 (rename=(cty=county)) ;
    
    cluster = input(cz1990,8.) ;
run;                                                                                
/*ca*/                                                                                        
%clustermap_subset(commutingzones,state=6,inlib=WORK,name=none,mapfile=cali_cz,mappath=./paper/figures/insetmaps,imgformat=png) ;
                                                                                        
                                                                                        
/*tx*/                                                                                        

%clustermap_subset(commutingzones,state=48,inlib=WORK,name=none,mapfile=tex_cz,mappath=./paper/figures/insetmaps,imgformat=png) ;
