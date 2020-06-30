* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                 ///
  str     year       1-4      ///
  str     state      5-28     ///
  str     statea     29-30    ///
  str     county     31-87    ///
  str     countya    88-90    ///
  str     cty_suba   91-93    ///
  str     placea     94-97    ///
  str     tracta     98-103   ///
  str     scsaa      104-104  ///
  str     smsaa      105-108  ///
  str     urb_areaa  109-112  ///
  str     blocka     113-115  ///
  str     cda        116-117  ///
  str     areaname   118-207  ///
  double  c0z001     208-215  ///
  double  c0z002     216-223  ///
  double  c06001     224-231  ///
  double  c06002     232-239  ///
  double  c06003     240-247  ///
  double  c06004     248-255  ///
  double  c06005     256-263  ///
  double  c06006     264-271  ///
  double  c06007     272-279  ///
  double  c06008     280-287  ///
  double  c06009     288-295  ///
  double  c06010     296-303  ///
  double  c09001     304-311  ///
  double  c09002     312-319  ///
  double  c09003     320-327  ///
  double  c09004     328-335  ///
  double  c09005     336-343  ///
  double  c09006     344-351  ///
  double  c09007     352-359  ///
  double  c09008     360-367  ///
  double  c09009     368-375  ///
  double  c09010     376-383  ///
  double  c09011     384-391  ///
  double  c09012     392-399  ///
  double  c09013     400-407  ///
  double  c09014     408-415  ///
  using `"nhgis0008_ds98_1970_county.dat"'


format c0z001    %8.0f
format c0z002    %8.0f
format c06001    %8.0f
format c06002    %8.0f
format c06003    %8.0f
format c06004    %8.0f
format c06005    %8.0f
format c06006    %8.0f
format c06007    %8.0f
format c06008    %8.0f
format c06009    %8.0f
format c06010    %8.0f
format c09001    %8.0f
format c09002    %8.0f
format c09003    %8.0f
format c09004    %8.0f
format c09005    %8.0f
format c09006    %8.0f
format c09007    %8.0f
format c09008    %8.0f
format c09009    %8.0f
format c09010    %8.0f
format c09011    %8.0f
format c09012    %8.0f
format c09013    %8.0f
format c09014    %8.0f

label var year      `"Data File Year"'
label var state     `"State Name"'
label var statea    `"State Code"'
label var county    `"County Name"'
label var countya   `"County Code"'
label var cty_suba  `"County Subdivision Code"'
label var placea    `"Place Code"'
label var tracta    `"Census Tract Code"'
label var scsaa     `"Standard Consolidated Statistical Area Code"'
label var smsaa     `"Standard Metropolitan Statistical Area Code"'
label var urb_areaa `"Urban Area Code"'
label var blocka    `"Block Code"'
label var cda       `"Congressional District Code"'
label var areaname  `"Area Name"'
label var c0z001    `"Native"'
label var c0z002    `"Foreign born"'
label var c06001    `"No school years completed (includes nursery and kindergarten)"'
label var c06002    `"Elementary: 1-4 years"'
label var c06003    `"Elementary: 5-6 years"'
label var c06004    `"Elementary: 7 years"'
label var c06005    `"Elementary: 8 years"'
label var c06006    `"High school: 1-3 years"'
label var c06007    `"High school: 4 years"'
label var c06008    `"College: 1-3 years"'
label var c06009    `"College: 4"'
label var c06010    `"College: 5 years or more"'
label var c09001    `"Agriculture, forestry, and fisheries"'
label var c09002    `"Mining"'
label var c09003    `"Construction"'
label var c09004    `"Manufacturing, durable goods"'
label var c09005    `"Manufacturing, nondurable goods"'
label var c09006    `"Transportation, communication, and other public utilities"'
label var c09007    `"Wholesale trade"'
label var c09008    `"Retail trade"'
label var c09009    `"Finance, insurance, and real estate"'
label var c09010    `"Business and repair services"'
label var c09011    `"Personal services"'
label var c09012    `"Entertainment and recreation services"'
label var c09013    `"Professional and related services"'
label var c09014    `"Public administration"'

gen manu_emp = c09004+c09005 
egen total_emp = rowsum(c090*) 
gen fips = statea||countya 

keep fips female_emp 
save 1970manu, replace ;
