%macro preprecession(startyr,endyr,inlib=OUTPUTS,outlib=OUTPUTS) ;

%do year = &startyr. %to &endyr. ; 

	%preplodes(&year.,outlib=WORK) ;
	
	%geoagglodes(&year.,inlib=WORK,outlib=&outlib.) ;
	
%end ; 	

proc datasets ;
	delete blk_xwalk_sorted ;
run;  

proc sql nowarn;
     create table ctyshell as
         select * 
         from 

            OUTPUTS.reslf_lodes (keep=home_cty) a,
              OUTPUTS.reslf_lodes (keep=home_cty rename=(home_cty=work_cty)) b
         order by home_cty, work_cty ;	
quit;

data &outlib..ctyshell ; 
	set ctyshell ; 
	if home_cty ne '' and  work_cty ne '' ; 
run ;


%mend preprecession ; 
