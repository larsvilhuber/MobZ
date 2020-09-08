####################################
# global libraries used everywhere #
####################################


global.libraries <- c("config","DT","tibble","dplyr","knitr")


results <- sapply(as.list(global.libraries), pkgTest)
