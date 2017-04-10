/*************************************
This macro is the second step in our spectral
clustering, which subsets the original
eigen vector matrix from step1,
based on the choice variable k
************************************/


%macro prociml_step2(numctys,indir=WORK) ;

proc iml; 
/* because the parallizing takes it away from correct pointer */
reset storage = &indir..IMLSTOR ;
load eigenvectors; 

eiuse=eigenvectors[,1:&numclus.];

* square elements;

eisq=eiuse##2;


* sum squares by row;
oneid=I(&numclus.);
onecol=oneid[,<>];
eisqsum=eisq*onecol;
* square root by element;
eisqsum=eisqsum##0.5;
* divide elements by norm factor (should be unit length one, but does not appear to be);
einorm=eiuse/eisqsum;

* prep for export to SAS, join with id values;
use &indir..ctylist;
read all;
eid=einorm||ctynum;

* write back to sas;
create eigen from eid;
append from eid;
close eigen;

quit; 


%mend prociml_step2 ; 
