/* --- this module servces to test cluster_similarity macro,
        which is used in a number of other processes ---*/
%review(jtw1990,&cutoff.,inlib=OUTPUTS,outlib=WORK,noprint=YES) ;        


data cz (rename=(cty=county cz1990=cluster));
    set OUTPUTS.cz1990;
run;    
%cluster_similarity(cz,clusfin_jtw1990,inlib=WORK);        
