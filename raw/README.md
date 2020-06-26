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



Unemployment rates
------------------

- Source:https://www.bls.gov/lau/laucnty15.txt (and other files, back to 1990, with similar year suffix)
- Alternate data: https://download.bls.gov/pub/time.series/la/la.data.0.CurrentU$arg for arg in 00-04 05-09 10-14 15-19 90-94 95-99
- Renamed to: urates_counties.csv
- Program: module/00.dataprep/module_otherdata.sas

BEA  
---


> U.S. Bureau of Economic Analysis, “Table 30: "Economic Profile by County, 1969-2016.” (accessed Sept 1, 2017).

Directions for downloading:  https://apps.bea.gov/regional/downloadzip.cfm
 - under "Personal Income (State and Local)", select CAINC30: Economic Profile by County, then download.
 - or directly: https://apps.bea.gov/regional/zip/CAINC30.zip

Unzip, then read in CAINC30__ALL_AREAS_1969_2018.csv

```{bash}
wget https://apps.bea.gov/regional/zip/CAINC30.zip 
unzip CAINC30.zip CAINC30__ALL_AREAS_1969_2018.csv
```

QCEW
----


- programs that compile are from https://github.com/labordynamicsinstitute/readin_qcew_sas/releases/tag/v20200622 (https://doi.org/10.5281/zenodo.3903458)

The `bls_us_county.sas7bdat` file from that program sequence should be provided here.

ADH-related files
-----------------

cw_cty_czone.dta is from here: https://www.ddorn.net/data/cw_cty_czone.zip


Additional sources
------------------
Not used, but of interest:

1980 Journey to work: http://doi.org/10.3886/ICPSR08465.v2

2006 ACS flows (not used in the paper)
--------------------------------------

- Source: https://www.census.gov/population/metro/files/commuting/Table1.xlsx

