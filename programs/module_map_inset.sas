%include "config.sas" ;
%macro inset ; 

%do ii = 800 %to 1000 %by 80

%let cutoff = &ii./1000 ;

%review(jtw1990, &cutoff.) ;

proc contents data=OUTPUTS.clusfin_jtw1990 ; 
run; 

proc print data=OUTPUTS.clusfin_jtw1990 (obs=30) ;
run; 

%clustermap_subset(clusfin_jtw1990,state=6,inlib=OUTPUTS,name=california,mapfile=california_clustermap_&ii.,mappath=&mappath.,imgformat=png) ;

%end; /* --- end of loop */

%review(jtw1990,1) ;

%clustermap_subset(clusfin_jtw1990,state=6,inlib=OUTPUTS,name=california,mapfile=california_clustermap_1000,mappath=&mappath.,imgformat=png);

%mend inset ; 

%inset;



