%let root = /ssgprojects/project0002/MobZ ; 
%let raw=&dirdata./raw ;
%let dirprog=&root/programs;


libname OUTPUTS "&dirdata./data";
libname GEO "&dirdata./data" ;
libname INPUTS "&raw" ;
options sasautos=(SASAUTOS, "&dirprog./macros") mautosource nocenter ps=1000;
