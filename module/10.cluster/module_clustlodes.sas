*%cluster(lodes);

%clusterlodes(2012);
%review(lodes_2012,0.92) ;
%cluster_statistics(lodes_2012) ;

proc print data = statistics ;
	title 'Statistics for LODES 2012';
	var mean_clussize median_clussize numclusters ;
run; 
