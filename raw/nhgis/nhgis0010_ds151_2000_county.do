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
  str     county     33-89    ///
  str     countya    90-92    ///
  str     cty_suba   93-97    ///
  str     placea     98-102   ///
  str     tracta     103-108  ///
  str     trbl_cta   109-114  ///
  str     blck_grpa  115-115  ///
  str     trbl_bga   116-116  ///
  str     c_citya    117-121  ///
  str     aianhha    122-125  ///
  str     res_onlya  126-129  ///
  str     trusta     130-133  ///
  str     trbl_suba  134-138  ///
  str     anrca      139-143  ///
  str     msa_cmsaa  144-147  ///
  str     pmsaa      148-151  ///
  str     necmaa     152-155  ///
  str     urb_areaa  156-160  ///
  str     urbrurala  161-161  ///
  str     cd106a     162-163  ///
  str     cd108a     164-165  ///
  str     cd109a     166-167  ///
  str     zip3a      168-170  ///
  str     zctaa      171-175  ///
  str     name       176-265  ///
  double  gi8001     266-274  ///
  double  gi8002     275-283  ///
  double  gkt001     284-292  ///
  double  gkt002     293-301  ///
  double  gkt003     302-310  ///
  double  gkt004     311-319  ///
  double  gkt005     320-328  ///
  double  gkt006     329-337  ///
  double  gkt007     338-346  ///
  double  gkt008     347-355  ///
  double  gkt009     356-364  ///
  double  gkt010     365-373  ///
  double  gkt011     374-382  ///
  double  gkt012     383-391  ///
  double  gkt013     392-400  ///
  double  gkt014     401-409  ///
  double  gkt015     410-418  ///
  double  gkt016     419-427  ///
  double  gkt017     428-436  ///
  double  gkt018     437-445  ///
  double  gkt019     446-454  ///
  double  gkt020     455-463  ///
  double  gkt021     464-472  ///
  double  gkt022     473-481  ///
  double  gkt023     482-490  ///
  double  gkt024     491-499  ///
  double  gkt025     500-508  ///
  double  gkt026     509-517  ///
  double  gkt027     518-526  ///
  double  gkt028     527-535  ///
  double  gkt029     536-544  ///
  double  gkt030     545-553  ///
  double  gkt031     554-562  ///
  double  gkt032     563-571  ///
  double  gmg001     572-580  ///
  double  gmg002     581-589  ///
  double  gmh001     590-598  ///
  double  gmh002     599-607  ///
  double  gmh003     608-616  ///
  double  gmh004     617-625  ///
  double  gmh005     626-634  ///
  double  gmh006     635-643  ///
  double  gmh007     644-652  ///
  double  gmh008     653-661  ///
  double  gmh009     662-670  ///
  double  gmh010     671-679  ///
  double  gmh011     680-688  ///
  double  gmh012     689-697  ///
  double  gmh013     698-706  ///
  double  gmh014     707-715  ///
  double  gmh015     716-724  ///
  double  gmh016     725-733  ///
  double  gmh017     734-742  ///
  double  gmh018     743-751  ///
  double  gmh019     752-760  ///
  double  gmh020     761-769  ///
  double  gmh021     770-778  ///
  double  gmh022     779-787  ///
  double  gmh023     788-796  ///
  double  gmh024     797-805  ///
  double  gmh025     806-814  ///
  double  gmh026     815-823  ///
  using `"nhgis0010_ds151_2000_county.dat"'


format gi8001    %9.0f
format gi8002    %9.0f
format gkt001    %9.0f
format gkt002    %9.0f
format gkt003    %9.0f
format gkt004    %9.0f
format gkt005    %9.0f
format gkt006    %9.0f
format gkt007    %9.0f
format gkt008    %9.0f
format gkt009    %9.0f
format gkt010    %9.0f
format gkt011    %9.0f
format gkt012    %9.0f
format gkt013    %9.0f
format gkt014    %9.0f
format gkt015    %9.0f
format gkt016    %9.0f
format gkt017    %9.0f
format gkt018    %9.0f
format gkt019    %9.0f
format gkt020    %9.0f
format gkt021    %9.0f
format gkt022    %9.0f
format gkt023    %9.0f
format gkt024    %9.0f
format gkt025    %9.0f
format gkt026    %9.0f
format gkt027    %9.0f
format gkt028    %9.0f
format gkt029    %9.0f
format gkt030    %9.0f
format gkt031    %9.0f
format gkt032    %9.0f
format gmg001    %9.0f
format gmg002    %9.0f
format gmh001    %9.0f
format gmh002    %9.0f
format gmh003    %9.0f
format gmh004    %9.0f
format gmh005    %9.0f
format gmh006    %9.0f
format gmh007    %9.0f
format gmh008    %9.0f
format gmh009    %9.0f
format gmh010    %9.0f
format gmh011    %9.0f
format gmh012    %9.0f
format gmh013    %9.0f
format gmh014    %9.0f
format gmh015    %9.0f
format gmh016    %9.0f
format gmh017    %9.0f
format gmh018    %9.0f
format gmh019    %9.0f
format gmh020    %9.0f
format gmh021    %9.0f
format gmh022    %9.0f
format gmh023    %9.0f
format gmh024    %9.0f
format gmh025    %9.0f
format gmh026    %9.0f

label var year      `"Data File Year"'
label var regiona   `"Region Code"'
label var divisiona `"Division Code"'
label var state     `"State Name"'
label var statea    `"State Code"'
label var county    `"County Name"'
label var countya   `"County Code"'
label var cty_suba  `"County Subdivision Code"'
label var placea    `"Place Code"'
label var tracta    `"Census Tract Code"'
label var trbl_cta  `"Tribal Census Tract Code"'
label var blck_grpa `"Block Group Code"'
label var trbl_bga  `"Tribal Block Group Code"'
label var c_citya   `"Consolidated City Code"'
label var aianhha   `"American Indian Area/Alaska Native Area/Hawaiian Home Land Code"'
label var res_onlya `"American Indian Reservation [excluding trust lands] Code"'
label var trusta    `"American Indian Reservation [trust lands only] Code"'
label var trbl_suba `"Tribal Subdivision Code"'
label var anrca     `"Alaska Native Regional Corporation Code"'
label var msa_cmsaa `"Metropolitan Statistical Area/Consolidated Metropolitan Statistical Area Code"'
label var pmsaa     `"Primary Metropolitan Statistical Area Code"'
label var necmaa    `"New England County Metropolitan Area Code"'
label var urb_areaa `"Urban Area Code"'
label var urbrurala `"Urban/Rural Code"'
label var cd106a    `"Congressional District (106th) Code"'
label var cd108a    `"Congressional District (108th) Code"'
label var cd109a    `"Congressional District (109th) Code"'
label var zip3a     `"3-Digit Zip Code Tabulation Area Code"'
label var zctaa     `"5-Digit Zip Code Tabulation Area Code"'
label var name      `"Area Name-Legal/Statistical Area Description (LSAD) Term-Part Indicator"'
label var gi8001    `"Native"'
label var gi8002    `"Foreign born"'
label var gkt001    `"Male >> No schooling completed"'
label var gkt002    `"Male >> Nursery to 4th grade"'
label var gkt003    `"Male >> 5th and 6th grade"'
label var gkt004    `"Male >> 7th and 8th grade"'
label var gkt005    `"Male >> 9th grade"'
label var gkt006    `"Male >> 10th grade"'
label var gkt007    `"Male >> 11th grade"'
label var gkt008    `"Male >> 12th grade, no diploma"'
label var gkt009    `"Male >> High school graduate (includes equivalency)"'
label var gkt010    `"Male >> Some college, less than 1 year"'
label var gkt011    `"Male >> Some college, 1 or more years, no degree"'
label var gkt012    `"Male >> Associate degree"'
label var gkt013    `"Male >> Bachelor's degree"'
label var gkt014    `"Male >> Master's degree"'
label var gkt015    `"Male >> Professional school degree"'
label var gkt016    `"Male >> Doctorate degree"'
label var gkt017    `"Female >> No schooling completed"'
label var gkt018    `"Female >> Nursery to 4th grade"'
label var gkt019    `"Female >> 5th and 6th grade"'
label var gkt020    `"Female >> 7th and 8th grade"'
label var gkt021    `"Female >> 9th grade"'
label var gkt022    `"Female >> 10th grade"'
label var gkt023    `"Female >> 11th grade"'
label var gkt024    `"Female >> 12th grade, no diploma"'
label var gkt025    `"Female >> High school graduate (includes equivalency)"'
label var gkt026    `"Female >> Some college, less than 1 year"'
label var gkt027    `"Female >> Some college, 1 or more years, no degree"'
label var gkt028    `"Female >> Associate degree"'
label var gkt029    `"Female >> Bachelor's degree"'
label var gkt030    `"Female >> Master's degree"'
label var gkt031    `"Female >> Professional school degree"'
label var gkt032    `"Female >> Doctorate degree"'
label var gmg001    `"Male"'
label var gmg002    `"Female"'
label var gmh001    `"Male >> Agriculture, forestry, fishing and hunting, and mining"'
label var gmh002    `"Male >> Construction"'
label var gmh003    `"Male >> Manufacturing"'
label var gmh004    `"Male >> Wholesale trade"'
label var gmh005    `"Male >> Retail trade"'
label var gmh006    `"Male >> Transportation and warehousing, and utilities"'
label var gmh007    `"Male >> Information"'
label var gmh008    `"Male >> Finance, insurance, real estate and rental and leasing"'
label var gmh009    `"Male >> Professional, scientific, management, administrative, and waste manageme"'
label var gmh010    `"Male >> Educational, health and social services"'
label var gmh011    `"Male >> Arts, entertainment, recreation, accommodation and food services"'
label var gmh012    `"Male >> Other services (except public administration)"'
label var gmh013    `"Male >> Public administration"'
label var gmh014    `"Female >> Agriculture, forestry, fishing and hunting, and mining"'
label var gmh015    `"Female >> Construction"'
label var gmh016    `"Female >> Manufacturing"'
label var gmh017    `"Female >> Wholesale trade"'
label var gmh018    `"Female >> Retail trade"'
label var gmh019    `"Female >> Transportation and warehousing, and utilities"'
label var gmh020    `"Female >> Information"'
label var gmh021    `"Female >> Finance, insurance, real estate and rental and leasing"'
label var gmh022    `"Female >> Professional, scientific, management, administrative, and waste manage"'
label var gmh023    `"Female >> Educational, health and social services"'
label var gmh024    `"Female >> Arts, entertainment, recreation, accommodation and food services"'
label var gmh025    `"Female >> Other services (except public administration)"'
label var gmh026    `"Female >> Public administration"'

gen foreign = gi8002
egen bachelors = rowtotal(gkt013-gkt016 gkt029-gkt032)
egen total_emp = rowtotal(gmh001-gmh026)
egen female_emp = rowtotal(gmh014-gmh026)
egen manu_emp = rowtotal(gmh003 gmh016) 

gen fips = statea+countya 

keep fips foreign bachelors total_emp female_emp manu_emp

save 2000emp, replace 
