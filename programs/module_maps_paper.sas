/* 
This module makes all the maps for the paper, including needed insets
*/
%include "config.sas";    


/* Our replication map */
%review(jtw1990,0.945) ;
    

%clustermap(clusfin_jtw1990,mapyear=1990,inlib=OUTPUTS,name=none,mapfile=jtw1990_highcutoff,mappath=&mappath.,imgformat=png,CZ=NO) ;


