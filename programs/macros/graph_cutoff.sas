%macro graph_cutoff(dset,lowerbound,upperbound);



%let lower = %sysevalf(&lowerbound.*10000);
%let upper = %sysevalf(&upperbound.*10000); 

%put "*****************************************";
%put "STARTED AT &systime. ";
%put "******************************************";

%do cutoff = 	&lower. %to &upper. %by 1 ;
	%let cutoff_corr = %sysevalf(&cutoff/10000);

	/******************
	This loop calls two macros,
	%review and %divergence
	for each cutoff value

	I then store the outputs:
	- Similarity for CZ and CLUSTER
	- Average cluster size
	- Median cluster size
	******************/

	%review(&dset.,&cutoff_corr.,inlib=OUTPUTS,outlib=OUTPUTS,noprint=YES) ;

	/* This pulls the relevant numbers from each set */
	data _NULL_ ;
		set mean_clussize;
		call symput('mean',mean_clussize);
	run;

	data _NULL_;
		set median_clussize ;
		call symput('median',median_clussize);
	run;
	
	data _NULL_ ;
		set clustercount ;
		call symput('count',numclusters) ;
	run; 

			
	%divergence(&dset.,1990,noprint=YES);

	data _NULL_;
		set czmatch; 
		call symput('comzone',similarity_czmatch);
	run;
	
	data graph;
		merge mean_clussize median_clussize clustercount czmatch clusmatch ;
		cutoff= &cutoff_corr.;
	run; 
	
	%if %eval(&cutoff. = &lower.) %then %do;

		data graph_fin; 
			set graph ;
		run;
	%end;
	%else %do ;
		data graph_fin;
			set graph_fin graph; 
		run; 
	%end; 
%end;

data graph ; 
	set graph_fin ;
	label 
		cutoff="Cluster Height Cutoff"
		*similarity_clusmatch = "Cluster Similarity"
		*similarity_czmatch = "CZ Similarity"
		median_clussize = "Median Cluster Size" 
		mean_clussize = "Mean Cluster Size" 
		clusters = "Number of Clusters" ;
run; 

proc print data = graph; 
run; 

%let endtime=&systime.;
%put "*****************************************";
%put "ENDED at &endtime";
%put "******************************************";

*%let graphpath = ./graphs ;
%let graphpath = ./paper/figures ;


goptions reset= all device=png gsfname = "&graphpath./similarity_&dset..png" xpixels=1600 ypixels=800;
filename gout "&graphpath./similarity_&dset..png" ;

proc sgplot data = graph nocycleattrs;
	series 	x =cutoff y = similarity_clusmatch 	/lineattrs =(color=blue);
	series x = cutoff y = similarity_czmatch 	/lineattrs =(color=red);		
run;



ods graphics on /imagefmt=png imagename = "clustersize_&dset." ;
ods listing gpath = "./graphs" ;

proc sgplot data = graph nocycleattrs;
	series 	x =cutoff y = median_clussize 	/lineattrs =(color=blue);
	series x = cutoff y = mean_clussize 	/lineattrs =(color=red);
run; 

ods graphics on /imagefmt=png imagename = "numclusters_cutoff_&dset." ;
ods listing gpath = "./graphs" ;


proc sgplot data = graph nocycleattrs;
	series x = cutoff y = numclusters /lineattrs=(color=blue) ;
run;

*ods close ;

%mend graph_cutoff;

