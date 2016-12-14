
%fastclus_prep(1990);

%fastclus_loop(fc_datainput,500,800,20,inlib=WORK,noprint_obj = NO,
map=NO,year=1990,perm=NO,fcvars=ctylat ctylon urate,dsuffix=fast,random=YES) ; 

proc print data = bestclusters_fast ;
run; 

%fastclusmap(bestclusters_fast,inlib=WORK, mapname=fastclus_urate_map)
