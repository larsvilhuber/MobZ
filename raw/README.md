Source data
===========
Most of the JTW data can be found at https://www.census.gov/hhes/commuting/data/commuting.html

1990 JTW
--------

- Source: https://www.census.gov/hhes/commuting/files/1990/resco/USresco.txt
- Renamed to: 1990jtw_raw.txt
- Program: module/00.dataprep/module_prepjtw1990.sas

2000 JTW
--------
We chose the files sorted by "residence county" for the entire US, at https://www.census.gov/population/www/cen2000/commuting/index.html

- Source: https://www.census.gov/population/www/cen2000/commuting/files/2KRESCO_US.txt
- Renamed to : jtw2000_raw.txt
- Program: module/00.dataprep/module_prepjtw2000.sas

2009 ACS flows
--------------

- Source: 
- Renamed to: acs_2009_2013.csv
- Program: module/00.dataprep/module_prepjtw2009.sas

2006 ACS flows (not used in the paper)
--------------------------------------

- Source: https://www.census.gov/population/metro/files/commuting/Table1.xlsx

LODES
-----
LODES data is published as block-to-block. We map each block to the associated county (SOURCE?) and then aggregate to the county level. 


- Source
- Program: module/00.dataprep/module_preplodes.sas 

Unemployment rates
------------------

- Source:
- Renamed to: urates_counties.csv
- Program: module/00.dataprep/module_otherdata.sas

