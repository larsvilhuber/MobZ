%macro fastclus_prep(year) ;

data xwalk ; 
	set GEO.blk_xwalk_wide (keep=ctylat ctylon fipsstco);
	/*need to also restrict it to places outside US*/
	if input(substr(fipsstco,1,2),comma3.)<= 56 ;
	if substr(fipsstco,1,2) ne '02' and substr(fipsstco,1,2) ne '15' ; /*eliminating alaska and hawaii */
run; 

proc sort data = xwalk out=ctycoors (rename=(fipsstco=cty))  nodupkey;
	by fipsstco ;
run; 
/*moved from fastclus_loop*/


/**************************************

*************************************/
%if %eval(&year.>2010) %then %do ;

	/* for now just keeping it with 2012 */
	
	data urates_cty (keep= cty urate) ;
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
/**************************	
PREP OBJ FUNCTION DATASETS
*************************/
data urates_cty (keep= cty urate) ;
	infile "./outputs/ctyurate&year..csv" dsd delimiter = ',' termstr = crlf ;
	input stfip $ ctyfip $ year urate ;
	cty = trim(left(stfip))||trim(left(ctyfip)) ; 
	*if substr(stfip,1,1) ne '7' ;
	if input(stfip,comma2.) <= 56 ;
	if length(stfip) = 1 then stfip = '0'||stfip;
	if length(ctyfip) = 1 then ctyfip = '00'||ctyfip ; 
	else if length(ctyfip) = 2 then ctyfip = '0'||ctyfip ;
	cty = trim(left(stfip))||trim(left(ctyfip)) ;
run; 
%end ;

proc sort data = urates_cty ;
	by cty ; 
run; 


/*******************************
MAKING FINAL FASTCLUS DATASET INPUT
***********************************/

data fc_datainput ;
	merge ctycoors  urates_cty ;
	by cty ; 
run; 

proc sort data = fc_datainput ;
	by cty ;
run; 

proc means data = fc_datainput ;	
		output out = stats 
				min(ctylat ctylon urate)=minlat minlon minurate
				max(ctylat ctylon urate)= maxlat maxlon maxurate;
run; 

%macro skip ; 
/**************************	
PREP OBJ FUNCTION DATASETS
*************************/
data obj_inputs_urate (keep= cty urate) ;
	infile './outputs/ctyurate2012.csv' dsd delimiter = ',' termstr = crlf ;
	input laus $ stfip $ ctyfip $ year emp1 $ emp2 $ emp3 $ urate ;
	cty = trim(left(stfip))||trim(left(ctyfip)) ; 
	*if substr(stfip,1,1) ne '7' ;
	if input(stfip,comma2.) < 56 ;
	if length(stfip) = 1 then stfip = '0'||stfip;
	if length(ctyfip) = 1 then ctyfip = '00'||ctyfip ; 
	else if length(ctyfip) = 2 then ctyfip = '0'||ctyfip ;
	cty = trim(left(stfip))||trim(left(ctyfip)) ;
run; 

data obj_inputs_wages (keep = cty earnings) ;
	infile './outputs/ctyearnings_2012.csv' dsd delimiter = ',' termstr = crlf ;
	input cty $ name $ inearn $ ;
	if input(substr(cty,1,2),comma2.) < 56 ; 
	if length(cty) = 4 then cty = '0'||trim(left(cty)) ; 
	if inearn = "(NA)" then inearn = "" ;
	earnings = input(inearn,best32.) ;
run; 

proc print data = obj_inputs_wages (obs=20);
run;

proc sort data = obj_inputs_wages ;
	by cty ;
run; 

proc sort data = obj_inputs_urate ; 
	by cty ;
run; 	

data OUTPUTS.obj_inputs_2012 ;
	merge obj_inputs_urate obj_inputs_wages ;
	by cty ; 
run;

%mend skip ;

%mend fastclus_prep ;
