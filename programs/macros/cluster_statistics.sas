%macro cluster_statistics(infile,inlib=OUTPUTS,worklib = WORK,matching=YES) ;

data numclus ;
	set &inlib..&infile. ;
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
		
                &worklib..mismatch_share 
		&worklib..mismatch_total 
		&worklib..mismatch_share_wgt
		&worklib..sample_merged
		&worklib..master_merged
                 
		;
run; 

proc datasets ;
	delete clussize mean_clussize median_clussize numclusters ; 
run ;

%mend cluster_statistics ;
