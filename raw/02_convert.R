# convert 2009-2013 commuting flows so SAS can read it...

source(file.path(rprojroot::find_root(rprojroot::has_file("pathconfig.R")),"pathconfig.R"),echo=TRUE)
source(file.path(aux,"config.R"),echo=TRUE)
source(file.path(aux,"common-functions.R"),echo=TRUE)
local.libraries <- c("readxl","tidyr","readr","dplyr")

results <- sapply(as.list(local.libraries), pkgTest)

library(readxl)
library(tidyr)
library(dplyr)
library(readr)

# new location
acsjtw <- "https://www2.census.gov/programs-surveys/commuting/tables/time-series/commuting-flows/table1.xlsx"

# download the file
download.file(acsjtw,file.path(raw,"table1.xlsx"))

# read it in, keeping only the variables of interest
table1 <- read_excel(file.path(raw,"table1.xlsx"), 
                     sheet = "Table 1", skip = 5) %>%
  select(c(1,2,7,8,13,14))

# change the names to something shorter
names(table1) <- c("h_state_fips","h_county_fips","w_state_fips","w_county_fips","flow","moe")

# write it out.
write_csv(table1,file.path(raw,"jtw2009_2013.csv"))

         