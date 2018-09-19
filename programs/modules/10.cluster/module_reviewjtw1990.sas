
%geoagg(jtw1990,inlib=OUTPUTS,outlib=WORK);
%cluster(jtw1990,inlib=WORK,outlib=WORK);
%review(jtw1990, 0.9385,inlib=WORK,outlib=WORK) ;

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

*%clustermap(clusfin_jtw1990,mapyear=1990,inlib=OUTPUTS,name=none,mapfile=1990_replicationmap,mappath=/programs/projects/mobz2/paper/figures,imgformat=png) ;

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



