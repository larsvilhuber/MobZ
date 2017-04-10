/*********************************
THIS PROGRAM PREPARES ALL THE COMPONENTS
OF THE OBJECTIVE FUNCTION EXCEPT 
COMMUTING FLOWS (DONE INSIDE OF 
OBJECTIVE FUNCTION)
***********************************/

%macro prep_objfn(year,outlib=WORK) ;

/**********************************
WAGES 
***********************************/
data obj_inputs_wages (keep = cty earnings) ;
	infile './outputs/earnings_cty.csv' dsd delimiter = ',' termstr = crlf ;
	input cty $ year inearn $ ;
	if year = &year. ;
	if inearn="(NA)" then inearn="" ;
	if input(substr(cty,1,2),comma2.) <= 56 ; 
	if length(cty) = 4 then cty = '0'||trim(left(cty)) ; 
	earnings = input(inearn,best32.) ;
run; 

proc print data= obj_inputs_wages (obs=20);
run; 



/************************************
UNEMPLOYMENT RATES 
************************************/

%if %eval(&year.>2010) %then %do ;
	
	/* for now just keeping it with 2012 */
	
	data obj_inputs_urate (keep= cty urate) ;
		infile './outputs/ctyurate2012.csv' dsd delimiter = ',' termstr = crlf ;
		input laus $ stfip $ ctyfip $ year emp1 $ emp2 $ emp3 $ urate ;
		cty = trim(left(stfip))||trim(left(ctyfip)) ; 
		if substr(stfip,1,1) ne '7' ;
		if length(stfip) = 1 then stfip = '0'||stfip;
		if length(ctyfip) = 1 then ctyfip = '00'||ctyfip ; 
		else if length(ctyfip) = 2 then ctyfip = '0'||ctyfip ;
		cty = trim(left(stfip))||trim(left(ctyfip)) ;
	run; 
	
%end ; 

%else %do ; 

data obj_inputs_urate (keep= cty urate) ;
	infile "./ctyurate&year..csv" dsd delimiter = ',' termstr = crlf ;
	input stfip $ ctyfip $ year urate ;
	cty = trim(left(stfip))||trim(left(ctyfip)) ; 
	*if substr(stfip,1,1) ne '7' ;
	if input(stfip,comma2.) <= 56 ;
	if length(stfip) = 1 then stfip = '0'||stfip;
	if length(ctyfip) = 1 then ctyfip = '00'||ctyfip ; 
	else if length(ctyfip) = 2 then ctyfip = '0'||ctyfip ;
	cty = trim(left(stfip))||trim(left(ctyfip)) ;
run; 

%end;



/*******************************
MERGING TWO TOGETHER
******************************/

proc sort data = obj_inputs_urate ; 
	by cty ;
run; 

proc sort data = obj_inputs_wages ;
	by cty ;
run; 	

data &outlib..obj_inputs_&year. ;
	merge obj_inputs_urate obj_inputs_wages ;
	by cty ; 
run;

proc contents data = &outlib..obj_inputs_&year.;
run; 

%mend prep_objfn ;

