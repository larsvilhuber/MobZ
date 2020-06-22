Replication files for Section 4.1
--------------

## Data Needed

### BEA  

(datadir `raw`, as CSV)

> U.S. Bureau of Economic Analysis, “Table 30: "Economic Profile by County, 1969-2016.” (accessed Sept 1, 2017).

Directions for downloading:  https://apps.bea.gov/regional/downloadzip.cfm
 - under "Personal Income (State and Local)", select CAINC30: Economic Profile by County, then download.
 - or directly: https://apps.bea.gov/regional/zip/CAINC30.zip

Unzip, then read in CAINC30__ALL_AREAS_1969_2018.csv

```{bash}
wget https://apps.bea.gov/regional/zip/CAINC30.zip 
unzip CAINC30.zip CAINC30__ALL_AREAS_1969_2018.csv
```

### QCEW 

(datadir `raw`, as consolidated SAS data file) 

- programs that compile are from https://github.com/labordynamicsinstitute/readin_qcew_sas/releases/tag/v20200622 (https://doi.org/10.5281/zenodo.3903458)

Needs the "bls_us_county" file from LEHD/ LDI infrastructure.
