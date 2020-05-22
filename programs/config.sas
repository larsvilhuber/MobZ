%let root = /ssgprojects/project0002/MobZ.new ; 
%let raw=&root./raw ;
%let dirprog=&root/programs;


libname OUTPUTS "&root./data";
libname GEO "&root./data" ;
libname INPUTS "&raw" ;
options sasautos=(SASAUTOS, "&dirprog./macros") mautosource nocenter ps=1000;
