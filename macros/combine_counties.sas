%macro combine_counties(dataset,ctyfield);

proc sort data = &dataset. out = temp (rename = (&ctyfield. = cty)) ; 
	by &ctyfield. ; 
run ; 

	
/* county recode dataset sorted on cty */

data &dataset.;
	merge temp (in = a ) GEO.county_recodes (in=b) ;
	by cty ; 
	if a  ;
	if b then &ctyfield. = newcty ; 
	/*if there is a match in the data,
					then replace value*/
	else &ctyfield. = cty ; 
	
	drop 
	%if  "&ctyfield." ne "cty" %then %do ;
		cty
	%end;  
		newcty ; 
run ;

%mend combine_counties ;
		
