* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                 ///
  str     year       1-4      ///
  str     regiona    5-5      ///
  str     divisiona  6-6      ///
  str     state      7-30     ///
  str     statea     31-32    ///
  str     smsaa      33-36    ///
  str     county     37-93    ///
  str     countya    94-96    ///
  str     cty_suba   97-99    ///
  str     placea     100-103  ///
  str     tracta     104-109  ///
  str     blck_grpa  110-110  ///
  str     enumdista  111-111  ///
  str     scsaa      112-113  ///
  str     urb_areaa  114-117  ///
  str     cda        118-119  ///
  str     aianhha    120-122  ///
  str     mcdseqnoa  123-126  ///
  str     zipa       127-131  ///
  str     areaname   132-191  ///
  double  dg6001     192-200  ///
  double  dg6002     201-209  ///
  double  dg6003     210-218  ///
  double  dg6004     219-227  ///
  double  dhm001     228-236  ///
  double  dhm002     237-245  ///
  double  dhm003     246-254  ///
  double  dhm004     255-263  ///
  double  dhm005     264-272  ///
  double  dhx001     273-281  ///
  double  dhx002     282-290  ///
  double  dhx003     291-299  ///
  double  dhx004     300-308  ///
  double  dhx005     309-317  ///
  double  dhx006     318-326  ///
  double  dhx007     327-335  ///
  double  dhx008     336-344  ///
  double  dia001     345-353  ///
  double  dia002     354-362  ///
  double  dia003     363-371  ///
  double  dia004     372-380  ///
  double  dia005     381-389  ///
  double  dia006     390-398  ///
  double  dia007     399-407  ///
  double  dia008     408-416  ///
  double  dia009     417-425  ///
  double  dia010     426-434  ///
  double  dia011     435-443  ///
  double  dia012     444-452  ///
  double  dia013     453-461  ///
  double  dia014     462-470  ///
  double  dia015     471-479  ///
  using `"nhgis0012_ds107_1980_county.dat"'


format dg6001    %9.0f
format dg6002    %9.0f
format dg6003    %9.0f
format dg6004    %9.0f
format dhm001    %9.0f
format dhm002    %9.0f
format dhm003    %9.0f
format dhm004    %9.0f
format dhm005    %9.0f
format dhx001    %9.0f
format dhx002    %9.0f
format dhx003    %9.0f
format dhx004    %9.0f
format dhx005    %9.0f
format dhx006    %9.0f
format dhx007    %9.0f
format dhx008    %9.0f
format dia001    %9.0f
format dia002    %9.0f
format dia003    %9.0f
format dia004    %9.0f
format dia005    %9.0f
format dia006    %9.0f
format dia007    %9.0f
format dia008    %9.0f
format dia009    %9.0f
format dia010    %9.0f
format dia011    %9.0f
format dia012    %9.0f
format dia013    %9.0f
format dia014    %9.0f
format dia015    %9.0f

label var year      `"Data File Year"'
label var regiona   `"Region Code"'
label var divisiona `"Division Code"'
label var state     `"State Name"'
label var statea    `"State Code"'
label var smsaa     `"Standard Metropolitan Statistical Area Code"'
label var county    `"County Name"'
label var countya   `"County Code"'
label var cty_suba  `"County Subdivision Code"'
label var placea    `"Place Code"'
label var tracta    `"Census Tract Code"'
label var blck_grpa `"Block Group Code"'
label var enumdista `"Enumeration District Code"'
label var scsaa     `"Standard Consolidated Statistical Area Code"'
label var urb_areaa `"Urban Area Code"'
label var cda       `"Congressional District Code"'
label var aianhha   `"American Indian Area/Alaska Native Area/Hawaiian Home Land Code"'
label var mcdseqnoa `"MCD Sequence Number Code"'
label var zipa      `"5-Digit Zip Code Code"'
label var areaname  `"Area Name"'
label var dg6001    `"Native: Born in state of residence"'
label var dg6002    `"Native: Born in different state"'
label var dg6003    `"Native: Born abroad, at sea, etc."'
label var dg6004    `"Foreign born"'
label var dhm001    `"Elementary (0-8 years)"'
label var dhm002    `"High school: 1-3 years"'
label var dhm003    `"High school: 4 years"'
label var dhm004    `"College: 1-3 years"'
label var dhm005    `"College: 4 or more years"'
label var dhx001    `"Male >> Labor force: Armed forces"'
label var dhx002    `"Male >> Labor force: Civilian labor force: Employed"'
label var dhx003    `"Male >> Labor force: Civilian labor force: Unemployed"'
label var dhx004    `"Male >> Not in labor force"'
label var dhx005    `"Female >> Labor force: Armed forces"'
label var dhx006    `"Female >> Labor force: Civilian labor force: Employed"'
label var dhx007    `"Female >> Labor force: Civilian labor force: Unemployed"'
label var dhx008    `"Female >> Not in labor force"'
label var dia001    `"Agriculture, forestry, fisheries and mining (codes 10-50)"'
label var dia002    `"Construction (code 60)"'
label var dia003    `"Manufacturing: Nondurable goods (codes 100-222)"'
label var dia004    `"Manufacturing: Durable goods (codes 230-392)"'
label var dia005    `"Transportation (codes 400-432)"'
label var dia006    `"Communications and other public utilities (codes 440-472)"'
label var dia007    `"Wholesale trade (codes 500-571)"'
label var dia008    `"Retail trade (codes 580-691)"'
label var dia009    `"Finance, insurance and real estate (codes 700-172)"'
label var dia010    `"Business and repair services (codes 721-760)"'
label var dia011    `"Personal, entertainment and recreation services (codes 761-802)"'
label var dia012    `"Professional and related services: Health services (codes 812-840)"'
label var dia013    `"Professional and related services: Educational services (codes 842-860)"'
label var dia014    `"Professional and related services: Other professional and related services (code"'
label var dia015    `"Public administration (codes 900-932)"'

gen fips = statea+countya 
egen female_emp = rowtotal(dhx006)
egen manu_emp = rowtotal(dia003 dia004)
gen foreign = dg6004 
gen bachelors = dhm005
egen total_emp = rowtotal(dhx002 dhx006)
keep fips female_emp manu_emp foreign bachelors total_emp

save 1980manu, replace 
