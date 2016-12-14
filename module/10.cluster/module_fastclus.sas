
%fastclus_prep(1990);

%fastclus_loop(fc_datainput,500,502,2,inlib=WORK,noprint_obj = NO,
map=NO,year=1990,perm=NO,fcvars=ctylat ctylon) ; 

proc print data = bestclusters ;
run; 
