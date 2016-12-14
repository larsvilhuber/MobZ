%macro comstat(dset,inlib=OUTPUTS,outlib=OUTPUTS) ;

data comstat;
	set &outlib..ctypairs_&dset. (keep=home_cty work_cty h_w_jobflows w_h_jobflows reslf_h reslf_w p_ij
	where=(home_cty=work_cty));
	comwithin=h_w_jobflows/reslf_h;
	comoutside = w_h_jobflows/reslf_h;
	if reslf_h>reslf_w then do ;
		comwithin_adj = h_w_jobflows/reslf_w ;
		comoutside_adj = w_h_jobflows/reslf_w;
		reslf_actual = reslf_w ;
	end ;
	else do ;
		comwithin_adj = h_w_jobflows/reslf_h; 
		comoutside_adj = w_h_jobflows/reslf_h ;
		reslf_actual = reslf_h;
	end; 
run;
/*
proc means data=comstat;
	title "Commuting stats for &dset., unweighted";
	var h_w_jobflows reslf_h comwithin;
run;


proc sort data = comstat nodupkey ;
	by home_cty ;
run ;
*/
proc means data=comstat n mean stddev min max sum;
	title "Commuting stats for &dset., weighted";
	var h_w_jobflows w_h_jobflows reslf_h reslf_w comwithin comoutside comwithin_adj comoutside_adj p_ij reslf_actual;
	weight reslf_h;
	output out=comstat;
run;
data comstat;
	length dset $10;
	set comstat (drop=_TYPE_ p_ij w_h_jobflows reslf_w comoutside comwithin_adj comoutside_adj reslf_actual);
	dset="&dset.";
run;

proc append base=comstat_all data=comstat;
run;

%mend comstat;
