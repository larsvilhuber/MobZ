* Post-processing clustering output ;
%macro review_ind(range,year,cutoff,inlib=OUTPUTS,outlib=OUTPUTS) ;

%if "&range." = "all" %then %do ;
	%let start = 1 ;
	%let end = 3 ; 
%end ; 
%else %do ;
	%let start = &range. ; 
	%let end = &range. ; 
%end ;

********************************** ;
%do ind = &start. %to &end. ; 
********************************** ; 
%PUT "************** CREATING CLUSTERS FOR &ind. and &year. ******************" ;

proc contents data = &inlib..clustertree_&year._ind&ind. ;
run; 

proc sort data = &inlib..clustertree_&year._ind&ind. out=clustertree; 
	by _HEIGHT_ ;
run ; 

data ctydata (keep = _NAME_ _PARENT_ _PARENTOLD_)
	clusterdata (keep = _PARENT_ _GRANDPA_ )
	cutclusters (keep = _GRANDPA_ _GRANDPAPPY_)
	clusterheight (keep = _NAME_ _HEIGHT_ rename =(_NAME_=_PARENT_));

	
	set clustertree	;
	
	if substr(_NAME_,1,2) ne "CL" then do;
		_PARENTOLD_ = _PARENT_ ;
		output ctydata ; /*Bottom of tree */
	end; 
	else do ;
		if (_HEIGHT_ > &cutoff.) then do ; 
			_GRANDPA_ = _NAME_ ;
			_GRANDPAPPY_ = '' ;	
			output cutclusters ; /* Outputting ineligible clusters */
		end ; 	
		else do ; 
			_GRANDPA_=_PARENT_;
			_PARENT_=_NAME_ ;
			output clusterdata ; /* Outputting clusters */
		end ; 
	end ;
	if (_HEIGHT_<=&cutoff.) then output clusterheight ;
run ; 


proc sort data = cutclusters ; 
	by _GRANDPA_ ;
run ; 

proc sort data = clusterdata ;
	by _GRANDPA_ ;
run ; 
/* QA CODE*/
/*
proc print data = cutclusters ; 
run ; 

proc print data = clusterdata ;
run ; 
*/
data clusterdata (keep = _PARENT_ _GRANDPA_) ; 
	merge clusterdata (in=clus) cutclusters (in=cut) ;
	by _GRANDPA_ ;
	if _GRANDPAPPY_ = '' and cut then _GRANDPA_ = '' ; 
run ; 

proc sort data = clusterdata ;
	by _PARENT_ ;
run ;	

%let pointbreak = 0 ; 
%let circuitbreaker=  0 ;
%let mein = 0 ; 

/* ==================
Initializing the 
nrows macros, in 
order to make sure 
the loop doesn't run
forever.
===================*/
%let nrows = 0 ;
%let nrows_lag = 1 ; 
%let nrows_lag2 = 2 ; 


%do %while (&pointbreak.=0 and &circuitbreaker. < 1000 ) ; 
	%let circuitbreaker = %eval(&circuitbreaker. + 1) ;
	%put "Start of Geneology loop while mein=&mein., pointbreak=&pointbreak., and circuitbreaker=&circuitbreaker.";
	
	proc sort data = ctydata ; 
		by _PARENT_ ;
	run ; 
	
	data ctydata (keep = _NAME_ _PARENT_ /*_PARENTOLD_*/)
		ctydata_finished (keep= _NAME_ _PARENT_) ;

		merge ctydata (in=incty) clusterdata (in=inclus) ;
		by _PARENT_ ; 
			if incty then do ;
				if _GRANDPA_ ne '' then do ; 
					*_PARENTOLD_ = _PARENT_;
					_PARENT_ = _GRANDPA_ ;
					output ctydata ;
				end;
				else do ;
					*_PARENT_ = _PARENTOLD_ ;
					output ctydata_finished ; 
				end;  
			end; 
	run ;
	%if %eval(&circuitbreaker.=1) %then %do ;
		data clustersfinished ;
			set ctydata_finished;
		run;
	%end; 
	%else %do;
		proc append base=clustersfinished data=ctydata_finished;
		run;
	%end;
	
	/*Deciding whether to stay in loop*/
	data _NULL_ ;
		set ctydata nobs = n ; 
		call symput('nrows',n);
		stop;
	run ; 

	%put "&nrows." ;

	%if %eval(&nrows.) = 0 %then %do ;
		/* If there are no observations in the CTYDATA, we are done */
		/* Also if the same number of rows are stuck a number of times, we are done */	
		%let pointbreak = 1 ; 
		%put "POINT BREAK" ; 
	%end ; 
	
	/* If getting kicked out of loop because a few rows are singletons, need to append them */
	
	%if (%eval(&nrows.) =  %eval(&nrows_lag.) and  %eval(&nrows_lag2.) =  %eval(&nrows_lag.)) %then %do ; 
		data ctydata (keep = _NAME_ _PARENT_);
			set ctydata ;
		run ;
		
		proc append base = clustersfinished data = ctydata ; 
		run ; 
		%let pointbreak = 1 ; 
	%end ; 


	%let nrows_lag2 = &nrows_lag. ;
	%let nrows_lag = &nrows. ; 
	%put "=================================================================================" ;
	%put "END of Geneology loop while mein=&mein., pointbreak=&pointbreak., and circuitbreaker=&circuitbreaker.";
	%put "=================================================================================" ;

	
