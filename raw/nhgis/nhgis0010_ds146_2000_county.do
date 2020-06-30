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
  str     cd106a     161-162  ///
  str     cd108a     163-164  ///
  str     cd109a     165-166  ///
  str     zip3a      167-169  ///
  str     zctaa      170-174  ///
  str     name       175-264  ///
  double  fmz001     265-273  ///
  double  fmz002     274-282  ///
  double  fmz003     283-291  ///
  double  fmz004     292-300  ///
  double  fmz005     301-309  ///
  double  fmz006     310-318  ///
  double  fmz007     319-327  ///
  double  fmz008     328-336  ///
  double  fmz009     337-345  ///
  double  fmz010     346-354  ///
  double  fmz011     355-363  ///
  double  fmz012     364-372  ///
  double  fmz013     373-381  ///
  double  fmz014     382-390  ///
  double  fmz015     391-399  ///
  double  fmz016     400-408  ///
  double  fmz017     409-417  ///
  double  fmz018     418-426  ///
  double  fmz019     427-435  ///
  double  fmz020     436-444  ///
  double  fmz021     445-453  ///
  double  fmz022     454-462  ///
  double  fmz023     463-471  ///
  double  fmz024     472-480  ///
  double  fmz025     481-489  ///
  double  fmz026     490-498  ///
  double  fmz027     499-507  ///
  double  fmz028     508-516  ///
  double  fmz029     517-525  ///
  double  fmz030     526-534  ///
  double  fmz031     535-543  ///
  double  fmz032     544-552  ///
  double  fmz033     553-561  ///
  double  fmz034     562-570  ///
  double  fmz035     571-579  ///
  double  fmz036     580-588  ///
  double  fmz037     589-597  ///
  double  fmz038     598-606  ///
  double  fmz039     607-615  ///
  double  fmz040     616-624  ///
  double  fmz041     625-633  ///
  double  fmz042     634-642  ///
  double  fmz043     643-651  ///
  double  fmz044     652-660  ///
  double  fmz045     661-669  ///
  double  fmz046     670-678  ///
  using `"nhgis0010_ds146_2000_county.dat"'


format fmz001    %9.0f
format fmz002    %9.0f
format fmz003    %9.0f
format fmz004    %9.0f
format fmz005    %9.0f
format fmz006    %9.0f
format fmz007    %9.0f
format fmz008    %9.0f
format fmz009    %9.0f
format fmz010    %9.0f
format fmz011    %9.0f
format fmz012    %9.0f
format fmz013    %9.0f
format fmz014    %9.0f
format fmz015    %9.0f
format fmz016    %9.0f
format fmz017    %9.0f
format fmz018    %9.0f
format fmz019    %9.0f
format fmz020    %9.0f
format fmz021    %9.0f
format fmz022    %9.0f
format fmz023    %9.0f
format fmz024    %9.0f
format fmz025    %9.0f
format fmz026    %9.0f
format fmz027    %9.0f
format fmz028    %9.0f
format fmz029    %9.0f
format fmz030    %9.0f
format fmz031    %9.0f
format fmz032    %9.0f
format fmz033    %9.0f
format fmz034    %9.0f
format fmz035    %9.0f
format fmz036    %9.0f
format fmz037    %9.0f
format fmz038    %9.0f
format fmz039    %9.0f
format fmz040    %9.0f
format fmz041    %9.0f
format fmz042    %9.0f
format fmz043    %9.0f
format fmz044    %9.0f
format fmz045    %9.0f
format fmz046    %9.0f

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
label var cd106a    `"Congressional District (106th) Code"'
label var cd108a    `"Congressional District (108th) Code"'
label var cd109a    `"Congressional District (109th) Code"'
label var zip3a     `"3-Digit Zip Code Tabulation Area Code"'
label var zctaa     `"5-Digit Zip Code Tabulation Area Code"'
label var name      `"Area Name-Legal/Statistical Area Description (LSAD) Term-Part Indicator"'
label var fmz001    `"Male >> Under 5 years"'
label var fmz002    `"Male >> 5 to 9 years"'
label var fmz003    `"Male >> 10 to 14 years"'
label var fmz004    `"Male >> 15 to 17 years"'
label var fmz005    `"Male >> 18 and 19 years"'
label var fmz006    `"Male >> 20 years"'
label var fmz007    `"Male >> 21 years"'
label var fmz008    `"Male >> 22 to 24 years"'
label var fmz009    `"Male >> 25 to 29 years"'
label var fmz010    `"Male >> 30 to 34 years"'
label var fmz011    `"Male >> 35 to 39 years"'
label var fmz012    `"Male >> 40 to 44 years"'
label var fmz013    `"Male >> 45 to 49 years"'
label var fmz014    `"Male >> 50 to 54 years"'
label var fmz015    `"Male >> 55 to 59 years"'
label var fmz016    `"Male >> 60 and 61 years"'
label var fmz017    `"Male >> 62 to 64 years"'
label var fmz018    `"Male >> 65 and 66 years"'
label var fmz019    `"Male >> 67 to 69 years"'
label var fmz020    `"Male >> 70 to 74 years"'
label var fmz021    `"Male >> 75 to 79 years"'
label var fmz022    `"Male >> 80 to 84 years"'
label var fmz023    `"Male >> 85 years and over"'
label var fmz024    `"Female >> Under 5 years"'
label var fmz025    `"Female >> 5 to 9 years"'
label var fmz026    `"Female >> 10 to 14 years"'
label var fmz027    `"Female >> 15 to 17 years"'
label var fmz028    `"Female >> 18 and 19 years"'
label var fmz029    `"Female >> 20 years"'
label var fmz030    `"Female >> 21 years"'
label var fmz031    `"Female >> 22 to 24 years"'
label var fmz032    `"Female >> 25 to 29 years"'
label var fmz033    `"Female >> 30 to 34 years"'
label var fmz034    `"Female >> 35 to 39 years"'
label var fmz035    `"Female >> 40 to 44 years"'
label var fmz036    `"Female >> 45 to 49 years"'
label var fmz037    `"Female >> 50 to 54 years"'
label var fmz038    `"Female >> 55 to 59 years"'
label var fmz039    `"Female >> 60 and 61 years"'
label var fmz040    `"Female >> 62 to 64 years"'
label var fmz041    `"Female >> 65 and 66 years"'
label var fmz042    `"Female >> 67 to 69 years"'
label var fmz043    `"Female >> 70 to 74 years"'
label var fmz044    `"Female >> 75 to 79 years"'
label var fmz045    `"Female >> 80 to 84 years"'
label var fmz046    `"Female >> 85 years and over"'

gen fips = statea+countya 
egen female_pop_16_65 = rowtotal(fmz027-fmz040)
egen pop_16_65 = rowtotal(fmz004-fmz017 fmz027-fmz040)

keep fips female_pop_16_65 pop_16_65

save 2000pop, replace