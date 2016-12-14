%macro contiguity(dset) ;


data clusfin_a (rename=(_NAME_ = home_cty _PARENT_=cluster_a)) 
	clusfin_b  (rename = (_NAME_=work_cty _PARENT_ = cluster_b)) ;
	
	set OUTPUTS.clusfin_&dset. ; 
	_NAME_ = substr(_NAME_,4,5) ; /*getting rid of cty prefix*/
	output clusfin_a ;
	output clusfin_b ; 
run ; 	

/*QA CODE*/
/*
proc sort data = clusfin_a ;
	by home_cty ; 
run ;

proc print data = clusfin_a (obs = 40); 
run ; 	
*/

proc sql nowarn;
     create table ctyshell as
         select home_cty, work_cty  
         from 

            clusfin_a
		a,
             clusfin_b 
	     		b
         /*order by home_cty, work_cty  */   
	 where a.cluster_a =b.cluster_b ;	
 quit;
 
 proc sort data = clusfin_a ; 
 	by home_cty ;
run;

 
 proc sort data = ctyshell ; 
 	by home_cty work_cty ;
run ;

data clustershell (keep=home_cty work_cty cluster) ;
	merge ctyshell clusfin_a (rename = (cluster_a=cluster)) ;
	by home_cty ; 
run ;

proc sort data  = clustershell ;
	by home_cty work_cty ; 
run ;
	

proc print data = ctyshell (firstobs = 400 obs = 500); 
run ; 	


/* County Adjacency Table from CENSUS - OUTPUTS.ctyadj */

data ctyadj ;
	set OUTPUTS.ctyadj (where=(home_cty ne work_cty )) ;
run; 

proc sort data = ctyadj; 
	by home_cty work_cty ; 
run ; 
/*
proc print data = clustershell (obs = 100); 
run ; 
*/
/* Here I merge in the paired county shell with the county adjacency table, and */
data adjmerge (keep = home_cty work_cty cluster contiguous ) ;
	merge clustershell (in=a) ctyadj (in=b) ;
	by home_cty work_cty ; 
	if a ; 
	if b then contiguous = 1 ; 
	else contiguous = 0 ;
	
run; 

data adjmerge ; 
	set adjmerge (where=((home_cty ne '' and work_cty ne '' ) and cluster ne '' ));
run ;

proc print data = adjmerge (firstobs=350 obs = 450 ) ;
run ; 


proc sort data = adjmerge ; 
	by home_cty cluster ;
run;  

proc summary data = adjmerge ;
	class home_cty cluster; 
	var contiguous ; 
	output out = contiguity (keep=home_cty cluster ctycount) sum(contiguous) = ctycount ;
run ;

data contiguity ;
	set contiguity (where=((home_cty ne '' ) and cluster ne '' ));
run ;

proc print data = contiguity (obs =120) ;
run ;
 
data contiguous noncontiguous ; 
	set contiguity ; 
	if ctycount = 0 then output noncontiguous ;
	else output contiguous ; 
run ;

proc print data = noncontiguous ; 
	title "Non-contiguous counties in clusters" ; 
	var home_cty cluster ; 
run; 

proc sort data = noncontiguous out=splitclusters nodupkey ;
	by cluster ; 
run ; 

proc sort data = OUTPUTS.clustersfinished_&dset. out = clusfin (rename = (_PARENT_ = cluster)) ;
	by _PARENT_ ;
run ; 

data brokenclus ; 
	merge clusfin (in=a) splitclusters (in=b) ; 
	by cluster; 
	if b and a ;
run ;

proc print data = brokenclus ;
	title 	"Clusters with non-contiguous sections" ;
run ;

%mend contiguity ; 



