%cluster(jtw1990,inlib=OUTPUTS,outlib=OUTPUTS) ;

%macro skip;
proc print data = OUTPUTS.clustertree_jtw1990 ;
	var _NAME_ _PARENT_ _HEIGHT_ ;
run; 

proc sort data  = OUTPUTS.clustertree_jtw1990; 
	by _HEIGHT_ ;
run ;	




ods graphics on /imagefmt=png imagename = "distancebetweenclusters" ;
ods listing gpath = "./paper/figures" ;

proc sgplot 
	data = OUTPUTS.clustertree_jtw1990(where=(_HEIGHT_>0.85 and _HEIGHT_<.98)) ;
	histogram _HEIGHT_ /scale = COUNT ;
	density _HEIGHT_ / type=kernel; 
	refline 0.9418 /axis = X lineattrs=(color=red thickness =5
	pattern=LongDash);
run; 



:proc print data = clustertree_jtw1990(where=(_HEIGHT_>0.85 and _HEIGHT_<.98)) ;
	var _HEIGHT_ _NAME_ ;
run; 

%mend skip ; 
