Source data
===========
Most of the JTW data can be found at https://www.census.gov/topics/employment/commuting/guidance/flows.html

1990 JTW
--------

- Source: https://www2.census.gov/programs-surveys/commuting/datasets/1990/worker-flow/usresco.txt
- Permanent source: http://doi.org/10.3886/E100617V1
- Renamed to: 1990jtw_raw.txt
- Program: module/00.dataprep/module_prepjtw1990.sas

2000 JTW
--------
We chose the files sorted by "residence county" for the entire US, at https://www.census.gov/population/www/cen2000/commuting/index.html

- Source: https://www.census.gov/population/www/cen2000/commuting/files/2KRESCO_US.txt
- Permanent source: http://doi.org/10.3886/ICPSR13405.v1
- Renamed to : jtw2000_raw.txt
- Program: module/00.dataprep/module_prepjtw2000.sas

2009-2013 ACS flows
--------------

- Source: http://www.census.gov/hhes/commuting/files/2013/Table%201%20County%20to%20County%20Commuting%20Flows-%20ACS%202009-2013.xlsx
- Permanent source: http://doi.org/10.3886/E100616V1
- Renamed to: acs_2009_2013.csv
- Program: module/00.dataprep/module_prepjtw2009.sas


LODES
-----
LODES data is published as block-to-block. We map each block to the associated county (SOURCE?) and then aggregate to the county level. 


- Source: https://lehd.ces.census.gov/data/lodes/LODES7/[state]/od/
- Alternate source: (not public) ecco:/data/lodes/v7.2
- Notes: We use 2006-2012 data in the paper
- Program: module/00.dataprep/module_preplodes.sas 

Unemployment rates
------------------

- Source:https://www.bls.gov/lau/laucnty15.txt (and other files, back to 1990, with similar year suffix)
- Alternate data: https://download.bls.gov/pub/time.series/la/la.data.0.CurrentU$arg for arg in 00-04 05-09 10-14 15-19 90-94 95-99
- Renamed to: urates_counties.csv
- Program: module/00.dataprep/module_otherdata.sas


Additional sources
------------------
Not used, but of interest:

1980 Journey to work: http://doi.org/10.3886/ICPSR08465.v2

2006 ACS flows (not used in the paper)
--------------------------------------

- Source: https://www.census.gov/population/metro/files/commuting/Table1.xlsx

