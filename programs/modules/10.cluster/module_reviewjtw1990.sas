%review(jtw1990, 0.9365) ;

*proc print data= OUTPUTS.clusfin_jtw1990 ;
*run;
         

*%clustermap(clusfin_jtw1990,mapyear=1990,inlib=OUTPUTS,name=none,mapfile=1990_replicationmap,mappath=/programs/projects/mobz2/paper/figures,imgformat=png) ;

%clustermap(clusfin_jtw1990,mapyear=1990,inlib=OUTPUTS,name=none,mapfile=1990_replicationmap,mappath=/programs/projects/mobz2/paper/figures,imgformat=png) ;

%cluster_statistics(clusfin_jtw1990,inlib=OUTPUTS,outlib=OUTPUTS,matching=NO) ;

proc print data=statistics ;
run;  

proc freq data=OUTPUTS.clusfin_jtw1990 ;
    title 'clusters tabulation' ;
    tables cluster;
run;
