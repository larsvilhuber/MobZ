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

*ods close ;

proc print data = clustertree_jtw1990(where=(_HEIGHT_>0.85 and _HEIGHT_<.98)) ;
	var _HEIGHT_ _NAME_ ;
run; 

goptions reset= all device=png gsfname = gout xpixels=1600 ypixels=800;
filename gout "./paper/figures/moe_distribution.png" ; /*this writes it directly to paper folder */

proc sgplot 
	data = clustertree_jtw1990 ; 
	density _HEIGHT_ /type=normal mu=29 sigma = 13 ;
run;

%mend skip ; 
