* Mobility Zones (MobZ);
* Execute control program to run selected modules;	
options  mlogic symbolgen spool;
* Modules, set to 1 to run, otherwise 0;	

%include "config.sas";

proc import out=czones DATAFILE="&root./raw/czlma903.xls" dbms=xls replace;
sheet="CZLMA903";
getnames=yes;
run;
proc contents;
run;
data czones;
set czones;
length cty $ 5;
cty = compress(County_FIPS_Code);
cz1990 =  cz90;
run; 


    data cz1990 (keep = cty cz1990) ;
    	length cty $5. ;
    	infile "&root./raw/czones.csv" dsd  delimiter = ',' firstobs=2 ;
    	/* Commuting zones are here: https://www.ers.usda.gov/webdocs/DataFiles/Commuting_Zones_and_Labor_Market_Areas__17970//czlma903.xls */
    	input ctycode $ cz1990 $ ;
    	if cz1990 ne "CZ90"; 
        if cz1990 ne "cz199";
    	cty = ctycode ; 
    run ; 		
proc print data=cz1990(obs=10);
run;
    
proc compare base=czones compare=cz1990;
var cty cz1990;
run;
