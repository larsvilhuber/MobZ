%macro cluster_statistics(infile,inlib=OUTPUTS,outlib = OUTPUTS,matching=YES) ;

data numclus ;
	set &outlib..&infile. ;
	x = 1 ;
run; 

proc summary data = numclus nway; 
	class cluster ;
	output out = clussize 	N(x) = numcounties ; 
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
	output out = mean_clussize mean(numcounties)=mean_clussize ; 
run; 	

proc summary data = clussize ;
	var numcounties ;
	output out = median_clussize median(numcounties)=median_clussize ;
run;

proc summary data = clussize ;
	var numcounties ;
	output out = numclusters N(numcounties)=numclusters ;
run; 

data statistics ;
	merge mean_clussize median_clussize numclusters 
		%if matching="YES" %then %do ; 
                &inlib..mismatch_share 
		&inlib..mismatch_total 
		&inlib..mismatch_share_wgt
		&inlib..sample_merged
		&inlib..master_merged
                %end ; 
		;
run; 

proc datasets ;
	delete clussize mean_clussize median_clussize numclusters ; 
run ;

%mend cluster_statistics ;
