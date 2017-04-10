%macro correlation_matrix(startyr,endyr,outvar,infile=,indir=,outfile=,outdir=) ;

proc sort data=&indir..&infile. (where=(year>=&startyr. and year<=&endyr.)) 
            out=corrtest (rename =(cty=fips)); 
    by year ;
run;     
    
proc print data=corrtest (obs=20) ;
run;        
        
proc transpose data=corrtest out=corrtest prefix=county ;
        by year;
        id fips ;
        var &outvar. ;
run;        
    /*    
proc print data=corrtest (obs=20) ;
run; 
     */   
proc corr data=corrtest outp=corrmatrix noprint ;
run;
        
data &outdir..&outfile.  (drop = _TYPE_ ); 
    format cty $5. ;
    set corrmatrix (drop=year) ;
    if _TYPE_ = 'CORR' ;
    if _NAME_ ne '' or _NAME_ ne 'year' ;
   cty=substr(_NAME_,7,5) ;
run;
           /*  
proc print data=&outdir..&outfile. (obs=20) ;
run;        
            */

%mend correlation_matrix ; 
