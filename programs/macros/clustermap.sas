%macro clustermap(indset,mapyear=x,inlib=OUTPUTS,name=none,mapfile=,mappath=./maps,imgformat=pdf,CZ=YES); 

data clusters (keep = state county cluster )  ;
	set &inlib..&indset. (rename = (county = cty));
	*format state BEST2. county BEST3. cluster BEST10. ;
        state = input(substr(cty,1,2),2.) ;   
        county = input(substr(cty,3,3),3.) ;
	if state = 12 and county = 25 then county = 86; /*if JTW1990, correcting for dade --> miami-dade county */
run; 	

proc contents data = clusters ; 
run; 

proc sort data = clusters nodupkey ;
	by state county cluster ; 
run; 
	
proc sort data = clusters ; 
	by state county ; 
run; 

proc sort data = maps.counties out=counties ; 
	by state county ; 
run; 

proc contents data = counties ; 
run;

/* qa check */
proc freq data=counties ; 
    table state county ;
run; 
    
proc freq data=clusters ; 
    table state county ;
run;     

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


/*
%if %eval("&dset." = "lodes") %then %let mapyear = &year. ;
%else %let mapyear = x ;
*/

%if %eval("&name." ne "none") %then %let mapname = &name. ;
%if %eval("&name." = "none") %then %let mapname = clustermap_&dset._&mapyear. ;

goptions reset= all device=&imgformat. gsfname = gout xpixels=1800 ypixels=1200;

%if %eval("&mapfile." ne "") %then %do ;
    filename gout "&mappath./&mapfile..&imgformat." ;
%end; 
%else  %do;
    %let end = %sysfunc(substr("&infile.",-7,7)) ;
    filename gout "&mappath./clustermap_&end._&mapyear..&imgformat." ;
%end; 
proc gmap map = counties_proj data = clusters ;
	*title "Mobility zones from &dset. and &mapyear. ";
	id state county ;
	choro cluster	/ discrete nolegend coutline=gray;
run ; 	

%if "&CZ."="YES" %then %do; 

/*====================== MAPPING TS1996 COMMUTING ZONES ==================*/

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
	choro cz	/ discrete nolegend coutline=gray;
run ; 

%end;




%mend clustermap ;
