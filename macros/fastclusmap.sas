%macro fastclusmap(dset,inlib=OUTPUTS,mapname = fastclus_map,title=NO) ;

data clusters (keep = state county cluster )  ;
	set &inlib..&dset. ;
	format state county cluster BEST32. ;
	state = substr(cty,1,2) ;
	county = substr(cty,3,3) ;
run ; 	

proc contents data = clusters ; 
run ; 

proc sort data = clusters nodupkey ;
	by state county cluster ; 
run ; 
	
proc sort data = clusters ; 
	by state county ; 
run ; 

proc sort data = maps.counties out=counties ; 
	by state county ; 
run ; 

proc contents data = counties ; 
run ; 

proc gproject data = maps.counties(where=(state not in (2,15,72))) out=OUTPUTS.counties_proj
	parallel1 = 35 parallel2 = 50 project = albers ;
	id state county;
run ; 

data clusters ; 
	set clusters (where=(state not in (2,15,72)));
run ; 

proc freq data = clusters ; 
	table cluster ; 
run ;


%let mappath = ./paper/figures ;

goptions reset= all device=png gsfname = gout xpixels=1200 ypixels=800;
filename gout "&mappath./&mapname..png";

proc gmap map = OUTPUTS.counties_proj data = clusters ;
	%if "&title." = "YES" %then %do ;
		title "Mobility zones from &dset., using FASTCLUS optimization ";
	%end; 
	id state county ;
	choro cluster / discrete nolegend;
run ; 	
	

%mend fastclusmap ;
