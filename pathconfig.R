# ###########################
# CONFIG: define paths and filenames for later reference
# ###########################

# Change the basepath depending on your system

basepath <- rprojroot::find_root(rprojroot::has_file("pathconfig.R"))
setwd(basepath)

# Main directories
raw <- file.path(basepath, "raw")
outputs <- file.path(basepath,"data")
interwrk <- file.path(basepath, "data/interwrk")
programs <- file.path(basepath,"programs")
figures <- file.path(basepath,"figures")
aux <- file.path(basepath,"_aux")


for ( dir in list(outputs,interwrk,programs,figures)) {
	if (file.exists(dir)) {
		print(paste0("Found ",dir,": OK"))
	} else {
	warning(paste0("Warning: ",dir," does  not exist"))
	}
}



