/**************************************
This macro is the first step in
our spectral clustering,
which calculates ALL eigen vectors;
Step2 subsets the eigen vector matrix 

Note: lightly edited from original version
***************************************/


%macro prociml_step1(numctys,indir=WORK) ;

* begin proc IML;
proc iml;
    
* read SAS data into IML;
use flows_num;
read all;

* id values;
use &indir..ctylist;
read all;

* create vectorized sparse matrix;
f=sim||home_ctynum||work_ctynum;
    
* create full matrix (if args 2 and 3 are blank, uses maximum);
s=full(f);

* calculate Degree matrix (transformed to inverse, square root), drop ones on diagonal?;
oneid=I(&numctys.);
onecol=oneid[,<>];
rowsum=s*onecol;
rowsuminv=onecol/rowsum;
rowsuminvroot=rowsuminv##0.5;
degreeinvroot=oneid#rowsuminvroot;

* calculate symmetric Laplacian;
L=degreeinvroot*s*degreeinvroot;

* calculate eigenvectors;
call eigen(eigenvalues,eigenvectors,L);

/*storing for prociml_step2 */
store eigenvectors ; 

quit ; 

%mend prociml_step1 ; 
