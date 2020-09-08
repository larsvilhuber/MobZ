#' Various functions common to readin of the uncertainty data
#' needs to be included (not a proper package)
#' 



pkgTest <- function(x,try=FALSE)
{
	if (!require(x,character.only = TRUE))
	{
		install.packages(x,dep=TRUE)
		if(!require(x,character.only = TRUE)) stop("Package not found")
	}
  if ( try ) {
    print(paste0("Unloading ",x))
    detach(paste0("package:",x), unload = TRUE, character.only = TRUE)
  }
  return("OK")
}

