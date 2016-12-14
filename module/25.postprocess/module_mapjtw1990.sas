%review(jtw1990,0.92) ;

proc contents data=OUTPUTS.clustersfinished_jtw1990;
    title 'contents of finished clusters jtw1990' ;
run;

%clustermap(clusfin_jtw1990,mapyear=x,inlib=OUTPUTS,name=replication,mapfile=clustermap_jtw1990,mappath=./paper/figures,imgformat=png) ;
