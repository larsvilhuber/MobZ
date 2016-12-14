/*********************************************
            
ORIGINALLY CREATED BY MJK in Summer 2016
            
HIS CODE HAS BEEN REWRITTEN AND BROKEN UP INTO THREE
PIECES:
            1. PREPSPECTRAL.SAS
            2. SPECTRAL_CLUSTER.SAS (CURRENT)
            3. MAPPING (USING STANDARD MAPPING MACRO)
**********************************************/            
* BEGIN MACRO;
%macro spectral_cluster(infile=,outfile=,numclus=,indir=WORK,outdir=WORK,noprint=NO);

%if "&noprint."="YES" %then %do ;
%put "ENTERING SPECTRAL " ;
%printjunk ;

%end; 

* compress state list for name;
%let geo=us/*%sysfunc(compress("&st.",,'p'))*/;
%put geo name will be &geo.;
  /*
data flows_num ;
     set &indir..&infile. ;
run;         
            
data _null_;
    set &indir..ctylist end=eof;
    if eof then call symput('countycount',_N_);
run;
*/            
%put "Number of counties is &countycount." ;
/**********************************
    RUNS PROC IML PROCEDURE
**********************************/
            
    %prociml_step2(&countycount.,indir=&indir.) ;

* run k-means for c clusters >=1;
proc fastclus data=eigen
    (keep=col1-col&numclus. col%eval(&numclus.+1) rename=(col%eval(&numclus.+1)=ctynum))
    noprint
    maxclusters=&numclus.
    maxiter=100
    out=clusters;
    var col1-col&numclus.;
    id ctynum;
run;    
        
* join back with county data;
proc sort data=clusters;
    by ctynum;
run;
data clusters (keep=county cluster);
    format county $5. cluster BEST10. ;
    *retain ctynum cty cluster distance; 
    merge clusters (rename=(cluster=clus)) &indir..ctylist;
    by ctynum;
    cluster = clus ; 
    county = cty ;
run;
/*proc print data=clusters (keep=ctynum cty cluster distance);
    title "K-means clusters";
run;
proc freq data=clusters;
    title "Counties per cluster, should be &numclus. clusters";
    table cluster /missing;
run;
proc means data=clusters;
    title "Cluster distance";
    class cluster;
    var distance;
run;
proc sort data=clusters (keep=cty cluster distance ctynum);
    by cty ;
run;  
    

data &outdir..&outfile.  (keep=county cluster);
    format  county $5. cluster BEST10.;
    set clusters;
        county = cty;
        cluster = cluster ; 
run;
    */
proc sort data=clusters out=&outdir..&outfile. ;
    by county ;
run;    
    
%if "&noprint."="YES" %then %do ;

%printlog ;
%put "LEAVING SPECTRAL" ;
%end; 


* END MACRO;
%mend spectral_cluster;
