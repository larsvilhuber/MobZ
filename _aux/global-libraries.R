####################################
# global libraries used everywhere #
####################################


global.libraries <- c("config","DT","tibble","dplyr","knitr","stringr","tidyr","readxl","readr")


results <- sapply(as.list(global.libraries), pkgTest)
