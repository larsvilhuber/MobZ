* Post-processing clustering output ;
%macro review(dset,cutoff,inlib=OUTPUTS,outlib=OUTPUTS,noprint=NO) ;

%if "&noprint."="YES" %then %do ;
%put "ENTERING REVIEW " ;
%printjunk ;

%end;

/* =========== CUTOFF FOR CLUSTER HEIGHT ==========*/

proc contents data = &inlib..clustertree_&dset.;
run; 

proc sort data = &inlib..clustertree_&dset. out=test;
    by _NAME_ ;
run;
    
proc print data= test;
    var _NAME_ ;
run;

proc sort data = &inlib..clustertree_&dset. out=clustertree; 
	by _HEIGHT_ ;
run ;

data clustertree; 
%put "Setting data into tempset" ;
	set &inlib..clustertree_&dset. ;
run; 

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
/*
proc print data =clusterdata ; 
run ; 
*/


proc sort data = clusterdata ;
	by _PARENT_ ;
run ;	

/* QA CODE */
/*
proc print data = clusterdata ; 
run ;
*/

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
	%put "Start of Geneology loop while mein=&mein., pointbreak=&pointbreak., and cirguitbreaker=&circuitbreaker.";
	
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

data clustersfinished (keep = _NAME_ _PARENT_ _HEIGHT_ state county cluster ) ;
	length _PARENT_ $15. ;
	merge clustersfinished (in=a) clusterheight (in=b) ;
	by _PARENT_ ;
	if a ;
	if _HEIGHT_ = . then do ;
		_CLUSTEROLD_ = _PARENT_ ;
		_PARENT_ ="CL10"||substr(_NAME_,4,5); 
		_HEIGHT_ = 0 ; 
	end;

        county = substr(_NAME_,4,5) ;
        cluster = input(substr(_PARENT_,3,8),8.) ;
run ;

proc sort data = clustersfinished out=&outlib..clusfin_&dset. 
                                    (keep=county cluster _PARENT_ _NAME_) ;
	by cluster;
run ; 

proc freq data = &outlib..clusfin_&dset. nlevels;
	table _PARENT_ ;
run ; 

data numclus ;
	set &outlib..clusfin_&dset. ;
	x = 1 ;
run; 

proc summary data = numclus nway; 
	class _PARENT_ ;
	var x ; 
	output out = clussize 	N(x) = numcounties ; 
run ;

data singletons ;
	set clussize (where=(numcounties = 1)) ;
run; 

proc print data = singletons ;
	var _PARENT_ numcounties ; 
run;

proc freq data = clussize;
	tables numcounties ; 
run; 	

proc means data = clussize mean std p5 p25 p50 p75 p95; 
	var numcounties ;
run; 

proc summary data=  clussize ; 
	var numcounties ;
	output out = mean_clussize mean(numcounties)=mean_clussize ; 
run; 

proc summary data = clussize ;
	var numcounties ;
	output out = median_clussize median(numcounties)=median_clussize ;
run;

proc sort data = numclus nodupkey out = clustercount;
	by _PARENT_ ;
run;

proc summary data = clustercount;
	var x ;
	output out = clustercount sum(x) = numclusters ;
run; 

proc datasets ;
	delete clussize clustersfinished clusterheight ctydata cutclusters clustertree ;
run ; 
%if "&noprint."="YES" %then %do ;
%printlog ;
%put "LEAVING REVIEW" ;
%end; 

%mend review ; 

