%review(jtw1990,0.9385) ;

proc contents data=OUTPUTS.clustersfinished_jtw1990;
    title 'contents of finished clusters jtw1990' ;
run;

%clustermap(clusfin_jtw1990,mapyear=x,inlib=OUTPUTS,name=replication,mapfile=clustermap_jtw1990,mappath=[mappath],imgformat=png) ;


%clustermap(clusfin_jtw1990,mapyear=x,inlib=OUTPUTS,name=replication,mapfile=clustermap_jtw1990,mappath=[mappath],imgformat=pdf) ;

proc print data=OUTPUTS.clusfin_jtw1990 ; 
run;
