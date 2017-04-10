%macro prociml(numctys,indir=WORK) ;


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
*print_f=f[1:15,1:3];
*print print_f;
    
* create full matrix (if args 2 and 3 are blank, uses maximum);
s=full(f);
*print_s=s[1:15,1:15];
*print print_s;

* calculate Degree matrix (transformed to inverse, square root), drop ones on diagonal?;
oneid=I(&numctys.);
onecol=oneid[,<>];
*rowsum=s*onecol;
*rowsuminv=onecol/rowsum;
*rowsuminvroot=rowsuminv##0.5;
*degreeinvroot=oneid#rowsuminvroot;

/* testing to see if it uses less memory */
/* PROC IML used to used: 993136K */
rowsuminv=onecol/(s*onecol) ;
degreeinvroot=oneid#(rowsuminv##0.5) ;

*print_degreeinvroot=degreeinvroot[1:15,1:15];
*print print_degreeinvroot;

* calculate symmetric Laplacian;
L=degreeinvroot*s*degreeinvroot;
*print_L=L[1:15,1:15];
*print print_L;

* calculate eigenvectors;
call eigen(eigenvalues,eigenvectors,L);
*print_eival=eigenvalues[1:15];
*print print_eival;
*print_eivec=eigenvectors[1:15,1:15];
*print print_eivec;

* normalize c vectors;
* select c eigenvectors to use;


eiuse=eigenvectors[,1:&numclus.];

*eisq=(eigenvectors[,1:&numclus.])##2 ;

*print_eiuse=eiuse[1:15,1:&numclus.];
*print print_eiuse;
* square elements;

/*commented out*/
eisq=eiuse##2;


* sum squares by row;
oneid=I(&numclus.);
onecol=oneid[,<>];
eisqsum=eisq*onecol;
* square root by element;
eisqsum=eisqsum##0.5;
* divide elements by norm factor (should be unit length one, but does not appear to be);
einorm=eiuse/eisqsum;
*print_einorm=einorm[1:15,1:&numclus.];
*print print_einorm;

* prep for export to SAS, join with id values;
use &indir..ctylist;
read all;
eid=einorm||ctynum;

* write back to sas;
create eigen from eid;
append from eid;
close eigen;
/*       
* singular value decomposition;
call svd(u,q,v,s);

* print small numbers as zero;
reset fuzz;
* The singular values are sorted in descending order (what do we do with q?);
*print u, q, v;
print_q=q[1:15,];
print print_q;
* in u, use k-means to look for the records with highest score in each vector, these are close to each other;

* prep for export to SAS, join with id values;
uid=u||ctynum;

* write back to sas;
create orthog from uid;
append from uid;
close orthog;
*/
* end of IML;
quit;

%mend prociml; 
