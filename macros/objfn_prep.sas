
%macro objfn_prep ;

/**************************	
PREP OBJ FUNCTION DATASETS
*************************/
data urate2012 (keep= cty urate) ;
	infile './outputs/ctyurate2012.csv' dsd delimiter = ',' termstr = crlf ;
	input laus $ stfip $ ctyfip $ year emp1 $ emp2 $ emp3 $ urate ;
	cty = trim(left(stfip))||trim(left(ctyfip)) ; 
	if substr(stfip,1,1) ne '7' ;
	if length(stfip) = 1 then stfip = '0'||stfip;
	if length(ctyfip) = 1 then ctyfip = '00'||ctyfip ; 
	else if length(ctyfip) = 2 then ctyfip = '0'||ctyfip ;
	cty = trim(left(stfip))||trim(left(ctyfip)) ;

run; 

proc sort data = urate2012 ; 
	by cty ;
run; 	

data OUTPUTS.obj_inputs_2012 ;
	merge urate2012 /* obj_inputs_hrate */ ;
	by cty ; 
run;

%do yy = 1990 %to 2010 %by 10 ;

data urate&yy. (keep = cty urate) ;
	infile "./outputs/ctyurate&yy..csv" dsd delimiter = ',' termstr = crlf ; 
	input stfip $ ctyfip $ year urate ; 
	if substr(stfip,1,1) ne '7' ;
	if length(stfip) = 1 then stfip = '0'||stfip;
	if length(ctyfip) = 1 then ctyfip = '00'||ctyfip ; 
	else if length(ctyfip) = 2 then ctyfip = '0'||ctyfip ;
	cty = trim(left(stfip))||trim(left(ctyfip)) ;
run ;

proc sort data = urate&yy. ;
	by cty ; 
run; 

data OUTPUTS.obj_inputs_&yy. ;
	merge urate&yy. ;
	by cty ; 
run; 

%end; 



%mend objfn_prep ;
