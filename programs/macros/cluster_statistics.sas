%macro cluster_statistics(infile,inlib=OUTPUTS,outlib = OUTPUTS,matching=YES) ;

data numclus ;
	set &outlib..&infile. ;
	x = 1 ;
run; 

proc summary data = numclus nway; 
	class cluster ;
	output out = clussize 	sum(x) = numcounties ; 
run;


/************************
CLUSTER STATISTICS:

MEAN
MEDIAN
NUMBER OF CLUSTERS
SHARE AND TOTAL MISMATCH
************************/

proc summary data=  clussize ; 
	var numcounties ;
	output out = clus_stat mean(numcounties)=mean_clussize 
                               median(numcounties) = median_clussize 
                               N(numcounties) = numclusters
                               std(numcounties) = sd_clussize; 
run; 	


data statistics ;
	merge clus_stat
		
                &inlib..mismatch_share 
		&inlib..mismatch_total 
		&inlib..mismatch_share_wgt
		&inlib..sample_merged
		&inlib..master_merged
                 
		;
run; 

proc datasets ;
	delete clussize mean_clussize median_clussize numclusters ; 
run ;

%mend cluster_statistics ;
