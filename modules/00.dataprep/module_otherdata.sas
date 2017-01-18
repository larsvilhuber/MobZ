data OUTPUTS.urates_allyears;
    infile './outputs/urates_counties.csv' delimiter = ',' MISSOVER ;
    input cty $ year urates ;
    if substr(cty,1,2) ne '02' ;
run; 
    
proc print data=OUTPUTS.urates_allyears (obs=20) ;
run;    

%correlation_matrix(1995,2000,urates,infile=urates_allyears,indir=OUTPUTS,outfile=corrmatrix_urates,outdir=WORK) ;
    
data OUTPUTS.earnings_allyears;
    infile './outputs/earnings_counties.csv' delimiter=',' MISSOVER;
    input cty $ year earnings ;
    if substr(cty,1,2) ne '02' ;
run;
 
   
%correlation_matrix(1995,2000,earnings,infile=earnings_allyears,indir=OUTPUTS,outfile=corrmatrix_earnings,outdir=WORK) ;    

    
proc transpose data=corrmatrix_urates (drop=_NAME_)
                out=OUTPUTS.corrlong_urates ; 
    by cty ;
run;
    
data OUTPUTS.corrlong_urates (keep=home_cty work_cty corr); 
    length  work_cty $5 ;
    set OUTPUTS.corrlong_urates (rename=(cty=home_cty)) ;
    if home_cty ne '' ;
    work_cty = substr(_NAME_,7,5) ;
    corr = col1 ;
run;

proc print data=OUTPUTS.corrlong_urates (obs=20) ;
    title 'corrlong urates' ;
run;               
    
proc transpose data=corrmatrix_earnings (drop=_NAME_)
                out=OUTPUTS.corrlong_earnings; 
    by cty ;
run;
    
data OUTPUTS.corrlong_earnings (keep=home_cty work_cty corr) ;
    length work_cty $5 ;
    set OUTPUTS.corrlong_earnings (rename=(cty=home_cty)) ;
    if home_cty ne '' ;
    work_cty = substr(_NAME_,7,5) ;
    corr = col1 ;
run;

proc print data=OUTPUTS.corrlong_earnings (obs=20) ;
    title 'corrlong earnings' ;      
run;               

proc contents data=OUTPUTS.corrlong_urates ;
run;
proc contents data=OUTPUTS.corrlong_earnings;
run;
