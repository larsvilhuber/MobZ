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
  double  c3i001     208-215  ///
  double  c3i002     216-223  ///
  double  c3i003     224-231  ///
  double  c3i004     232-239  ///
  double  c3i005     240-247  ///
  double  c3i006     248-255  ///
  double  c3i007     256-263  ///
  double  c3i008     264-271  ///
  double  c3i009     272-279  ///
  double  c3i010     280-287  ///
  double  c3i011     288-295  ///
  double  c3i012     296-303  ///
  double  c3i013     304-311  ///
  double  c3i014     312-319  ///
  double  c3i015     320-327  ///
  double  c3i016     328-335  ///
  double  c3i017     336-343  ///
  double  c3i018     344-351  ///
  double  c3i019     352-359  ///
  double  c3i020     360-367  ///
  double  c3i021     368-375  ///
  double  c3i022     376-383  ///
  double  c3i023     384-391  ///
  double  c3i024     392-399  ///
  double  c3i025     400-407  ///
  double  c3i026     408-415  ///
  double  c3i027     416-423  ///
  double  c3i028     424-431  ///
  using `"nhgis0008_ds99_1970_county.dat"'


format c3i001    %8.0f
format c3i002    %8.0f
format c3i003    %8.0f
format c3i004    %8.0f
format c3i005    %8.0f
format c3i006    %8.0f
format c3i007    %8.0f
format c3i008    %8.0f
format c3i009    %8.0f
format c3i010    %8.0f
format c3i011    %8.0f
format c3i012    %8.0f
format c3i013    %8.0f
format c3i014    %8.0f
format c3i015    %8.0f
format c3i016    %8.0f
format c3i017    %8.0f
format c3i018    %8.0f
format c3i019    %8.0f
format c3i020    %8.0f
format c3i021    %8.0f
format c3i022    %8.0f
format c3i023    %8.0f
format c3i024    %8.0f
format c3i025    %8.0f
format c3i026    %8.0f
format c3i027    %8.0f
format c3i028    %8.0f

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
label var c3i001    `"Male >> Agriculture >> Employee of private company"'
label var c3i002    `"Male >> Agriculture >> Employee of own corporation"'
label var c3i003    `"Male >> Agriculture >> Federal government worker"'
label var c3i004    `"Male >> Agriculture >> State government worker"'
label var c3i005    `"Male >> Agriculture >> Local government worker"'
label var c3i006    `"Male >> Agriculture >> Self-employed worker"'
label var c3i007    `"Male >> Agriculture >> Unpaid family worker"'
label var c3i008    `"Male >> Nonagricultural industries >> Employee of private company"'
label var c3i009    `"Male >> Nonagricultural industries >> Employee of own corporation"'
label var c3i010    `"Male >> Nonagricultural industries >> Federal government worker"'
label var c3i011    `"Male >> Nonagricultural industries >> State government worker"'
label var c3i012    `"Male >> Nonagricultural industries >> Local government worker"'
label var c3i013    `"Male >> Nonagricultural industries >> Self-employed worker"'
label var c3i014    `"Male >> Nonagricultural industries >> Unpaid family worker"'
label var c3i015    `"Female >> Agriculture >> Employee of private company"'
label var c3i016    `"Female >> Agriculture >> Employee of own corporation"'
label var c3i017    `"Female >> Agriculture >> Federal government worker"'
label var c3i018    `"Female >> Agriculture >> State government worker"'
label var c3i019    `"Female >> Agriculture >> Local government worker"'
label var c3i020    `"Female >> Agriculture >> Self-employed worker"'
label var c3i021    `"Female >> Agriculture >> Unpaid family worker"'
label var c3i022    `"Female >> Nonagricultural industries >> Employee of private company"'
label var c3i023    `"Female >> Nonagricultural industries >> Employee of own corporation"'
label var c3i024    `"Female >> Nonagricultural industries >> Federal government worker"'
label var c3i025    `"Female >> Nonagricultural industries >> State government worker"'
label var c3i026    `"Female >> Nonagricultural industries >> Local government worker"'
label var c3i027    `"Female >> Nonagricultural industries >> Self-employed worker"'
label var c3i028    `"Female >> Nonagricultural industries >> Unpaid family worker"'

egen female_emp = rowsum(c3i015-c3i028) 
gen fips = statea||countya 

keep fips female_emp 

save 1970female, replace 
