* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                   ///
  str     year       1-9        ///
  str     regiona    10-10      ///
  str     divisiona  11-11      ///
  str     state      12-35      ///
  str     statea     36-37      ///
  str     county     38-94      ///
  str     countya    95-97      ///
  str     cousuba    98-102     ///
  str     placea     103-107    ///
  str     tracta     108-113    ///
  str     blkgrpa    114-114    ///
  str     concita    115-119    ///
  str     aianhha    120-123    ///
  str     res_onlya  124-127    ///
  str     trusta     128-131    ///
  str     aitscea    132-134    ///
  str     anrca      135-139    ///
  str     cbsaa      140-144    ///
  str     csaa       145-147    ///
  str     metdiva    148-152    ///
  str     nectaa     153-157    ///
  str     cnectaa    158-160    ///
  str     nectadiva  161-165    ///
  str     uaa        166-170    ///
  str     cdcurra    171-172    ///
  str     sldua      173-175    ///
  str     sldla      176-178    ///
  str     submcda    179-183    ///
  str     sdelma     184-188    ///
  str     sdseca     189-193    ///
  str     sdunia     194-198    ///
  str     puma5a     199-203    ///
  str     name_e     204-403    ///
  double  rkye001    404-412    ///
  double  rkye002    413-421    ///
  double  rkye003    422-430    ///
  double  rkye004    431-439    ///
  double  rkye005    440-448    ///
  double  rkye006    449-457    ///
  double  rkye007    458-466    ///
  double  rkye008    467-475    ///
  double  rkye009    476-484    ///
  double  rkye010    485-493    ///
  double  rkye011    494-502    ///
  double  rkye012    503-511    ///
  double  rkye013    512-520    ///
  double  rkye014    521-529    ///
  double  rkye015    530-538    ///
  double  rkye016    539-547    ///
  double  rkye017    548-556    ///
  double  rkye018    557-565    ///
  double  rkye019    566-574    ///
  double  rkye020    575-583    ///
  double  rkye021    584-592    ///
  double  rkye022    593-601    ///
  double  rkye023    602-610    ///
  double  rkye024    611-619    ///
  double  rkye025    620-628    ///
  double  rkye026    629-637    ///
  double  rkye027    638-646    ///
  double  rkye028    647-655    ///
  double  rkye029    656-664    ///
  double  rkye030    665-673    ///
  double  rkye031    674-682    ///
  double  rkye032    683-691    ///
  double  rkye033    692-700    ///
  double  rkye034    701-709    ///
  double  rkye035    710-718    ///
  double  rkye036    719-727    ///
  double  rkye037    728-736    ///
  double  rkye038    737-745    ///
  double  rkye039    746-754    ///
  double  rkye040    755-763    ///
  double  rkye041    764-772    ///
  double  rkye042    773-781    ///
  double  rkye043    782-790    ///
  double  rkye044    791-799    ///
  double  rkye045    800-808    ///
  double  rkye046    809-817    ///
  double  rkye047    818-826    ///
  double  rkye048    827-835    ///
  double  rkye049    836-844    ///
  double  rm8e001    845-853    ///
  double  rm8e002    854-862    ///
  double  rm8e003    863-871    ///
  double  rm8e004    872-880    ///
  double  rm8e005    881-889    ///
  double  rm8e006    890-898    ///
  double  rm8e007    899-907    ///
  double  rm8e008    908-916    ///
  double  rm8e009    917-925    ///
  double  rm8e010    926-934    ///
  double  rm8e011    935-943    ///
  double  rm8e012    944-952    ///
  double  rm8e013    953-961    ///
  double  rm8e014    962-970    ///
  double  rm8e015    971-979    ///
  double  rm8e016    980-988    ///
  double  rm8e017    989-997    ///
  double  rm8e018    998-1006   ///
  double  rm8e019    1007-1015  ///
  double  rm8e020    1016-1024  ///
  double  rm8e021    1025-1033  ///
  double  rm8e022    1034-1042  ///
  double  rm8e023    1043-1051  ///
  double  rm8e024    1052-1060  ///
  double  rm8e025    1061-1069  ///
  double  rm8e026    1070-1078  ///
  double  rm8e027    1079-1087  ///
  double  rm8e028    1088-1096  ///
  double  rm8e029    1097-1105  ///
  double  rm8e030    1106-1114  ///
  double  rm8e031    1115-1123  ///
  double  rm8e032    1124-1132  ///
  double  rm8e033    1133-1141  ///
  double  rm8e034    1142-1150  ///
  double  rm8e035    1151-1159  ///
  double  rp5e001    1160-1168  ///
  double  rp5e002    1169-1177  ///
  double  rp5e003    1178-1186  ///
  double  rp5e004    1187-1195  ///
  double  rp5e005    1196-1204  ///
  double  rp5e006    1205-1213  ///
  double  rp5e007    1214-1222  ///
  double  rp5e008    1223-1231  ///
  double  rp5e009    1232-1240  ///
  double  rp5e010    1241-1249  ///
  double  rp5e011    1250-1258  ///
  double  rp5e012    1259-1267  ///
  double  rp5e013    1268-1276  ///
  double  rp5e014    1277-1285  ///
  double  rp5e015    1286-1294  ///
  double  rp5e016    1295-1303  ///
  double  rp5e017    1304-1312  ///
  double  rp5e018    1313-1321  ///
  double  rp5e019    1322-1330  ///
  double  rp5e020    1331-1339  ///
  double  rp5e021    1340-1348  ///
  double  rp5e022    1349-1357  ///
  double  rp5e023    1358-1366  ///
  double  rp5e024    1367-1375  ///
  double  rp5e025    1376-1384  ///
  double  rp5e026    1385-1393  ///
  double  rp5e027    1394-1402  ///
  double  rp5e028    1403-1411  ///
  double  rp5e029    1412-1420  ///
  double  rp5e030    1421-1429  ///
  double  rp5e031    1430-1438  ///
  double  rp5e032    1439-1447  ///
  double  rp5e033    1448-1456  ///
  double  rp5e034    1457-1465  ///
  double  rp5e035    1466-1474  ///
  double  rp5e036    1475-1483  ///
  double  rp5e037    1484-1492  ///
  double  rp5e038    1493-1501  ///
  double  rp5e039    1502-1510  ///
  double  rp5e040    1511-1519  ///
  double  rp5e041    1520-1528  ///
  double  rp5e042    1529-1537  ///
  double  rp5e043    1538-1546  ///
  double  rp5e044    1547-1555  ///
  double  rp5e045    1556-1564  ///
  double  rp5e046    1565-1573  ///
  double  rp5e047    1574-1582  ///
  double  rp5e048    1583-1591  ///
  double  rp5e049    1592-1600  ///
  double  rp5e050    1601-1609  ///
  double  rp5e051    1610-1618  ///
  double  rp5e052    1619-1627  ///
  double  rp5e053    1628-1636  ///
  double  rp5e054    1637-1645  ///
  double  rp5e055    1646-1654  ///
  str     name_m     1655-1854  ///
  double  rkym001    1855-1863  ///
  double  rkym002    1864-1872  ///
  double  rkym003    1873-1881  ///
  double  rkym004    1882-1890  ///
  double  rkym005    1891-1899  ///
  double  rkym006    1900-1908  ///
  double  rkym007    1909-1917  ///
  double  rkym008    1918-1926  ///
  double  rkym009    1927-1935  ///
  double  rkym010    1936-1944  ///
  double  rkym011    1945-1953  ///
  double  rkym012    1954-1962  ///
  double  rkym013    1963-1971  ///
  double  rkym014    1972-1980  ///
  double  rkym015    1981-1989  ///
  double  rkym016    1990-1998  ///
  double  rkym017    1999-2007  ///
  double  rkym018    2008-2016  ///
  double  rkym019    2017-2025  ///
  double  rkym020    2026-2034  ///
  double  rkym021    2035-2043  ///
  double  rkym022    2044-2052  ///
  double  rkym023    2053-2061  ///
  double  rkym024    2062-2070  ///
  double  rkym025    2071-2079  ///
  double  rkym026    2080-2088  ///
  double  rkym027    2089-2097  ///
  double  rkym028    2098-2106  ///
  double  rkym029    2107-2115  ///
  double  rkym030    2116-2124  ///
  double  rkym031    2125-2133  ///
  double  rkym032    2134-2142  ///
  double  rkym033    2143-2151  ///
  double  rkym034    2152-2160  ///
  double  rkym035    2161-2169  ///
  double  rkym036    2170-2178  ///
  double  rkym037    2179-2187  ///
  double  rkym038    2188-2196  ///
  double  rkym039    2197-2205  ///
  double  rkym040    2206-2214  ///
  double  rkym041    2215-2223  ///
  double  rkym042    2224-2232  ///
  double  rkym043    2233-2241  ///
  double  rkym044    2242-2250  ///
  double  rkym045    2251-2259  ///
  double  rkym046    2260-2268  ///
  double  rkym047    2269-2277  ///
  double  rkym048    2278-2286  ///
  double  rkym049    2287-2295  ///
  double  rm8m001    2296-2304  ///
  double  rm8m002    2305-2313  ///
  double  rm8m003    2314-2322  ///
  double  rm8m004    2323-2331  ///
  double  rm8m005    2332-2340  ///
  double  rm8m006    2341-2349  ///
  double  rm8m007    2350-2358  ///
  double  rm8m008    2359-2367  ///
  double  rm8m009    2368-2376  ///
  double  rm8m010    2377-2385  ///
  double  rm8m011    2386-2394  ///
  double  rm8m012    2395-2403  ///
  double  rm8m013    2404-2412  ///
  double  rm8m014    2413-2421  ///
  double  rm8m015    2422-2430  ///
  double  rm8m016    2431-2439  ///
  double  rm8m017    2440-2448  ///
  double  rm8m018    2449-2457  ///
  double  rm8m019    2458-2466  ///
  double  rm8m020    2467-2475  ///
  double  rm8m021    2476-2484  ///
  double  rm8m022    2485-2493  ///
  double  rm8m023    2494-2502  ///
  double  rm8m024    2503-2511  ///
  double  rm8m025    2512-2520  ///
  double  rm8m026    2521-2529  ///
  double  rm8m027    2530-2538  ///
  double  rm8m028    2539-2547  ///
  double  rm8m029    2548-2556  ///
  double  rm8m030    2557-2565  ///
  double  rm8m031    2566-2574  ///
  double  rm8m032    2575-2583  ///
  double  rm8m033    2584-2592  ///
  double  rm8m034    2593-2601  ///
  double  rm8m035    2602-2610  ///
  double  rp5m001    2611-2619  ///
  double  rp5m002    2620-2628  ///
  double  rp5m003    2629-2637  ///
  double  rp5m004    2638-2646  ///
  double  rp5m005    2647-2655  ///
  double  rp5m006    2656-2664  ///
  double  rp5m007    2665-2673  ///
  double  rp5m008    2674-2682  ///
  double  rp5m009    2683-2691  ///
  double  rp5m010    2692-2700  ///
  double  rp5m011    2701-2709  ///
  double  rp5m012    2710-2718  ///
  double  rp5m013    2719-2727  ///
  double  rp5m014    2728-2736  ///
  double  rp5m015    2737-2745  ///
  double  rp5m016    2746-2754  ///
  double  rp5m017    2755-2763  ///
  double  rp5m018    2764-2772  ///
  double  rp5m019    2773-2781  ///
  double  rp5m020    2782-2790  ///
  double  rp5m021    2791-2799  ///
  double  rp5m022    2800-2808  ///
  double  rp5m023    2809-2817  ///
  double  rp5m024    2818-2826  ///
  double  rp5m025    2827-2835  ///
  double  rp5m026    2836-2844  ///
  double  rp5m027    2845-2853  ///
  double  rp5m028    2854-2862  ///
  double  rp5m029    2863-2871  ///
  double  rp5m030    2872-2880  ///
  double  rp5m031    2881-2889  ///
  double  rp5m032    2890-2898  ///
  double  rp5m033    2899-2907  ///
  double  rp5m034    2908-2916  ///
  double  rp5m035    2917-2925  ///
  double  rp5m036    2926-2934  ///
  double  rp5m037    2935-2943  ///
  double  rp5m038    2944-2952  ///
  double  rp5m039    2953-2961  ///
  double  rp5m040    2962-2970  ///
  double  rp5m041    2971-2979  ///
  double  rp5m042    2980-2988  ///
  double  rp5m043    2989-2997  ///
  double  rp5m044    2998-3006  ///
  double  rp5m045    3007-3015  ///
  double  rp5m046    3016-3024  ///
  double  rp5m047    3025-3033  ///
  double  rp5m048    3034-3042  ///
  double  rp5m049    3043-3051  ///
  double  rp5m050    3052-3060  ///
  double  rp5m051    3061-3069  ///
  double  rp5m052    3070-3078  ///
  double  rp5m053    3079-3087  ///
  double  rp5m054    3088-3096  ///
  double  rp5m055    3097-3105  ///
  using `"nhgis0011_ds195_20095_2009_county.dat"'


format rkye001   %9.0f
format rkye002   %9.0f
format rkye003   %9.0f
format rkye004   %9.0f
format rkye005   %9.0f
format rkye006   %9.0f
format rkye007   %9.0f
format rkye008   %9.0f
format rkye009   %9.0f
format rkye010   %9.0f
format rkye011   %9.0f
format rkye012   %9.0f
format rkye013   %9.0f
format rkye014   %9.0f
format rkye015   %9.0f
format rkye016   %9.0f
format rkye017   %9.0f
format rkye018   %9.0f
format rkye019   %9.0f
format rkye020   %9.0f
format rkye021   %9.0f
format rkye022   %9.0f
format rkye023   %9.0f
format rkye024   %9.0f
format rkye025   %9.0f
format rkye026   %9.0f
format rkye027   %9.0f
format rkye028   %9.0f
format rkye029   %9.0f
format rkye030   %9.0f
format rkye031   %9.0f
format rkye032   %9.0f
format rkye033   %9.0f
format rkye034   %9.0f
format rkye035   %9.0f
format rkye036   %9.0f
format rkye037   %9.0f
format rkye038   %9.0f
format rkye039   %9.0f
format rkye040   %9.0f
format rkye041   %9.0f
format rkye042   %9.0f
format rkye043   %9.0f
format rkye044   %9.0f
format rkye045   %9.0f
format rkye046   %9.0f
format rkye047   %9.0f
format rkye048   %9.0f
format rkye049   %9.0f
format rm8e001   %9.0f
format rm8e002   %9.0f
format rm8e003   %9.0f
format rm8e004   %9.0f
format rm8e005   %9.0f
format rm8e006   %9.0f
format rm8e007   %9.0f
format rm8e008   %9.0f
format rm8e009   %9.0f
format rm8e010   %9.0f
format rm8e011   %9.0f
format rm8e012   %9.0f
format rm8e013   %9.0f
format rm8e014   %9.0f
format rm8e015   %9.0f
format rm8e016   %9.0f
format rm8e017   %9.0f
format rm8e018   %9.0f
format rm8e019   %9.0f
format rm8e020   %9.0f
format rm8e021   %9.0f
format rm8e022   %9.0f
format rm8e023   %9.0f
format rm8e024   %9.0f
format rm8e025   %9.0f
format rm8e026   %9.0f
format rm8e027   %9.0f
format rm8e028   %9.0f
format rm8e029   %9.0f
format rm8e030   %9.0f
format rm8e031   %9.0f
format rm8e032   %9.0f
format rm8e033   %9.0f
format rm8e034   %9.0f
format rm8e035   %9.0f
format rp5e001   %9.0f
format rp5e002   %9.0f
format rp5e003   %9.0f
format rp5e004   %9.0f
format rp5e005   %9.0f
format rp5e006   %9.0f
format rp5e007   %9.0f
format rp5e008   %9.0f
format rp5e009   %9.0f
format rp5e010   %9.0f
format rp5e011   %9.0f
format rp5e012   %9.0f
format rp5e013   %9.0f
format rp5e014   %9.0f
format rp5e015   %9.0f
format rp5e016   %9.0f
format rp5e017   %9.0f
format rp5e018   %9.0f
format rp5e019   %9.0f
format rp5e020   %9.0f
format rp5e021   %9.0f
format rp5e022   %9.0f
format rp5e023   %9.0f
format rp5e024   %9.0f
format rp5e025   %9.0f
format rp5e026   %9.0f
format rp5e027   %9.0f
format rp5e028   %9.0f
format rp5e029   %9.0f
format rp5e030   %9.0f
format rp5e031   %9.0f
format rp5e032   %9.0f
format rp5e033   %9.0f
format rp5e034   %9.0f
format rp5e035   %9.0f
format rp5e036   %9.0f
format rp5e037   %9.0f
format rp5e038   %9.0f
format rp5e039   %9.0f
format rp5e040   %9.0f
format rp5e041   %9.0f
format rp5e042   %9.0f
format rp5e043   %9.0f
format rp5e044   %9.0f
format rp5e045   %9.0f
format rp5e046   %9.0f
format rp5e047   %9.0f
format rp5e048   %9.0f
format rp5e049   %9.0f
format rp5e050   %9.0f
format rp5e051   %9.0f
format rp5e052   %9.0f
format rp5e053   %9.0f
format rp5e054   %9.0f
format rp5e055   %9.0f
format rkym001   %9.0f
format rkym002   %9.0f
format rkym003   %9.0f
format rkym004   %9.0f
format rkym005   %9.0f
format rkym006   %9.0f
format rkym007   %9.0f
format rkym008   %9.0f
format rkym009   %9.0f
format rkym010   %9.0f
format rkym011   %9.0f
format rkym012   %9.0f
format rkym013   %9.0f
format rkym014   %9.0f
format rkym015   %9.0f
format rkym016   %9.0f
format rkym017   %9.0f
format rkym018   %9.0f
format rkym019   %9.0f
format rkym020   %9.0f
format rkym021   %9.0f
format rkym022   %9.0f
format rkym023   %9.0f
format rkym024   %9.0f
format rkym025   %9.0f
format rkym026   %9.0f
format rkym027   %9.0f
format rkym028   %9.0f
format rkym029   %9.0f
format rkym030   %9.0f
format rkym031   %9.0f
format rkym032   %9.0f
format rkym033   %9.0f
format rkym034   %9.0f
format rkym035   %9.0f
format rkym036   %9.0f
format rkym037   %9.0f
format rkym038   %9.0f
format rkym039   %9.0f
format rkym040   %9.0f
format rkym041   %9.0f
format rkym042   %9.0f
format rkym043   %9.0f
format rkym044   %9.0f
format rkym045   %9.0f
format rkym046   %9.0f
format rkym047   %9.0f
format rkym048   %9.0f
format rkym049   %9.0f
format rm8m001   %9.0f
format rm8m002   %9.0f
format rm8m003   %9.0f
format rm8m004   %9.0f
format rm8m005   %9.0f
format rm8m006   %9.0f
format rm8m007   %9.0f
format rm8m008   %9.0f
format rm8m009   %9.0f
format rm8m010   %9.0f
format rm8m011   %9.0f
format rm8m012   %9.0f
format rm8m013   %9.0f
format rm8m014   %9.0f
format rm8m015   %9.0f
format rm8m016   %9.0f
format rm8m017   %9.0f
format rm8m018   %9.0f
format rm8m019   %9.0f
format rm8m020   %9.0f
format rm8m021   %9.0f
format rm8m022   %9.0f
format rm8m023   %9.0f
format rm8m024   %9.0f
format rm8m025   %9.0f
format rm8m026   %9.0f
format rm8m027   %9.0f
format rm8m028   %9.0f
format rm8m029   %9.0f
format rm8m030   %9.0f
format rm8m031   %9.0f
format rm8m032   %9.0f
format rm8m033   %9.0f
format rm8m034   %9.0f
format rm8m035   %9.0f
format rp5m001   %9.0f
format rp5m002   %9.0f
format rp5m003   %9.0f
format rp5m004   %9.0f
format rp5m005   %9.0f
format rp5m006   %9.0f
format rp5m007   %9.0f
format rp5m008   %9.0f
format rp5m009   %9.0f
format rp5m010   %9.0f
format rp5m011   %9.0f
format rp5m012   %9.0f
format rp5m013   %9.0f
format rp5m014   %9.0f
format rp5m015   %9.0f
format rp5m016   %9.0f
format rp5m017   %9.0f
format rp5m018   %9.0f
format rp5m019   %9.0f
format rp5m020   %9.0f
format rp5m021   %9.0f
format rp5m022   %9.0f
format rp5m023   %9.0f
format rp5m024   %9.0f
format rp5m025   %9.0f
format rp5m026   %9.0f
format rp5m027   %9.0f
format rp5m028   %9.0f
format rp5m029   %9.0f
format rp5m030   %9.0f
format rp5m031   %9.0f
format rp5m032   %9.0f
format rp5m033   %9.0f
format rp5m034   %9.0f
format rp5m035   %9.0f
format rp5m036   %9.0f
format rp5m037   %9.0f
format rp5m038   %9.0f
format rp5m039   %9.0f
format rp5m040   %9.0f
format rp5m041   %9.0f
format rp5m042   %9.0f
format rp5m043   %9.0f
format rp5m044   %9.0f
format rp5m045   %9.0f
format rp5m046   %9.0f
format rp5m047   %9.0f
format rp5m048   %9.0f
format rp5m049   %9.0f
format rp5m050   %9.0f
format rp5m051   %9.0f
format rp5m052   %9.0f
format rp5m053   %9.0f
format rp5m054   %9.0f
format rp5m055   %9.0f

label var year      `"Data File Year"'
label var regiona   `"Region Code"'
label var divisiona `"Division Code"'
label var state     `"State Name"'
label var statea    `"State Code"'
label var county    `"County Name"'
label var countya   `"County Code"'
label var cousuba   `"County Subdivision Code"'
label var placea    `"Place Code"'
label var tracta    `"Census Tract Code"'
label var blkgrpa   `"Block Group Code"'
label var concita   `"Consolidated City Code"'
label var aianhha   `"American Indian Area/Alaska Native Area/Hawaiian Home Land Code"'
label var res_onlya `"American Indian Area/Alaska Native Area (Reservation or Statistical Entity Only)"'
label var trusta    `"American Indian Area (Off-Reservation Trust Land Only)/Hawaiian Home Land Code"'
label var aitscea   `"Tribal Subdivision/Remainder Code"'
label var anrca     `"Alaska Native Regional Corporation Code"'
label var cbsaa     `"Metropolitan Statistical Area/Micropolitan Statistical Area Code"'
label var csaa      `"Combined Statistical Area Code"'
label var metdiva   `"Metropolitan Division Code"'
label var nectaa    `"New England City and Town Area Code"'
label var cnectaa   `"Combined New England City and Town Area Code"'
label var nectadiva `"New England City and Town Area Division Code"'
label var uaa       `"Urban Area Code"'
label var cdcurra   `"Congressional District (2007-2013, 110th-112th Congress) Code"'
label var sldua     `"State Legislative District (Upper Chamber) Code"'
label var sldla     `"State Legislative District (Lower Chamber) Code"'
label var submcda   `"Subminor Civil Division Code"'
label var sdelma    `"School District (Elementary)/Remainder Code"'
label var sdseca    `"School District (Secondary)/Remainder Code"'
label var sdunia    `"School District (Unified)/Remainder Code"'
label var puma5a    `"Public Use Microdata Sample Area (PUMA) Code"'
label var name_e    `"Estimates: Area Name"'
label var rkye001   `"Estimates: Total"'
label var rkye002   `"Estimates: Male"'
label var rkye003   `"Estimates: Male: Under 5 years"'
label var rkye004   `"Estimates: Male: 5 to 9 years"'
label var rkye005   `"Estimates: Male: 10 to 14 years"'
label var rkye006   `"Estimates: Male: 15 to 17 years"'
label var rkye007   `"Estimates: Male: 18 and 19 years"'
label var rkye008   `"Estimates: Male: 20 years"'
label var rkye009   `"Estimates: Male: 21 years"'
label var rkye010   `"Estimates: Male: 22 to 24 years"'
label var rkye011   `"Estimates: Male: 25 to 29 years"'
label var rkye012   `"Estimates: Male: 30 to 34 years"'
label var rkye013   `"Estimates: Male: 35 to 39 years"'
label var rkye014   `"Estimates: Male: 40 to 44 years"'
label var rkye015   `"Estimates: Male: 45 to 49 years"'
label var rkye016   `"Estimates: Male: 50 to 54 years"'
label var rkye017   `"Estimates: Male: 55 to 59 years"'
label var rkye018   `"Estimates: Male: 60 and 61 years"'
label var rkye019   `"Estimates: Male: 62 to 64 years"'
label var rkye020   `"Estimates: Male: 65 and 66 years"'
label var rkye021   `"Estimates: Male: 67 to 69 years"'
label var rkye022   `"Estimates: Male: 70 to 74 years"'
label var rkye023   `"Estimates: Male: 75 to 79 years"'
label var rkye024   `"Estimates: Male: 80 to 84 years"'
label var rkye025   `"Estimates: Male: 85 years and over"'
label var rkye026   `"Estimates: Female"'
label var rkye027   `"Estimates: Female: Under 5 years"'
label var rkye028   `"Estimates: Female: 5 to 9 years"'
label var rkye029   `"Estimates: Female: 10 to 14 years"'
label var rkye030   `"Estimates: Female: 15 to 17 years"'
label var rkye031   `"Estimates: Female: 18 and 19 years"'
label var rkye032   `"Estimates: Female: 20 years"'
label var rkye033   `"Estimates: Female: 21 years"'
label var rkye034   `"Estimates: Female: 22 to 24 years"'
label var rkye035   `"Estimates: Female: 25 to 29 years"'
label var rkye036   `"Estimates: Female: 30 to 34 years"'
label var rkye037   `"Estimates: Female: 35 to 39 years"'
label var rkye038   `"Estimates: Female: 40 to 44 years"'
label var rkye039   `"Estimates: Female: 45 to 49 years"'
label var rkye040   `"Estimates: Female: 50 to 54 years"'
label var rkye041   `"Estimates: Female: 55 to 59 years"'
label var rkye042   `"Estimates: Female: 60 and 61 years"'
label var rkye043   `"Estimates: Female: 62 to 64 years"'
label var rkye044   `"Estimates: Female: 65 and 66 years"'
label var rkye045   `"Estimates: Female: 67 to 69 years"'
label var rkye046   `"Estimates: Female: 70 to 74 years"'
label var rkye047   `"Estimates: Female: 75 to 79 years"'
label var rkye048   `"Estimates: Female: 80 to 84 years"'
label var rkye049   `"Estimates: Female: 85 years and over"'
label var rm8e001   `"Estimates: Total"'
label var rm8e002   `"Estimates: Male"'
label var rm8e003   `"Estimates: Male: No schooling completed"'
label var rm8e004   `"Estimates: Male: Nursery to 4th grade"'
label var rm8e005   `"Estimates: Male: 5th and 6th grade"'
label var rm8e006   `"Estimates: Male: 7th and 8th grade"'
label var rm8e007   `"Estimates: Male: 9th grade"'
label var rm8e008   `"Estimates: Male: 10th grade"'
label var rm8e009   `"Estimates: Male: 11th grade"'
label var rm8e010   `"Estimates: Male: 12th grade, no diploma"'
label var rm8e011   `"Estimates: Male: High school graduate, GED, or alternative"'
label var rm8e012   `"Estimates: Male: Some college, less than 1 year"'
label var rm8e013   `"Estimates: Male: Some college, 1 or more years, no degree"'
label var rm8e014   `"Estimates: Male: Associate's degree"'
label var rm8e015   `"Estimates: Male: Bachelor's degree"'
label var rm8e016   `"Estimates: Male: Master's degree"'
label var rm8e017   `"Estimates: Male: Professional school degree"'
label var rm8e018   `"Estimates: Male: Doctorate degree"'
label var rm8e019   `"Estimates: Female"'
label var rm8e020   `"Estimates: Female: No schooling completed"'
label var rm8e021   `"Estimates: Female: Nursery to 4th grade"'
label var rm8e022   `"Estimates: Female: 5th and 6th grade"'
label var rm8e023   `"Estimates: Female: 7th and 8th grade"'
label var rm8e024   `"Estimates: Female: 9th grade"'
label var rm8e025   `"Estimates: Female: 10th grade"'
label var rm8e026   `"Estimates: Female: 11th grade"'
label var rm8e027   `"Estimates: Female: 12th grade, no diploma"'
label var rm8e028   `"Estimates: Female: High school graduate, GED, or alternative"'
label var rm8e029   `"Estimates: Female: Some college, less than 1 year"'
label var rm8e030   `"Estimates: Female: Some college, 1 or more years, no degree"'
label var rm8e031   `"Estimates: Female: Associate's degree"'
label var rm8e032   `"Estimates: Female: Bachelor's degree"'
label var rm8e033   `"Estimates: Female: Master's degree"'
label var rm8e034   `"Estimates: Female: Professional school degree"'
label var rm8e035   `"Estimates: Female: Doctorate degree"'
label var rp5e001   `"Estimates: Total"'
label var rp5e002   `"Estimates: Male"'
label var rp5e003   `"Estimates: Male: Agriculture, forestry, fishing and hunting, and mining"'
label var rp5e004   `"Estimates: Male: Agriculture, forestry, fishing and hunting, and mining: Agricul"'
label var rp5e005   `"Estimates: Male: Agriculture, forestry, fishing and hunting, and mining: Mining,"'
label var rp5e006   `"Estimates: Male: Construction"'
label var rp5e007   `"Estimates: Male: Manufacturing"'
label var rp5e008   `"Estimates: Male: Wholesale trade"'
label var rp5e009   `"Estimates: Male: Retail trade"'
label var rp5e010   `"Estimates: Male: Transportation and warehousing, and utilities"'
label var rp5e011   `"Estimates: Male: Transportation and warehousing, and utilities: Transportation a"'
label var rp5e012   `"Estimates: Male: Transportation and warehousing, and utilities: Utilities"'
label var rp5e013   `"Estimates: Male: Information"'
label var rp5e014   `"Estimates: Male: Finance and insurance, and real estate and rental and leasing"'
label var rp5e015   `"Estimates: Male: Finance and insurance, and real estate and rental and leasing: "'
label var rp5e016   `"Estimates: Male: Finance and insurance, and real estate and rental and leasing: "'
label var rp5e017   `"Estimates: Male: Professional, scientific, and management, and administrative an"'
label var rp5e018   `"Estimates: Male: Professional, scientific, and management, and administrative an"'
label var rp5e019   `"Estimates: Male: Professional, scientific, and management, and administrative an"'
label var rp5e020   `"Estimates: Male: Professional, scientific, and management, and administrative an"'
label var rp5e021   `"Estimates: Male: Educational services, and health care and social assistance"'
label var rp5e022   `"Estimates: Male: Educational services, and health care and social assistance: Ed"'
label var rp5e023   `"Estimates: Male: Educational services, and health care and social assistance: He"'
label var rp5e024   `"Estimates: Male: Arts, entertainment, and recreation, and accommodation and food"'
label var rp5e025   `"Estimates: Male: Arts, entertainment, and recreation, and accommodation and food"'
label var rp5e026   `"Estimates: Male: Arts, entertainment, and recreation, and accommodation and food"'
label var rp5e027   `"Estimates: Male: Other services, except public administration"'
label var rp5e028   `"Estimates: Male: Public administration"'
label var rp5e029   `"Estimates: Female"'
label var rp5e030   `"Estimates: Female: Agriculture, forestry, fishing and hunting, and mining"'
label var rp5e031   `"Estimates: Female: Agriculture, forestry, fishing and hunting, and mining: Agric"'
label var rp5e032   `"Estimates: Female: Agriculture, forestry, fishing and hunting, and mining: Minin"'
label var rp5e033   `"Estimates: Female: Construction"'
label var rp5e034   `"Estimates: Female: Manufacturing"'
label var rp5e035   `"Estimates: Female: Wholesale trade"'
label var rp5e036   `"Estimates: Female: Retail trade"'
label var rp5e037   `"Estimates: Female: Transportation and warehousing, and utilities"'
label var rp5e038   `"Estimates: Female: Transportation and warehousing, and utilities: Transportation"'
label var rp5e039   `"Estimates: Female: Transportation and warehousing, and utilities: Utilities"'
label var rp5e040   `"Estimates: Female: Information"'
label var rp5e041   `"Estimates: Female: Finance and insurance, and real estate and rental and leasing"'
label var rp5e042   `"Estimates: Female: Finance and insurance, and real estate and rental and leasing"'
label var rp5e043   `"Estimates: Female: Finance and insurance, and real estate and rental and leasing"'
label var rp5e044   `"Estimates: Female: Professional, scientific, and management, and administrative "'
label var rp5e045   `"Estimates: Female: Professional, scientific, and management, and administrative "'
label var rp5e046   `"Estimates: Female: Professional, scientific, and management, and administrative "'
label var rp5e047   `"Estimates: Female: Professional, scientific, and management, and administrative "'
label var rp5e048   `"Estimates: Female: Educational services, and health care and social assistance"'
label var rp5e049   `"Estimates: Female: Educational services, and health care and social assistance: "'
label var rp5e050   `"Estimates: Female: Educational services, and health care and social assistance: "'
label var rp5e051   `"Estimates: Female: Arts, entertainment, and recreation, and accommodation and fo"'
label var rp5e052   `"Estimates: Female: Arts, entertainment, and recreation, and accommodation and fo"'
label var rp5e053   `"Estimates: Female: Arts, entertainment, and recreation, and accommodation and fo"'
label var rp5e054   `"Estimates: Female: Other services, except public administration"'
label var rp5e055   `"Estimates: Female: Public administration"'


gen fips = statea||countya 
egen manu_emp = rowsum(rp5e007 rp5e034)
egen female_emp = rowsum(rp5e030-rp5e055)
egen total_emp = rowsum(rp5e030-rp5e055 rp5e003-rp5e028)
egen bachelor = rowsum(rm8e015-rm8e018 rm8e032-rm8e035)

keep fips manu_emp female_emp total_emp bachelor

save 2009emp, replace 

