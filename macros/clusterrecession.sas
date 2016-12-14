%macro clusterrecession(startyr,endyr,cutoff,inlib=OUTPUTS,outlib=OUTPUTS) ;

%put "INSIDE CLUSTERRECESSION" ;
%do year = &startyr. %to &endyr. ;	
%put "INSIDE LOOP IN CLUSTER RECESSION for &year." ;
	%clusterlodes(&year.,inlib=&inlib.,outlib=WORK);
%put "AFTER CLUSTERLODES for &year." ;
	
	%review(lodes_&year.,&cutoff.,inlib=WORK,outlib=WORK); 
	
	%cluster_naming(lodes_&year.,inlib=WORK,outlib=WORK) ; 
	
	%clustermap_named(clustersnamed_lodes_&year.,mapyear=&year.,inlib=WORK,name=lodes_&year.,
			mappath=./paper/figures) ;
			
	data clustercount_&year. ;
		set clustercount ;
	run; 
%end; 

%do year = 2008 %to 2010 ;

%cluster_compare(lodes_2007,lodes_&year.,inlib=WORK,outlib=&outlib.);

data test_&year. ;
	merge &outlib..mismatch_share &outlib..mismatch_share_wgt
		&outlib..mismatch_total &outlib..sample_merged
		&outlib..master_merged clustercount_&year.;
	year = &year. ;
run; 

%end ; 
%do year = 2008 %to 2010 ; 

proc means data = test_&year. ;
	title "2007 and &year. comparisons" ;
	var total_samplemerged total_mastermerged share_mismatch
		share_mismatch_wgt total_mismatch ;
run ;

%end ;

data allcomp ;
	set test_2008 test_2009 test_2010 ;
run; 

proc print data = allcomp ;
	title 'Comparison with 2007 CZs over three following years';
run;  


%mend clusterrecession ;
