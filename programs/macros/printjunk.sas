* print output to junk log;
%macro printjunk;

proc printto
    log="&dirprog./loglst/junk_&modname..log" new
    print="&dirprog./loglst/junk_&modname..lst" new;
run;

%mend printjunk;


* print to module log;
%macro printlog;

proc printto
    log="&dirprog./loglst/module_&modname..log" 
    print="&dirprog./loglst/module_&modname..lst" ;
run;

%mend printlog;