%end ; 

proc sort data = clustersfinished;
	by _PARENT_ ;
run ; 

proc sort data = clusterheight ;
	by _PARENT_ ;
run ; 

data clustersfinished (keep = _NAME_ _PARENT_ _HEIGHT_ ) ;
	length _PARENT_ $15. ;
	merge clustersfinished (in=a) clusterheight (in=b) ;
	by _PARENT_ ;
	if a ;
	if _HEIGHT_ = . then do ;
		_CLUSTEROLD_ = _PARENT_ ;
		_PARENT_ ="CL10"||substr(_NAME_,4,5); 
		_HEIGHT_ = 0 ; 
	end; 
run ;

proc sort data = clustersfinished out=&outlib..clustersfinished_lodes_&year._ind&ind. ;
	by _PARENT_ ;
run ; 

proc freq data = &outlib..clustersfinished_lodes_&year._ind&ind. nlevels;
	table _PARENT_ ;
run ; 

proc datasets ;
	delete clussize clustersfinished clusterheight ctydata cutclusters clustertree ;
run ; 

%cluster_naming(lodes_&year._ind&ind.,inlib=&outlib.,outlib=OUTPUTS,otherlib=&inlib.) ;

%clustermap_named(clustersnamed_lodes_&year._ind&ind.,mapyear=2012,inlib=OUTPUTS,
			name=lodes_&year._ind&ind.,mappath=./paper/figures);

%end ;


%if "&range." = "all" %then %do ;

%cluster_compare(lodes_&year._ind1,lodes_&year._ind2,inlib=&outlib.,outlib=&outlib.,noprint=NO) ;

data test_indcomp ;
	merge &outlib..mismatch_share &outlib..mismatch_share_wgt
		&outlib..mismatch_total &outlib..sample_merged
		&outlib..master_merged ;
	year = &year. ;
run; 

proc print data = test_indcomp ;
	title 'Comparing Goods Producing to Trade and Transport' ;
run; 

%cluster_compare(lodes_&year._ind1,lodes_&year._ind3,inlib=&outlib.,outlib=&outlib.,noprint=NO) ;

data test_indcomp ;
	merge &outlib..mismatch_share &outlib..mismatch_share_wgt
		&outlib..mismatch_total &outlib..sample_merged
		&outlib..master_merged ;
	year = &year. ;
run; 

proc print data = test_indcomp ;
	title 'Comparing Goods Producing to All Other Services' ;
run;

%end ; 

%cluster_compare(lodes_&year._ind2,lodes_&year._ind3,inlib=&outlib.,outlib=&outlib.,noprint=NO) ;

data test_indcomp ;
	merge &outlib..mismatch_share &outlib..mismatch_share_wgt
		&outlib..mismatch_total &outlib..sample_merged
		&outlib..master_merged ;
	year = &year. ;
run; 

proc print data = test_indcomp ;
	title 'Comparing  Trade and Transport to All Other Services' ; 
run;



%mend review_ind ; 

