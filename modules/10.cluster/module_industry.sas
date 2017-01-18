%preplodes_ind(all,2012,inlib=OUTPUTS,outlib=WORK) ;

%cluster_ind(all,2012,inlib=WORK,outlib=WORK) ;

%review_ind(all,2012,0.92,inlib=WORK,outlib=OUTPUTS) ;

/*********************************
This was added in order to get table
for paper
*********************************/
%cluster_statistics(lodes_2012_ind1,inlib=OUTPUTS,outlib=OUTPUTS) ;

proc print data = statistics ;
	title 'Statistics for Goods Producing';
	var mean_clussize median_clussize numclusters ;
run; 

%cluster_statistics(lodes_2012_ind2,inlib=OUTPUTS,outlib=OUTPUTS) ;

proc print data = statistics ;
	title 'Statistics for TTU';
	var mean_clussize median_clussize numclusters ;
run; 

%cluster_statistics(lodes_2012_ind3,inlib=OUTPUTS,outlib=OUTPUTS) ;

proc print data = statistics ;
	title 'Statistics for All Other Services';
	var mean_clussize median_clussize numclusters ;
run; 
