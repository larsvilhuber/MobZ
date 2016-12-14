%macro preplodes_ez(startyr,endyr,jt,inlib=OUTPUTS,outlib=OUTPUTS) ;

%do year = &startyr. %to &endyr. ; 

	%preplodes(&year.,outlib=WORK) ;
	
	%geoagglodes(&year.,inlib=WORK,outlib=&outlib.) ;
	
%end ; 

%mend preplodes_ez;
