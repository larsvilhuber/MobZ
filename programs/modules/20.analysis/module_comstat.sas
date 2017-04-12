%comstat(jtw1990);
%comstat(jtw2000);
%comstat(jtw2009);
%comstat(lodes_2006);
%comstat(lodes_2007);
%comstat(lodes_2008);
%comstat(lodes_2009);
%comstat(lodes_2010);
%comstat(lodes_2011);
%comstat(lodes_2012);

data OUTPUTS.comstat;
	set comstat_all;
run;

proc print data=OUTPUTS.comstat;
run;
