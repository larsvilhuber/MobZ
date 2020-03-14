/*  config.do */

local pwd : pwd
/* use this if using Unix-like system from the command line - no further adjustment necessary */

global root "`pwd'"

/* use this instead of running on Windows */

// global root "/path/to/project"

/* check if the author creates a log file. If not, adjust the following code fragment */

local c_date = c(current_date)
local cdate = subinstr("`c_date'", " ", "_", .)
local c_time = c(current_time)
local ctime = subinstr("`c_time'", ":", "_", .)

log using "${root}/logfile_`cdate'-`ctime'.log", replace text

/* It will provide some info about how and when the program was run */
/* See https://www.stata.com/manuals13/pcreturn.pdf#pcreturn */
local variant = cond(c(MP),"MP",cond(c(SE),"SE",c(flavor)) )  
// alternatively, you could use 
// local variant = cond(c(stata_version)>13,c(real_flavor),"NA")  

di "=== SYSTEM DIAGNOSTICS ==="
di "Stata version: `c(stata_version)'"
di "Updated as of: `c(born_date)'"
di "Variant:       `variant'"
di "Processors:    `c(processors)'"
di "OS:            `c(os)' `c(osdtl)'"
di "Machine type:  `c(machine_type)'"
di "=========================="


/* install any packages locally */
capture mkdir "${root}/ado"
sysdir set PERSONAL "${root}/ado/personal"
sysdir set PLUS     "${root}/ado/plus"
sysdir set SITE     "${root}/ado/site"
sysdir

/* define relative libraries */

global interwrk "${root}/data"
global raw "${root}/raw"
global temp "${root}/temp"
cap mkdir $temp


