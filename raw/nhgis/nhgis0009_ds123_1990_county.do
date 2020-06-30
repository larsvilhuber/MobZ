* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                 ///
  str     year       1-4      ///
  str     anrca      5-6      ///
  str     aianhha    7-10     ///
  str     res_onlya  11-14    ///
  str     trusta     15-18    ///
  str     res_trsta  19-19    ///
  str     blck_grpa  20-20    ///
  str     tracta     21-26    ///
  str     cda        27-28    ///
  str     c_citya    29-33    ///
  str     county     34-90    ///
  str     countya    91-93    ///
  str     cty_suba   94-98    ///
  str     divisiona  99-99    ///
  str     msa_cmsaa  100-103  ///
  str     placea     104-108  ///
  str     pmsaa      109-112  ///
  str     regiona    113-113  ///
  str     state      114-137  ///
  str     statea     138-139  ///
  str     urbrurala  140-140  ///
  str     urb_areaa  141-144  ///
  str     zipa       145-149  ///
  str     cd103a     150-151  ///
  str     anpsadpi   152-217  ///
  double  e3g001     218-226  ///
  double  e3g002     227-235  ///
  double  e3g003     236-244  ///
  double  e3g004     245-253  ///
  double  e3g005     254-262  ///
  double  e3g006     263-271  ///
  double  e33001     272-280  ///
  double  e33002     281-289  ///
  double  e33003     290-298  ///
  double  e33004     299-307  ///
  double  e33005     308-316  ///
  double  e33006     317-325  ///
  double  e33007     326-334  ///
  double  e4i001     335-343  ///
  double  e4i002     344-352  ///
  double  e4i003     353-361  ///
  double  e4i004     362-370  ///
  double  e4i005     371-379  ///
  double  e4i006     380-388  ///
  double  e4i007     389-397  ///
  double  e4i008     398-406  ///
  double  e4p001     407-415  ///
  double  e4p002     416-424  ///
  double  e4p003     425-433  ///
  double  e4p004     434-442  ///
  double  e4p005     443-451  ///
  double  e4p006     452-460  ///
  double  e4p007     461-469  ///
  double  e4p008     470-478  ///
  double  e4p009     479-487  ///
  double  e4p010     488-496  ///
  double  e4p011     497-505  ///
  double  e4p012     506-514  ///
  double  e4p013     515-523  ///
  double  e4p014     524-532  ///
  double  e4p015     533-541  ///
  double  e4p016     542-550  ///
  double  e4p017     551-559  ///
  using `"nhgis0009_ds123_1990_county.dat"'


format e3g001    %9.0f
format e3g002    %9.0f
format e3g003    %9.0f
format e3g004    %9.0f
format e3g005    %9.0f
format e3g006    %9.0f
format e33001    %9.0f
format e33002    %9.0f
format e33003    %9.0f
format e33004    %9.0f
format e33005    %9.0f
format e33006    %9.0f
format e33007    %9.0f
format e4i001    %9.0f
format e4i002    %9.0f
format e4i003    %9.0f
format e4i004    %9.0f
format e4i005    %9.0f
format e4i006    %9.0f
format e4i007    %9.0f
format e4i008    %9.0f
format e4p001    %9.0f
format e4p002    %9.0f
format e4p003    %9.0f
format e4p004    %9.0f
format e4p005    %9.0f
format e4p006    %9.0f
format e4p007    %9.0f
format e4p008    %9.0f
format e4p009    %9.0f
format e4p010    %9.0f
format e4p011    %9.0f
format e4p012    %9.0f
format e4p013    %9.0f
format e4p014    %9.0f
format e4p015    %9.0f
format e4p016    %9.0f
format e4p017    %9.0f

label var year      `"Data File Year"'
label var anrca     `"Alaska Native Regional Corporation Code"'
label var aianhha   `"American Indian Area/Alaska Native Area/Hawaiian Home Land Code"'
label var res_onlya `"American Indian Reservation [excluding trust lands] Code"'
label var trusta    `"American Indian Reservation [trust lands only] Code"'
label var res_trsta `"Reservation/Trust Lands Code"'
label var blck_grpa `"Block Group Code"'
label var tracta    `"Census Tract Code"'
label var cda       `"Congressional District (101st) Code"'
label var c_citya   `"Consolidated City Code"'
label var county    `"County Name"'
label var countya   `"County Code"'
label var cty_suba  `"County Subdivision Code"'
label var divisiona `"Division Code"'
label var msa_cmsaa `"Metropolitan Statistical Area/Consolidated Metropolitan Statistical Area Code"'
label var placea    `"Place Code"'
label var pmsaa     `"Primary Metropolitan Statistical Area Code"'
label var regiona   `"Region Code"'
label var state     `"State Name"'
label var statea    `"State Code"'
label var urbrurala `"Urban/Rural Code"'
label var urb_areaa `"Urban Area Code"'
label var zipa      `"5-Digit ZIP Code Code"'
label var cd103a    `"Congressional District (103rd) Code"'
label var anpsadpi  `"Area Name/PSAD Term/Part Indicator"'
label var e3g001    `"Under 18 years >> Native"'
label var e3g002    `"Under 18 years >> Foreign born: Naturalized citizen"'
label var e3g003    `"Under 18 years >> Foreign born: Not a citizen"'
label var e3g004    `"18 years and over >> Native"'
label var e3g005    `"18 years and over >> Foreign born: Naturalized citizen"'
label var e3g006    `"18 years and over >> Foreign born: Not a citizen"'
label var e33001    `"Less than 9th grade"'
label var e33002    `"9th to 12th grade, no diploma"'
label var e33003    `"High school graduate (includes equivalency)"'
label var e33004    `"Some college, no degree"'
label var e33005    `"Associate degree"'
label var e33006    `"Bachelor's degree"'
label var e33007    `"Graduate or professional degree"'
label var e4i001    `"Male >> In labor force: In Armed Forces"'
label var e4i002    `"Male >> In labor force: Civilian: Employed"'
label var e4i003    `"Male >> In labor force: Civilian: Unemployed"'
label var e4i004    `"Male >> In labor force: Civilian: Not in labor force"'
label var e4i005    `"Female >> In labor force: In Armed Forces"'
label var e4i006    `"Female >> In labor force: Civilian: Employed"'
label var e4i007    `"Female >> In labor force: Civilian: Unemployed"'
label var e4i008    `"Female >> In labor force: Civilian: Not in labor force"'
label var e4p001    `"Agriculture, forestry, and fisheries (000-039)"'
label var e4p002    `"Mining (040-059)"'
label var e4p003    `"Construction (060-099)"'
label var e4p004    `"Manufacturing, nondurable goods (100-229)"'
label var e4p005    `"Manufacturing, durable goods (230-399)"'
label var e4p006    `"Transportation (400-439)"'
label var e4p007    `"Communications and other public utilities (440-499)"'
label var e4p008    `"Wholesale trade (500-579)"'
label var e4p009    `"Retail trade (580-699)"'
label var e4p010    `"Finance, insurance, and real estate (700-720)"'
label var e4p011    `"Business and repair services (721-760)"'
label var e4p012    `"Personal services (761-799)"'
label var e4p013    `"Entertainment and recreation services (800-811)"'
label var e4p014    `"Professional and related services (812-899): Health services (812-840)"'
label var e4p015    `"Professional and related services (812-899): Educational services (842-860)"'
label var e4p016    `"Professional and related services (812-899): Other professional and related serv"'
label var e4p017    `"Public administration (900-939)"'

gen fips = statea||countya 
gen female_emp = e4i006
egen manu_emp = rowsum(e4p004-e4p005)
egen total_emp = rowsum(e4p001-e4p017)
egen foreign = rowsum(e3g002 e3g003 e3g005 e3g006)
gen bachelors = rowsum(e33006 e33007)

keep female_emp manu_emp fips 

save 1990emp, replace
