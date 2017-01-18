/* 
This module makes all the maps for the paper, including needed insets
*/

/* Commuting zone map */

%clustermap(cz1990,mapyear=1990,inlib=OUTPUTS,name=none,mapfile=cz1990_map,mappath=./paper/figures,imgformat=png) ;
    


/* Our replication map */
%review(jtw1990,0.9418) ;
    

%clustermap(clusfin_jtw1990,mapyear=1990,inlib=OUTPUTS,name=none,mapfile=1990_replicationmap,mappath=./paper/figures,imgformat=png) ;

/*Insets of those:
    Cascadia
    DMV
    Florida
*/
    
    
    
    
/*Spectral clustering outcome*/    

    
%clustermap(optimal_spectral_par,mapyear=1990,inlib=OUTPUTS,name=optimal_spectral_par, mapfile=optimal_spectral_par,mappath=./paper/figures) ;    
    
/*
    Insets of those:
    Cascadia
    DMV
    Florida
    */
