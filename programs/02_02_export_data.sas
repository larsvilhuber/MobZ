* Mobility Zones (MobZ);
* Export data to other formats;
options  mlogic symbolgen spool fullstimer;

%include "config.sas" ;



    proc export data=OUTPUTS.clusfin_jtw1990 
            outfile = "&diroutputs./clusfin_jtw1990.dta" replace; 
    run;

    proc export data=OUTPUTS.clusfin_jtw1990 
            outfile = "&diroutputs./clusfin_jtw1990.csv" replace; 
    run;

