%macro clustermap_subset(indset,state=,inlib=OUTPUTS,name=none,mapfile=,mappath=./maps,imgformat=pdf); 

%macro mylist(list) ;

   %scan(&list.,1)
    
    %do i = 2 %to %sysfunc(countw(&list.)) ;
        , %scan(&list.,&i.)
    %end;

%mend mylist; 

proc contents data=&inlib..&indset. ;
run; 

data clusters (keep = state county cluster )  ;
	set &inlib..&indset. (rename=(county=cty)) ;
	*format state BEST2. county BEST3. cluster BEST10. ;
        *_NAME_ = substr(_NAME_,4,5) ; /*getting rid of cty prefix*/
        
	/*state = substr(_NAME_,1,2) ;
	county = substr(_NAME_,3,3) ;
	cluster = substr(_PARENT_,3,5) ;*/
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

proc gproject data = maps.counties(where=(state=&state.)) out=counties_proj
	parallel1 = 35 parallel2 = 50 project = albers ;
	id state county;  
run ; 

data counties_proj ;
	set counties_proj ;
run ;

data clusters ; 
	set clusters (where=(state = &state.));
run ; 


proc print data=clusters; 
run; 

/*
%if %eval("&dset." = "lodes") %then %let mapyear = &year. ;
%else %let mapyear = x ;
*/

%if %eval("&name." ne "none") %then %let mapname = &name. ;
%if %eval("&name." = "none") %then %let mapname = clustermap_&dset._&mapyear. ;

goptions reset= all device=&imgformat. gsfname = gout xpixels=1800 ypixels=1200;

%if %eval("&mapfile." ne "") %then %do ;
    filename gout "&mappath./&mapfile._inset&state..&imgformat." ;
%end; 
%else  %do;
    %let end = %sysfunc(substr("&infile.",-7,7)) ;
    filename gout "&mappath./clustermap_&end._&mapyear._inset&state..&imgformat" ;
%end; 
proc gmap map = counties_proj data = clusters ;
	*title "Mobility zones from &dset. and &mapyear. for state &state.";
	id state county ;
	choro cluster	/ discrete nolegend coutline=gray;
run ; 	

%mend clustermap_subset ;
