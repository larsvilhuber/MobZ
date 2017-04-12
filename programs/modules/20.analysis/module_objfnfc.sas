*%objfn_prep ;

%macro cycleobjfn;

/**************************************
DOING RANDOM PART HERE 
***************************************/
%prep_objfn(1990);
%randomcounties_norm(1990,noprint=NO);

data _NULL_ ;
	set random_objfn ; 
	call symput('inflows',rand_inflows);
	call symput('outflows',rand_outflows);
	call symput('sdurate',rand_sdurate);
	call symput('sdearn',rand_sdearn); 
run; 

%put "MACROS: &inflows. ; &outflows. ; &sdurate. ; &sdearn. " ;

/**************************************
Fixing fastclus definitions
****************************************/
%fastclus_prep(1990) ;

%fastclus_loop(fc_datainput,500,800,2,inlib=WORK,noprint_obj=NO,map=NO,year=1990,perm=YES,fcvars=
ctylat ctylon,dsuffix=norm,random=NO) ;
/* OUTPUT FILE IS FASTCLUS_NORM */

%fastclus_prep(1990) ;

%fastclus_loop(fc_datainput,500,800,2,inlib=WORK,noprint_obj=NO,map=NO,year=1990,perm=YES,fcvars=
ctylat ctylon urate,dsuffix=alt,random=NO) ;
/*OUTPUT FILE IS FASTCLUS_ALT */

%let years = 1990 2000 2010 ;
%let numyears = %sysfunc(countw("&years.",' ') ) ;

%do jj = 1 %to %eval(&numyears.); 
	%put "INSIDE LOOP" ;
	%let year = %scan(&years.,%eval(&jj.)) ;
	%objfn_compare_fastclus(&year.,cz1990=YES,fastclus=YES,fastclus_alt=YES);
	proc append base=objfn_graph 
			data=objectivefn_graph_&year. ;
	run;
%end; 

proc print data=objfn_graph ;
run; 

%let comparisons = cz1990 fastclus_norm fastclus_alt;
%let numitems = %sysfunc(countw("&comparisons",' ')) ;

*ods graphics on /imagefmt=png imagename = "objectivefn_raw" ;
*ods listing gpath = "./paper/figures" ;

proc sgplot data=objfn_graph ;
	title "Objective Function Graphs - Raw Data" ;
	%let jj = 1 ;
	%do %while(%eval(&jj.<=&numitems.));	
		series x = year y = %scan(&comparisons.,%eval(&jj.));		
		%let jj = %eval(&jj.+1) ;
	%end;
	xaxis label="Year" values=(1990 2000 2010);
	yaxis label="Objective Function Value";
run;


/********************************************/
/*NORMALIZED DATA */
/********************************************/
%macro skip; 
%let comparisons = cz1990 cz2000 state /* national fastclus */  msa;
%let numitems = %sysfunc(countw("&comparisons",' ')) ;

proc sgplot data=normalized ;
	title "Objective Function Graphs - Normalized" ;
	%let jj = 1 ;
	%do %while(%eval(&jj.<=&numitems.));
		%let series  = %scan(&comparisons.,%eval(&jj.)) ;
		series x = year y = &series.;	
		%let jj = %eval(&jj.+1) ;
	%end;
	xaxis label="Year" values=(1990 2000 2010);
	yaxis label="Objective Function Value";
run;
/* WITH FASTCLUS*/
%let comparisons = cz1990 cz2000 state /*national*/  msa fastclus;
%let numitems = %sysfunc(countw("&comparisons",' ')) ;

proc sgplot data=normalized ;
	title "Objective Function Graphs - Normalized" ;
	%let jj = 1 ;
	%do %while(%eval(&jj.<=&numitems.));
		%let series  = %scan(&comparisons.,%eval(&jj.)) ;
		series x = year y = &series.;		
		%let jj = %eval(&jj.+1) ;
	%end;
	xaxis label="Year" values=(1990 2000 2010);
	yaxis label="Objective Function Value";
run;
%mend skip ;


%mend cycleobjfn;

%cycleobjfn
