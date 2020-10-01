/*  config.do */



if ( "`c(hostname)'" == "ecco.vrdc.cornell.edu" ) {
global root "/ssgprojects/project0002/MobZ.new"
}

if ( "`c(username)'" == "vilhuber" ) {
global root "/home/vilhuber/Workspace/git/larsvilhuber/MobZ"
}

if ( "`c(hostname)'" == "some.server.at.census" ) {
global root "/made/up/path/Mobz"
}

/* check if the author creates a log file. If not, adjust the following code fragment */

local c_date = c(current_date)
local cdate = subinstr("`c_date'", " ", "_", .)
local c_time = c(current_time)
local ctime = subinstr("`c_time'", ":", "_", .)

// log using "${root}/logfile_`cdate'-`ctime'.log", replace text

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




/* define relative libraries */

global paperdir "${root}/paper"
global interwrk "${root}/data/interwrk"
global raw "${root}/raw"
global temp "${root}/temp"
global outputs "${root}/data"
global programs "${root}/programs"
global outgraphs "${root}/figures"
global logdir "${programs}/logs"

cap mkdir "$logdir"
log using "${logdir}/logfile_`cdate'-`ctime'.log", replace text
cap mkdir "$temp"
cap mkdir "${root}/data"
cap mkdir "$interwrk"
cap mkdir "$raw"
cap mkdir "$outputs"

/* install any packages locally */
capture mkdir "${programs}/ado"
sysdir set PERSONAL "${programs}/ado/personal"
sysdir set PLUS     "${programs}/ado/plus"
sysdir set SITE     "${programs}/ado/site"
sysdir

/* define data sources */

/* QCEW */
/* data/working/mobz/qcew */
    global qcewdata "${raw}/qcew"  
/* /data/working/mobz/outputs */
    global czonedata "$outputs"  

/* ADH */
    global adhdata "${raw}/adh_data/Public Release Data/dta"
/* CZONE */
    global czonedata "${raw}/adh_data/"
/* files provided separately by David Dorn */
    global dorndata "${raw}/ddorn/"

/* CBP */
    /* this is where the raw Stata versions of CBP data reside */
   global cbpdata "/data/clean/cbp"

/* for graphing */
/* from https://github.com/graykimbrough/uncluttered-stata-graphs */

set scheme uncluttered
