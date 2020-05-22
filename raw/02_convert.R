# convert 2009-2013 commuting flows so SAS can read it...

library(readxl)
library(tidyr)
library(dplyr)
library(readr)

# new location
acsjtw <- "https://www2.census.gov/programs-surveys/commuting/tables/time-series/commuting-flows/table1.xlsx"

# download the file
download.file(acsjtw,"table1.xlsx")

# read it in, keeping only the variables of interest
table1 <- read_excel("table1.xlsx", 
                     sheet = "Table 1", skip = 5) %>%
  select(c(1,2,7,8,13,14))

# change the names to something shorter
names(table1) <- c("h_state_fips","h_county_fips","w_state_fips","w_county_fips","flow","moe")

# write it out.
write_csv(table1,"jtw2009_2013.csv")

         