
%prepspectral(infile=clustermatrix_jtw1990,outfile=specclus_jtw1990,indir=OUTPUTS,outdir=WORK);

data flows_num ;
     set specclus_jtw1990 ;
run;         
            
data _null_;
    set ctylist end=eof;
    if eof then call symput('countycount',_N_);
run;   

%prociml_step1(&countycount.) ;

%spectral_cluster(infile=specclus_jtw1990,outfile=spectral_jtw1990,numclus=629,indir=WORK,outdir=OUTPUTS);