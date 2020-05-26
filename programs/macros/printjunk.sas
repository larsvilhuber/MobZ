* print output to junk log;
%macro printjunk;

proc printto
    log="&dirprog./logs/junk_&modname..log" new
    print="&dirprog./logs/junk_&modname..lst" new;
run;

%mend printjunk;


* print to module log;
%macro printlog;

proc printto
    log="&dirprog./logs/module_&modname..log" 
    print="&dirprog./logs/module_&modname..lst" ;
run;

%mend printlog;
