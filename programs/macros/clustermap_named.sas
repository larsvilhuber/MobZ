%macro clustermap_named(dset,mapyear=x,inlib=OUTPUTS,name=none,mappath=./maps); 

data clusters (keep = state county cluster )  ;
	set &inlib..&dset. ;
	format state county cluster BEST32. ;
	state = substr(home_cty,1,2) ;
	county = substr(home_cty,3,3) ;
	cluster = substr(clustername,3,5) ;
	if state = 12 and county = 25 then county = 86; /*if JTW1990, correcting for dade --> miami-dade county */
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

/*to check eveything is covered */
data test; 
 	merge counties(in=b) clusters (in=a) ; 
	by state county; 
 	_merge=a+2*b; 
	
run; 
 
proc freq; 
	table _merge; 
run; 

proc gproject data = maps.counties(where=(state not in (2,15,72))) out=counties_proj
	parallel1 = 35 parallel2 = 50 project = albers ;
	id state county;  
run ; 

data counties_proj ;
	set counties_proj ;
run ;

data clusters ; 
	set clusters (where=(state not in (2,15,72)));
run ; 


%if %eval("&name." ne "none") %then %let mapname = &name. ;
%if %eval("&name." = "none") %then %let mapname = clustermap_&dset._&mapyear. ;

goptions reset= all device=png gsfname = gout xpixels=1200 ypixels=800;
filename gout "&mappath./&mapname..png" ;

proc gmap map = counties_proj data = clusters ;
	*title "Mobility zones from &dset. and &mapyear. ";
	id state county ;
	choro cluster	/ discrete nolegend coutline=gray;
run ; 	 

/*====================== MAPPING THEIR COMMUTING ZONES ==================*/

proc contents data = OUTPUTS.cz1990 ; 
run ; 

goptions reset= all device=png gsfname = gout xpixels=1200 ypixels=800;
filename gout "&mappath./commutingzones.png" ;

data cz1990 (keep=state county cz);
	format state county BEST32. ;
	
	set OUTPUTS.cz1990 ; 
	state = substr(cty,1,2) ;
	county = substr(cty,3,3) ;
	cz = input(cz1990,5.0);	
	if state = 12 and county = 25 then county = 86;
run ;

proc gmap map = counties_proj data = cz1990 ;
	*title "Commuting Zones from Tolbert and Sizer";
	id state county ;
	choro cz	/ discrete nolegend;
run ; 
 




%mend clustermap_named ;
