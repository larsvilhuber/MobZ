%macro prepspectral(infile=,outfile=,indir=WORK,outdir=WORK)  ;

proc transpose data = &indir..&infile. 
		out=flows name=work_cty prefix=dist; 
    by home_cty;
run;


data flows (drop=dist1 home_cty_pre work_cty_pre);
    length home_cty work_cty $5;
    set flows (/*where=((not(substr(home_cty_pre,4,2) in(&st.))) and (not(substr(work_cty_pre,4,2) in(&st.)))) */
            rename=(home_cty=home_cty_pre work_cty=work_cty_pre));
    home_cty=substr(home_cty_pre,4,5);
    work_cty=substr(work_cty_pre,4,5);
    /* getting rid of hawaii and alaska */
    if substr(home_cty,1,2) not in ('02','15') and substr(work_cty,1,2) not in ('02','15') ;
    /* This makes it a similarity matrix instead of distance matrix */
    sim=1-dist1;
run;


proc contents data=flows;
    title "Reshaped data";
run;

proc means data=flows;
    title "summary of flows";
    var sim;
run;
/*    
proc freq data=flows ; 
    title 'od counties';
    tables home_cty work_cty ;
run;    
*/
* create list of numbered counties and count them;
data ctylist (keep=cty ctynum);
    retain ctynum;
    set flows (where=(substr(cty,1,2) not in ('02','15') )
                    keep=home_cty rename=(home_cty=cty));
    by cty;
    if (first.cty) then do;
        ctynum=max(ctynum,0)+1;
        output;
    end;
run;
data _null_;
    set ctylist end=eof;
    if eof then call symput("countycount",ctynum);
run;
proc print data=ctylist (obs=15);
    title "List of ordered counties (total of &countycount.)";
run;
        
* create version with numbered counties;
data flows_num;
    merge flows ctylist (rename=(cty=home_cty ctynum=home_ctynum));
    by home_cty ;
run;
proc sort data=flows_num;
    by work_cty home_cty;
run;    
    
  /* this is QA*//*
roc freq data=flows_num ; 
    title 'Checking values of O & D counties' ; 
    tables home_cty work_cty ; 
run;            */   
        
data flows_num (drop=work_cty home_cty);
    merge flows_num ctylist (rename=(cty=work_cty ctynum=work_ctynum));
    by work_cty;
run;
        
proc sort data=flows_num out=&outdir..&outfile.;
    by home_ctynum work_ctynum;
run;    

%mend prepspectral ;
