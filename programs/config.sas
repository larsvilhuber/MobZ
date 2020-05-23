%let root = /ssgprojects/project0002/MobZ.new ; 
%let raw=&root./raw ;
%let dirprog=&root/programs;
%let dirfig=&root/figures;


libname OUTPUTS "&root./data";
libname GEO "&root./data" ;
libname INPUTS "&raw" ;
options sasautos=(SASAUTOS, "&dirprog./macros") mautosource nocenter ps=1000;


%global tstamp;
%let t=%sysfunc(today());
%let tt=%sysfunc(time());
%let dstamp=%trim(%sysfunc(year(&t.),z4.))%trim(%sysfunc(month(&t.),z2.))%trim(%sysfunc(day(&t.),z2.));
%let tstamp=&dstamp._%trim(%sysfunc(hour(&tt.),z2.))%trim(%sysfunc(minute(&tt.),z2.))%trim(%sysfunc(second(&tt.),z2.));

