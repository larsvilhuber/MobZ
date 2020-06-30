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
  str     concita    114-118    ///
  str     aianhha    119-122    ///
  str     res_onlya  123-126    ///
  str     trusta     127-130    ///
  str     aitscea    131-133    ///
  str     anrca      134-138    ///
  str     cbsaa      139-143    ///
  str     csaa       144-146    ///
  str     metdiva    147-151    ///
  str     nectaa     152-156    ///
  str     cnectaa    157-159    ///
  str     nectadiva  160-164    ///
  str     uaa        165-169    ///
  str     cdcurra    170-171    ///
  str     sldua      172-174    ///
  str     sldla      175-177    ///
  str     submcda    178-182    ///
  str     sdelma     183-187    ///
  str     sdseca     188-192    ///
  str     sdunia     193-197    ///
  str     puma5a     198-202    ///
  str     name_e     203-402    ///
  double  ruxe001    403-411    ///
  double  ruxe002    412-420    ///
  double  ruxe003    421-429    ///
  double  ruxe004    430-438    ///
  double  ruxe005    439-447    ///
  double  ruxe006    448-456    ///
  double  r5ce001    457-465    ///
  double  r5ce002    466-474    ///
  double  r5ce003    475-483    ///
  double  r5ce004    484-492    ///
  double  r5ce005    493-501    ///
  double  r5ce006    502-510    ///
  double  r5ce007    511-519    ///
  double  r5ce008    520-528    ///
  double  r5ce009    529-537    ///
  double  r5ce010    538-546    ///
  double  r5ce011    547-555    ///
  double  r5ce012    556-564    ///
  double  r5ce013    565-573    ///
  double  r5ce014    574-582    ///
  double  r5ce015    583-591    ///
  double  r5ce016    592-600    ///
  double  r5ce017    601-609    ///
  double  r5ce018    610-618    ///
  double  r5ce019    619-627    ///
  double  r5ce020    628-636    ///
  double  r5ce021    637-645    ///
  double  r5ce022    646-654    ///
  double  r5ce023    655-663    ///
  double  r5ce024    664-672    ///
  double  r5ce025    673-681    ///
  double  r5ce026    682-690    ///
  double  r5ce027    691-699    ///
  double  r5ce028    700-708    ///
  double  r5ce029    709-717    ///
  double  r5ce030    718-726    ///
  double  r5ce031    727-735    ///
  double  r5ce032    736-744    ///
  double  r5ce033    745-753    ///
  double  r5ce034    754-762    ///
  double  r5ce035    763-771    ///
  double  r5ce036    772-780    ///
  double  r5ce037    781-789    ///
  double  r5ce038    790-798    ///
  double  r5ce039    799-807    ///
  double  r5ce040    808-816    ///
  double  r5ce041    817-825    ///
  double  r5ce042    826-834    ///
  double  r5ce043    835-843    ///
  double  r5ce044    844-852    ///
  double  r5ce045    853-861    ///
  double  r5ce046    862-870    ///
  double  r5ce047    871-879    ///
  double  r5ce048    880-888    ///
  double  r5ce049    889-897    ///
  double  r5ce050    898-906    ///
  double  r5ce051    907-915    ///
  double  r5ce052    916-924    ///
  double  r5ce053    925-933    ///
  double  r5ce054    934-942    ///
  double  r5ce055    943-951    ///
  double  r5ce056    952-960    ///
  double  r5ce057    961-969    ///
  double  r5ce058    970-978    ///
  double  r5ce059    979-987    ///
  double  r5ce060    988-996    ///
  double  r5ce061    997-1005   ///
  double  r5ce062    1006-1014  ///
  double  r5ce063    1015-1023  ///
  double  r5ce064    1024-1032  ///
  double  r5ce065    1033-1041  ///
  double  r5ce066    1042-1050  ///
  double  r5ce067    1051-1059  ///
  double  r5ce068    1060-1068  ///
  double  r5ce069    1069-1077  ///
  double  r5ce070    1078-1086  ///
  double  r5ce071    1087-1095  ///
  double  r5ce072    1096-1104  ///
  double  r5ce073    1105-1113  ///
  double  r5ce074    1114-1122  ///
  double  r5ce075    1123-1131  ///
  double  r5ce076    1132-1140  ///
  double  r5ce077    1141-1149  ///
  double  r5ce078    1150-1158  ///
  double  r5ce079    1159-1167  ///
  double  r5ce080    1168-1176  ///
  double  r5ce081    1177-1185  ///
  double  r5ce082    1186-1194  ///
  double  r5ce083    1195-1203  ///
  double  r5ce084    1204-1212  ///
  double  r5ce085    1213-1221  ///
  double  r5ce086    1222-1230  ///
  double  r5ce087    1231-1239  ///
  double  r5ce088    1240-1248  ///
  double  r5ce089    1249-1257  ///
  double  r5ce090    1258-1266  ///
  double  r5ce091    1267-1275  ///
  double  r5ce092    1276-1284  ///
  double  r5ce093    1285-1293  ///
  double  r5ce094    1294-1302  ///
  double  r5ce095    1303-1311  ///
  double  r5ce096    1312-1320  ///
  double  r5ce097    1321-1329  ///
  double  r5ce098    1330-1338  ///
  double  r5ce099    1339-1347  ///
  double  r5ce100    1348-1356  ///
  double  r5ce101    1357-1365  ///
  double  r5ce102    1366-1374  ///
  double  r5ce103    1375-1383  ///
  double  r5ce104    1384-1392  ///
  double  r5ce105    1393-1401  ///
  double  r5ce106    1402-1410  ///
  double  r5ce107    1411-1419  ///
  double  r5ce108    1420-1428  ///
  double  r5ce109    1429-1437  ///
  double  r5ce110    1438-1446  ///
  double  r5ce111    1447-1455  ///
  double  r5ce112    1456-1464  ///
  double  r5ce113    1465-1473  ///
  double  r5ce114    1474-1482  ///
  double  r5ce115    1483-1491  ///
  double  r5ce116    1492-1500  ///
  double  r5ce117    1501-1509  ///
  double  r5ce118    1510-1518  ///
  double  r5ce119    1519-1527  ///
  double  r5ce120    1528-1536  ///
  double  r5ce121    1537-1545  ///
  double  r5ce122    1546-1554  ///
  double  r5ce123    1555-1563  ///
  double  r5ce124    1564-1572  ///
  double  r5ce125    1573-1581  ///
  double  r5ce126    1582-1590  ///
  double  r5ce127    1591-1599  ///
  double  r5ce128    1600-1608  ///
  double  r5ce129    1609-1617  ///
  double  r5ce130    1618-1626  ///
  double  r5ce131    1627-1635  ///
  double  r5ce132    1636-1644  ///
  double  r5ce133    1645-1653  ///
  double  r5ce134    1654-1662  ///
  double  r5ce135    1663-1671  ///
  double  r5ce136    1672-1680  ///
  double  r5ce137    1681-1689  ///
  double  r5ce138    1690-1698  ///
  double  r5ce139    1699-1707  ///
  double  r5ce140    1708-1716  ///
  double  r5ce141    1717-1725  ///
  double  r5ce142    1726-1734  ///
  double  r5ce143    1735-1743  ///
  double  r5ce144    1744-1752  ///
  double  r5ce145    1753-1761  ///
  double  r5ce146    1762-1770  ///
  double  r5ce147    1771-1779  ///
  double  r5ce148    1780-1788  ///
  double  r5ce149    1789-1797  ///
  double  r5ce150    1798-1806  ///
  double  r5ce151    1807-1815  ///
  double  r5ce152    1816-1824  ///
  double  r5ce153    1825-1833  ///
  double  r5ce154    1834-1842  ///
  double  r5ce155    1843-1851  ///
  double  r5ce156    1852-1860  ///
  double  r5ce157    1861-1869  ///
  double  r5ce158    1870-1878  ///
  double  r5ce159    1879-1887  ///
  double  r5ce160    1888-1896  ///
  double  r5ce161    1897-1905  ///
  double  r5ce162    1906-1914  ///
  double  r5ce163    1915-1923  ///
  double  r5ce164    1924-1932  ///
  double  r5ce165    1933-1941  ///
  double  r5ce166    1942-1950  ///
  double  r5ce167    1951-1959  ///
  double  r5ce168    1960-1968  ///
  double  r5ce169    1969-1977  ///
  double  r5ce170    1978-1986  ///
  double  r5ce171    1987-1995  ///
  double  r5ce172    1996-2004  ///
  double  r5ce173    2005-2013  ///
  str     name_m     2014-2213  ///
  double  ruxm001    2214-2222  ///
  double  ruxm002    2223-2231  ///
  double  ruxm003    2232-2240  ///
  double  ruxm004    2241-2249  ///
  double  ruxm005    2250-2258  ///
  double  ruxm006    2259-2267  ///
  double  r5cm001    2268-2276  ///
  double  r5cm002    2277-2285  ///
  double  r5cm003    2286-2294  ///
  double  r5cm004    2295-2303  ///
  double  r5cm005    2304-2312  ///
  double  r5cm006    2313-2321  ///
  double  r5cm007    2322-2330  ///
  double  r5cm008    2331-2339  ///
  double  r5cm009    2340-2348  ///
  double  r5cm010    2349-2357  ///
  double  r5cm011    2358-2366  ///
  double  r5cm012    2367-2375  ///
  double  r5cm013    2376-2384  ///
  double  r5cm014    2385-2393  ///
  double  r5cm015    2394-2402  ///
  double  r5cm016    2403-2411  ///
  double  r5cm017    2412-2420  ///
  double  r5cm018    2421-2429  ///
  double  r5cm019    2430-2438  ///
  double  r5cm020    2439-2447  ///
  double  r5cm021    2448-2456  ///
  double  r5cm022    2457-2465  ///
  double  r5cm023    2466-2474  ///
  double  r5cm024    2475-2483  ///
  double  r5cm025    2484-2492  ///
  double  r5cm026    2493-2501  ///
  double  r5cm027    2502-2510  ///
  double  r5cm028    2511-2519  ///
  double  r5cm029    2520-2528  ///
  double  r5cm030    2529-2537  ///
  double  r5cm031    2538-2546  ///
  double  r5cm032    2547-2555  ///
  double  r5cm033    2556-2564  ///
  double  r5cm034    2565-2573  ///
  double  r5cm035    2574-2582  ///
  double  r5cm036    2583-2591  ///
  double  r5cm037    2592-2600  ///
  double  r5cm038    2601-2609  ///
  double  r5cm039    2610-2618  ///
  double  r5cm040    2619-2627  ///
  double  r5cm041    2628-2636  ///
  double  r5cm042    2637-2645  ///
  double  r5cm043    2646-2654  ///
  double  r5cm044    2655-2663  ///
  double  r5cm045    2664-2672  ///
  double  r5cm046    2673-2681  ///
  double  r5cm047    2682-2690  ///
  double  r5cm048    2691-2699  ///
  double  r5cm049    2700-2708  ///
  double  r5cm050    2709-2717  ///
  double  r5cm051    2718-2726  ///
  double  r5cm052    2727-2735  ///
  double  r5cm053    2736-2744  ///
  double  r5cm054    2745-2753  ///
  double  r5cm055    2754-2762  ///
  double  r5cm056    2763-2771  ///
  double  r5cm057    2772-2780  ///
  double  r5cm058    2781-2789  ///
  double  r5cm059    2790-2798  ///
  double  r5cm060    2799-2807  ///
  double  r5cm061    2808-2816  ///
  double  r5cm062    2817-2825  ///
  double  r5cm063    2826-2834  ///
  double  r5cm064    2835-2843  ///
  double  r5cm065    2844-2852  ///
  double  r5cm066    2853-2861  ///
  double  r5cm067    2862-2870  ///
  double  r5cm068    2871-2879  ///
  double  r5cm069    2880-2888  ///
  double  r5cm070    2889-2897  ///
  double  r5cm071    2898-2906  ///
  double  r5cm072    2907-2915  ///
  double  r5cm073    2916-2924  ///
  double  r5cm074    2925-2933  ///
  double  r5cm075    2934-2942  ///
  double  r5cm076    2943-2951  ///
  double  r5cm077    2952-2960  ///
  double  r5cm078    2961-2969  ///
  double  r5cm079    2970-2978  ///
  double  r5cm080    2979-2987  ///
  double  r5cm081    2988-2996  ///
  double  r5cm082    2997-3005  ///
  double  r5cm083    3006-3014  ///
  double  r5cm084    3015-3023  ///
  double  r5cm085    3024-3032  ///
  double  r5cm086    3033-3041  ///
  double  r5cm087    3042-3050  ///
  double  r5cm088    3051-3059  ///
  double  r5cm089    3060-3068  ///
  double  r5cm090    3069-3077  ///
  double  r5cm091    3078-3086  ///
  double  r5cm092    3087-3095  ///
  double  r5cm093    3096-3104  ///
  double  r5cm094    3105-3113  ///
  double  r5cm095    3114-3122  ///
  double  r5cm096    3123-3131  ///
  double  r5cm097    3132-3140  ///
  double  r5cm098    3141-3149  ///
  double  r5cm099    3150-3158  ///
  double  r5cm100    3159-3167  ///
  double  r5cm101    3168-3176  ///
  double  r5cm102    3177-3185  ///
  double  r5cm103    3186-3194  ///
  double  r5cm104    3195-3203  ///
  double  r5cm105    3204-3212  ///
  double  r5cm106    3213-3221  ///
  double  r5cm107    3222-3230  ///
  double  r5cm108    3231-3239  ///
  double  r5cm109    3240-3248  ///
  double  r5cm110    3249-3257  ///
  double  r5cm111    3258-3266  ///
  double  r5cm112    3267-3275  ///
  double  r5cm113    3276-3284  ///
  double  r5cm114    3285-3293  ///
  double  r5cm115    3294-3302  ///
  double  r5cm116    3303-3311  ///
  double  r5cm117    3312-3320  ///
  double  r5cm118    3321-3329  ///
  double  r5cm119    3330-3338  ///
  double  r5cm120    3339-3347  ///
  double  r5cm121    3348-3356  ///
  double  r5cm122    3357-3365  ///
  double  r5cm123    3366-3374  ///
  double  r5cm124    3375-3383  ///
  double  r5cm125    3384-3392  ///
  double  r5cm126    3393-3401  ///
  double  r5cm127    3402-3410  ///
  double  r5cm128    3411-3419  ///
  double  r5cm129    3420-3428  ///
  double  r5cm130    3429-3437  ///
  double  r5cm131    3438-3446  ///
  double  r5cm132    3447-3455  ///
  double  r5cm133    3456-3464  ///
  double  r5cm134    3465-3473  ///
  double  r5cm135    3474-3482  ///
  double  r5cm136    3483-3491  ///
  double  r5cm137    3492-3500  ///
  double  r5cm138    3501-3509  ///
  double  r5cm139    3510-3518  ///
  double  r5cm140    3519-3527  ///
  double  r5cm141    3528-3536  ///
  double  r5cm142    3537-3545  ///
  double  r5cm143    3546-3554  ///
  double  r5cm144    3555-3563  ///
  double  r5cm145    3564-3572  ///
  double  r5cm146    3573-3581  ///
  double  r5cm147    3582-3590  ///
  double  r5cm148    3591-3599  ///
  double  r5cm149    3600-3608  ///
  double  r5cm150    3609-3617  ///
  double  r5cm151    3618-3626  ///
  double  r5cm152    3627-3635  ///
  double  r5cm153    3636-3644  ///
  double  r5cm154    3645-3653  ///
  double  r5cm155    3654-3662  ///
  double  r5cm156    3663-3671  ///
  double  r5cm157    3672-3680  ///
  double  r5cm158    3681-3689  ///
  double  r5cm159    3690-3698  ///
  double  r5cm160    3699-3707  ///
  double  r5cm161    3708-3716  ///
  double  r5cm162    3717-3725  ///
  double  r5cm163    3726-3734  ///
  double  r5cm164    3735-3743  ///
  double  r5cm165    3744-3752  ///
  double  r5cm166    3753-3761  ///
  double  r5cm167    3762-3770  ///
  double  r5cm168    3771-3779  ///
  double  r5cm169    3780-3788  ///
  double  r5cm170    3789-3797  ///
  double  r5cm171    3798-3806  ///
  double  r5cm172    3807-3815  ///
  double  r5cm173    3816-3824  ///
  using `"nhgis0011_ds196_20095_2009_county.dat"'


format ruxe001   %9.0f
format ruxe002   %9.0f
format ruxe003   %9.0f
format ruxe004   %9.0f
format ruxe005   %9.0f
format ruxe006   %9.0f
format r5ce001   %9.0f
format r5ce002   %9.0f
format r5ce003   %9.0f
format r5ce004   %9.0f
format r5ce005   %9.0f
format r5ce006   %9.0f
format r5ce007   %9.0f
format r5ce008   %9.0f
format r5ce009   %9.0f
format r5ce010   %9.0f
format r5ce011   %9.0f
format r5ce012   %9.0f
format r5ce013   %9.0f
format r5ce014   %9.0f
format r5ce015   %9.0f
format r5ce016   %9.0f
format r5ce017   %9.0f
format r5ce018   %9.0f
format r5ce019   %9.0f
format r5ce020   %9.0f
format r5ce021   %9.0f
format r5ce022   %9.0f
format r5ce023   %9.0f
format r5ce024   %9.0f
format r5ce025   %9.0f
format r5ce026   %9.0f
format r5ce027   %9.0f
format r5ce028   %9.0f
format r5ce029   %9.0f
format r5ce030   %9.0f
format r5ce031   %9.0f
format r5ce032   %9.0f
format r5ce033   %9.0f
format r5ce034   %9.0f
format r5ce035   %9.0f
format r5ce036   %9.0f
format r5ce037   %9.0f
format r5ce038   %9.0f
format r5ce039   %9.0f
format r5ce040   %9.0f
format r5ce041   %9.0f
format r5ce042   %9.0f
format r5ce043   %9.0f
format r5ce044   %9.0f
format r5ce045   %9.0f
format r5ce046   %9.0f
format r5ce047   %9.0f
format r5ce048   %9.0f
format r5ce049   %9.0f
format r5ce050   %9.0f
format r5ce051   %9.0f
format r5ce052   %9.0f
format r5ce053   %9.0f
format r5ce054   %9.0f
format r5ce055   %9.0f
format r5ce056   %9.0f
format r5ce057   %9.0f
format r5ce058   %9.0f
format r5ce059   %9.0f
format r5ce060   %9.0f
format r5ce061   %9.0f
format r5ce062   %9.0f
format r5ce063   %9.0f
format r5ce064   %9.0f
format r5ce065   %9.0f
format r5ce066   %9.0f
format r5ce067   %9.0f
format r5ce068   %9.0f
format r5ce069   %9.0f
format r5ce070   %9.0f
format r5ce071   %9.0f
format r5ce072   %9.0f
format r5ce073   %9.0f
format r5ce074   %9.0f
format r5ce075   %9.0f
format r5ce076   %9.0f
format r5ce077   %9.0f
format r5ce078   %9.0f
format r5ce079   %9.0f
format r5ce080   %9.0f
format r5ce081   %9.0f
format r5ce082   %9.0f
format r5ce083   %9.0f
format r5ce084   %9.0f
format r5ce085   %9.0f
format r5ce086   %9.0f
format r5ce087   %9.0f
format r5ce088   %9.0f
format r5ce089   %9.0f
format r5ce090   %9.0f
format r5ce091   %9.0f
format r5ce092   %9.0f
format r5ce093   %9.0f
format r5ce094   %9.0f
format r5ce095   %9.0f
format r5ce096   %9.0f
format r5ce097   %9.0f
format r5ce098   %9.0f
format r5ce099   %9.0f
format r5ce100   %9.0f
format r5ce101   %9.0f
format r5ce102   %9.0f
format r5ce103   %9.0f
format r5ce104   %9.0f
format r5ce105   %9.0f
format r5ce106   %9.0f
format r5ce107   %9.0f
format r5ce108   %9.0f
format r5ce109   %9.0f
format r5ce110   %9.0f
format r5ce111   %9.0f
format r5ce112   %9.0f
format r5ce113   %9.0f
format r5ce114   %9.0f
format r5ce115   %9.0f
format r5ce116   %9.0f
format r5ce117   %9.0f
format r5ce118   %9.0f
format r5ce119   %9.0f
format r5ce120   %9.0f
format r5ce121   %9.0f
format r5ce122   %9.0f
format r5ce123   %9.0f
format r5ce124   %9.0f
format r5ce125   %9.0f
format r5ce126   %9.0f
format r5ce127   %9.0f
format r5ce128   %9.0f
format r5ce129   %9.0f
format r5ce130   %9.0f
format r5ce131   %9.0f
format r5ce132   %9.0f
format r5ce133   %9.0f
format r5ce134   %9.0f
format r5ce135   %9.0f
format r5ce136   %9.0f
format r5ce137   %9.0f
format r5ce138   %9.0f
format r5ce139   %9.0f
format r5ce140   %9.0f
format r5ce141   %9.0f
format r5ce142   %9.0f
format r5ce143   %9.0f
format r5ce144   %9.0f
format r5ce145   %9.0f
format r5ce146   %9.0f
format r5ce147   %9.0f
format r5ce148   %9.0f
format r5ce149   %9.0f
format r5ce150   %9.0f
format r5ce151   %9.0f
format r5ce152   %9.0f
format r5ce153   %9.0f
format r5ce154   %9.0f
format r5ce155   %9.0f
format r5ce156   %9.0f
format r5ce157   %9.0f
format r5ce158   %9.0f
format r5ce159   %9.0f
format r5ce160   %9.0f
format r5ce161   %9.0f
format r5ce162   %9.0f
format r5ce163   %9.0f
format r5ce164   %9.0f
format r5ce165   %9.0f
format r5ce166   %9.0f
format r5ce167   %9.0f
format r5ce168   %9.0f
format r5ce169   %9.0f
format r5ce170   %9.0f
format r5ce171   %9.0f
format r5ce172   %9.0f
format r5ce173   %9.0f
format ruxm001   %9.0f
format ruxm002   %9.0f
format ruxm003   %9.0f
format ruxm004   %9.0f
format ruxm005   %9.0f
format ruxm006   %9.0f
format r5cm001   %9.0f
format r5cm002   %9.0f
format r5cm003   %9.0f
format r5cm004   %9.0f
format r5cm005   %9.0f
format r5cm006   %9.0f
format r5cm007   %9.0f
format r5cm008   %9.0f
format r5cm009   %9.0f
format r5cm010   %9.0f
format r5cm011   %9.0f
format r5cm012   %9.0f
format r5cm013   %9.0f
format r5cm014   %9.0f
format r5cm015   %9.0f
format r5cm016   %9.0f
format r5cm017   %9.0f
format r5cm018   %9.0f
format r5cm019   %9.0f
format r5cm020   %9.0f
format r5cm021   %9.0f
format r5cm022   %9.0f
format r5cm023   %9.0f
format r5cm024   %9.0f
format r5cm025   %9.0f
format r5cm026   %9.0f
format r5cm027   %9.0f
format r5cm028   %9.0f
format r5cm029   %9.0f
format r5cm030   %9.0f
format r5cm031   %9.0f
format r5cm032   %9.0f
format r5cm033   %9.0f
format r5cm034   %9.0f
format r5cm035   %9.0f
format r5cm036   %9.0f
format r5cm037   %9.0f
format r5cm038   %9.0f
format r5cm039   %9.0f
format r5cm040   %9.0f
format r5cm041   %9.0f
format r5cm042   %9.0f
format r5cm043   %9.0f
format r5cm044   %9.0f
format r5cm045   %9.0f
format r5cm046   %9.0f
format r5cm047   %9.0f
format r5cm048   %9.0f
format r5cm049   %9.0f
format r5cm050   %9.0f
format r5cm051   %9.0f
format r5cm052   %9.0f
format r5cm053   %9.0f
format r5cm054   %9.0f
format r5cm055   %9.0f
format r5cm056   %9.0f
format r5cm057   %9.0f
format r5cm058   %9.0f
format r5cm059   %9.0f
format r5cm060   %9.0f
format r5cm061   %9.0f
format r5cm062   %9.0f
format r5cm063   %9.0f
format r5cm064   %9.0f
format r5cm065   %9.0f
format r5cm066   %9.0f
format r5cm067   %9.0f
format r5cm068   %9.0f
format r5cm069   %9.0f
format r5cm070   %9.0f
format r5cm071   %9.0f
format r5cm072   %9.0f
format r5cm073   %9.0f
format r5cm074   %9.0f
format r5cm075   %9.0f
format r5cm076   %9.0f
format r5cm077   %9.0f
format r5cm078   %9.0f
format r5cm079   %9.0f
format r5cm080   %9.0f
format r5cm081   %9.0f
format r5cm082   %9.0f
format r5cm083   %9.0f
format r5cm084   %9.0f
format r5cm085   %9.0f
format r5cm086   %9.0f
format r5cm087   %9.0f
format r5cm088   %9.0f
format r5cm089   %9.0f
format r5cm090   %9.0f
format r5cm091   %9.0f
format r5cm092   %9.0f
format r5cm093   %9.0f
format r5cm094   %9.0f
format r5cm095   %9.0f
format r5cm096   %9.0f
format r5cm097   %9.0f
format r5cm098   %9.0f
format r5cm099   %9.0f
format r5cm100   %9.0f
format r5cm101   %9.0f
format r5cm102   %9.0f
format r5cm103   %9.0f
format r5cm104   %9.0f
format r5cm105   %9.0f
format r5cm106   %9.0f
format r5cm107   %9.0f
format r5cm108   %9.0f
format r5cm109   %9.0f
format r5cm110   %9.0f
format r5cm111   %9.0f
format r5cm112   %9.0f
format r5cm113   %9.0f
format r5cm114   %9.0f
format r5cm115   %9.0f
format r5cm116   %9.0f
format r5cm117   %9.0f
format r5cm118   %9.0f
format r5cm119   %9.0f
format r5cm120   %9.0f
format r5cm121   %9.0f
format r5cm122   %9.0f
format r5cm123   %9.0f
format r5cm124   %9.0f
format r5cm125   %9.0f
format r5cm126   %9.0f
format r5cm127   %9.0f
format r5cm128   %9.0f
format r5cm129   %9.0f
format r5cm130   %9.0f
format r5cm131   %9.0f
format r5cm132   %9.0f
format r5cm133   %9.0f
format r5cm134   %9.0f
format r5cm135   %9.0f
format r5cm136   %9.0f
format r5cm137   %9.0f
format r5cm138   %9.0f
format r5cm139   %9.0f
format r5cm140   %9.0f
format r5cm141   %9.0f
format r5cm142   %9.0f
format r5cm143   %9.0f
format r5cm144   %9.0f
format r5cm145   %9.0f
format r5cm146   %9.0f
format r5cm147   %9.0f
format r5cm148   %9.0f
format r5cm149   %9.0f
format r5cm150   %9.0f
format r5cm151   %9.0f
format r5cm152   %9.0f
format r5cm153   %9.0f
format r5cm154   %9.0f
format r5cm155   %9.0f
format r5cm156   %9.0f
format r5cm157   %9.0f
format r5cm158   %9.0f
format r5cm159   %9.0f
format r5cm160   %9.0f
format r5cm161   %9.0f
format r5cm162   %9.0f
format r5cm163   %9.0f
format r5cm164   %9.0f
format r5cm165   %9.0f
format r5cm166   %9.0f
format r5cm167   %9.0f
format r5cm168   %9.0f
format r5cm169   %9.0f
format r5cm170   %9.0f
format r5cm171   %9.0f
format r5cm172   %9.0f
format r5cm173   %9.0f

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
label var ruxe001   `"Estimates: Total"'
label var ruxe002   `"Estimates: U.S. citizen, born in the United States"'
label var ruxe003   `"Estimates: U.S. citizen, born in Puerto Rico or U.S. Island Areas"'
label var ruxe004   `"Estimates: U.S. citizen, born abroad of American parent(s)"'
label var ruxe005   `"Estimates: U.S. citizen by naturalization"'
label var ruxe006   `"Estimates: Not a U.S. citizen"'
label var r5ce001   `"Estimates: Total"'
label var r5ce002   `"Estimates: Male"'
label var r5ce003   `"Estimates: Male: 16 to 19 years"'
label var r5ce004   `"Estimates: Male: 16 to 19 years: In labor force"'
label var r5ce005   `"Estimates: Male: 16 to 19 years: In labor force: In Armed Forces"'
label var r5ce006   `"Estimates: Male: 16 to 19 years: In labor force: Civilian"'
label var r5ce007   `"Estimates: Male: 16 to 19 years: In labor force: Civilian: Employed"'
label var r5ce008   `"Estimates: Male: 16 to 19 years: In labor force: Civilian: Unemployed"'
label var r5ce009   `"Estimates: Male: 16 to 19 years: Not in labor force"'
label var r5ce010   `"Estimates: Male: 20 and 21 years"'
label var r5ce011   `"Estimates: Male: 20 and 21 years: In labor force"'
label var r5ce012   `"Estimates: Male: 20 and 21 years: In labor force: In Armed Forces"'
label var r5ce013   `"Estimates: Male: 20 and 21 years: In labor force: Civilian"'
label var r5ce014   `"Estimates: Male: 20 and 21 years: In labor force: Civilian: Employed"'
label var r5ce015   `"Estimates: Male: 20 and 21 years: In labor force: Civilian: Unemployed"'
label var r5ce016   `"Estimates: Male: 20 and 21 years: Not in labor force"'
label var r5ce017   `"Estimates: Male: 22 to 24 years"'
label var r5ce018   `"Estimates: Male: 22 to 24 years: In labor force"'
label var r5ce019   `"Estimates: Male: 22 to 24 years: In labor force: In Armed Forces"'
label var r5ce020   `"Estimates: Male: 22 to 24 years: In labor force: Civilian"'
label var r5ce021   `"Estimates: Male: 22 to 24 years: In labor force: Civilian: Employed"'
label var r5ce022   `"Estimates: Male: 22 to 24 years: In labor force: Civilian: Unemployed"'
label var r5ce023   `"Estimates: Male: 22 to 24 years: Not in labor force"'
label var r5ce024   `"Estimates: Male: 25 to 29 years"'
label var r5ce025   `"Estimates: Male: 25 to 29 years: In labor force"'
label var r5ce026   `"Estimates: Male: 25 to 29 years: In labor force: In Armed Forces"'
label var r5ce027   `"Estimates: Male: 25 to 29 years: In labor force: Civilian"'
label var r5ce028   `"Estimates: Male: 25 to 29 years: In labor force: Civilian: Employed"'
label var r5ce029   `"Estimates: Male: 25 to 29 years: In labor force: Civilian: Unemployed"'
label var r5ce030   `"Estimates: Male: 25 to 29 years: Not in labor force"'
label var r5ce031   `"Estimates: Male: 30 to 34 years"'
label var r5ce032   `"Estimates: Male: 30 to 34 years: In labor force"'
label var r5ce033   `"Estimates: Male: 30 to 34 years: In labor force: In Armed Forces"'
label var r5ce034   `"Estimates: Male: 30 to 34 years: In labor force: Civilian"'
label var r5ce035   `"Estimates: Male: 30 to 34 years: In labor force: Civilian: Employed"'
label var r5ce036   `"Estimates: Male: 30 to 34 years: In labor force: Civilian: Unemployed"'
label var r5ce037   `"Estimates: Male: 30 to 34 years: Not in labor force"'
label var r5ce038   `"Estimates: Male: 35 to 44 years"'
label var r5ce039   `"Estimates: Male: 35 to 44 years: In labor force"'
label var r5ce040   `"Estimates: Male: 35 to 44 years: In labor force: In Armed Forces"'
label var r5ce041   `"Estimates: Male: 35 to 44 years: In labor force: Civilian"'
label var r5ce042   `"Estimates: Male: 35 to 44 years: In labor force: Civilian: Employed"'
label var r5ce043   `"Estimates: Male: 35 to 44 years: In labor force: Civilian: Unemployed"'
label var r5ce044   `"Estimates: Male: 35 to 44 years: Not in labor force"'
label var r5ce045   `"Estimates: Male: 45 to 54 years"'
label var r5ce046   `"Estimates: Male: 45 to 54 years: In labor force"'
label var r5ce047   `"Estimates: Male: 45 to 54 years: In labor force: In Armed Forces"'
label var r5ce048   `"Estimates: Male: 45 to 54 years: In labor force: Civilian"'
label var r5ce049   `"Estimates: Male: 45 to 54 years: In labor force: Civilian: Employed"'
label var r5ce050   `"Estimates: Male: 45 to 54 years: In labor force: Civilian: Unemployed"'
label var r5ce051   `"Estimates: Male: 45 to 54 years: Not in labor force"'
label var r5ce052   `"Estimates: Male: 55 to 59 years"'
label var r5ce053   `"Estimates: Male: 55 to 59 years: In labor force"'
label var r5ce054   `"Estimates: Male: 55 to 59 years: In labor force: In Armed Forces"'
label var r5ce055   `"Estimates: Male: 55 to 59 years: In labor force: Civilian"'
label var r5ce056   `"Estimates: Male: 55 to 59 years: In labor force: Civilian: Employed"'
label var r5ce057   `"Estimates: Male: 55 to 59 years: In labor force: Civilian: Unemployed"'
label var r5ce058   `"Estimates: Male: 55 to 59 years: Not in labor force"'
label var r5ce059   `"Estimates: Male: 60 and 61 years"'
label var r5ce060   `"Estimates: Male: 60 and 61 years: In labor force"'
label var r5ce061   `"Estimates: Male: 60 and 61 years: In labor force: In Armed Forces"'
label var r5ce062   `"Estimates: Male: 60 and 61 years: In labor force: Civilian"'
label var r5ce063   `"Estimates: Male: 60 and 61 years: In labor force: Civilian: Employed"'
label var r5ce064   `"Estimates: Male: 60 and 61 years: In labor force: Civilian: Unemployed"'
label var r5ce065   `"Estimates: Male: 60 and 61 years: Not in labor force"'
label var r5ce066   `"Estimates: Male: 62 to 64 years"'
label var r5ce067   `"Estimates: Male: 62 to 64 years: In labor force"'
label var r5ce068   `"Estimates: Male: 62 to 64 years: In labor force: In Armed Forces"'
label var r5ce069   `"Estimates: Male: 62 to 64 years: In labor force: Civilian"'
label var r5ce070   `"Estimates: Male: 62 to 64 years: In labor force: Civilian: Employed"'
label var r5ce071   `"Estimates: Male: 62 to 64 years: In labor force: Civilian: Unemployed"'
label var r5ce072   `"Estimates: Male: 62 to 64 years: Not in labor force"'
label var r5ce073   `"Estimates: Male: 65 to 69 years"'
label var r5ce074   `"Estimates: Male: 65 to 69 years: In labor force"'
label var r5ce075   `"Estimates: Male: 65 to 69 years: In labor force: Employed"'
label var r5ce076   `"Estimates: Male: 65 to 69 years: In labor force: Unemployed"'
label var r5ce077   `"Estimates: Male: 65 to 69 years: Not in labor force"'
label var r5ce078   `"Estimates: Male: 70 to 74 years"'
label var r5ce079   `"Estimates: Male: 70 to 74 years: In labor force"'
label var r5ce080   `"Estimates: Male: 70 to 74 years: In labor force: Employed"'
label var r5ce081   `"Estimates: Male: 70 to 74 years: In labor force: Unemployed"'
label var r5ce082   `"Estimates: Male: 70 to 74 years: Not in labor force"'
label var r5ce083   `"Estimates: Male: 75 years and over"'
label var r5ce084   `"Estimates: Male: 75 years and over: In labor force"'
label var r5ce085   `"Estimates: Male: 75 years and over: In labor force: Employed"'
label var r5ce086   `"Estimates: Male: 75 years and over: In labor force: Unemployed"'
label var r5ce087   `"Estimates: Male: 75 years and over: Not in labor force"'
label var r5ce088   `"Estimates: Female"'
label var r5ce089   `"Estimates: Female: 16 to 19 years"'
label var r5ce090   `"Estimates: Female: 16 to 19 years: In labor force"'
label var r5ce091   `"Estimates: Female: 16 to 19 years: In labor force: In Armed Forces"'
label var r5ce092   `"Estimates: Female: 16 to 19 years: In labor force: Civilian"'
label var r5ce093   `"Estimates: Female: 16 to 19 years: In labor force: Civilian: Employed"'
label var r5ce094   `"Estimates: Female: 16 to 19 years: In labor force: Civilian: Unemployed"'
label var r5ce095   `"Estimates: Female: 16 to 19 years: Not in labor force"'
label var r5ce096   `"Estimates: Female: 20 and 21 years"'
label var r5ce097   `"Estimates: Female: 20 and 21 years: In labor force"'
label var r5ce098   `"Estimates: Female: 20 and 21 years: In labor force: In Armed Forces"'
label var r5ce099   `"Estimates: Female: 20 and 21 years: In labor force: Civilian"'
label var r5ce100   `"Estimates: Female: 20 and 21 years: In labor force: Civilian: Employed"'
label var r5ce101   `"Estimates: Female: 20 and 21 years: In labor force: Civilian: Unemployed"'
label var r5ce102   `"Estimates: Female: 20 and 21 years: Not in labor force"'
label var r5ce103   `"Estimates: Female: 22 to 24 years"'
label var r5ce104   `"Estimates: Female: 22 to 24 years: In labor force"'
label var r5ce105   `"Estimates: Female: 22 to 24 years: In labor force: In Armed Forces"'
label var r5ce106   `"Estimates: Female: 22 to 24 years: In labor force: Civilian"'
label var r5ce107   `"Estimates: Female: 22 to 24 years: In labor force: Civilian: Employed"'
label var r5ce108   `"Estimates: Female: 22 to 24 years: In labor force: Civilian: Unemployed"'
label var r5ce109   `"Estimates: Female: 22 to 24 years: Not in labor force"'
label var r5ce110   `"Estimates: Female: 25 to 29 years"'
label var r5ce111   `"Estimates: Female: 25 to 29 years: In labor force"'
label var r5ce112   `"Estimates: Female: 25 to 29 years: In labor force: In Armed Forces"'
label var r5ce113   `"Estimates: Female: 25 to 29 years: In labor force: Civilian"'
label var r5ce114   `"Estimates: Female: 25 to 29 years: In labor force: Civilian: Employed"'
label var r5ce115   `"Estimates: Female: 25 to 29 years: In labor force: Civilian: Unemployed"'
label var r5ce116   `"Estimates: Female: 25 to 29 years: Not in labor force"'
label var r5ce117   `"Estimates: Female: 30 to 34 years"'
label var r5ce118   `"Estimates: Female: 30 to 34 years: In labor force"'
label var r5ce119   `"Estimates: Female: 30 to 34 years: In labor force: In Armed Forces"'
label var r5ce120   `"Estimates: Female: 30 to 34 years: In labor force: Civilian"'
label var r5ce121   `"Estimates: Female: 30 to 34 years: In labor force: Civilian: Employed"'
label var r5ce122   `"Estimates: Female: 30 to 34 years: In labor force: Civilian: Unemployed"'
label var r5ce123   `"Estimates: Female: 30 to 34 years: Not in labor force"'
label var r5ce124   `"Estimates: Female: 35 to 44 years"'
label var r5ce125   `"Estimates: Female: 35 to 44 years: In labor force"'
label var r5ce126   `"Estimates: Female: 35 to 44 years: In labor force: In Armed Forces"'
label var r5ce127   `"Estimates: Female: 35 to 44 years: In labor force: Civilian"'
label var r5ce128   `"Estimates: Female: 35 to 44 years: In labor force: Civilian: Employed"'
label var r5ce129   `"Estimates: Female: 35 to 44 years: In labor force: Civilian: Unemployed"'
label var r5ce130   `"Estimates: Female: 35 to 44 years: Not in labor force"'
label var r5ce131   `"Estimates: Female: 45 to 54 years"'
label var r5ce132   `"Estimates: Female: 45 to 54 years: In labor force"'
label var r5ce133   `"Estimates: Female: 45 to 54 years: In labor force: In Armed Forces"'
label var r5ce134   `"Estimates: Female: 45 to 54 years: In labor force: Civilian"'
label var r5ce135   `"Estimates: Female: 45 to 54 years: In labor force: Civilian: Employed"'
label var r5ce136   `"Estimates: Female: 45 to 54 years: In labor force: Civilian: Unemployed"'
label var r5ce137   `"Estimates: Female: 45 to 54 years: Not in labor force"'
label var r5ce138   `"Estimates: Female: 55 to 59 years"'
label var r5ce139   `"Estimates: Female: 55 to 59 years: In labor force"'
label var r5ce140   `"Estimates: Female: 55 to 59 years: In labor force: In Armed Forces"'
label var r5ce141   `"Estimates: Female: 55 to 59 years: In labor force: Civilian"'
label var r5ce142   `"Estimates: Female: 55 to 59 years: In labor force: Civilian: Employed"'
label var r5ce143   `"Estimates: Female: 55 to 59 years: In labor force: Civilian: Unemployed"'
label var r5ce144   `"Estimates: Female: 55 to 59 years: Not in labor force"'
label var r5ce145   `"Estimates: Female: 60 and 61 years"'
label var r5ce146   `"Estimates: Female: 60 and 61 years: In labor force"'
label var r5ce147   `"Estimates: Female: 60 and 61 years: In labor force: In Armed Forces"'
label var r5ce148   `"Estimates: Female: 60 and 61 years: In labor force: Civilian"'
label var r5ce149   `"Estimates: Female: 60 and 61 years: In labor force: Civilian: Employed"'
label var r5ce150   `"Estimates: Female: 60 and 61 years: In labor force: Civilian: Unemployed"'
label var r5ce151   `"Estimates: Female: 60 and 61 years: Not in labor force"'
label var r5ce152   `"Estimates: Female: 62 to 64 years"'
label var r5ce153   `"Estimates: Female: 62 to 64 years: In labor force"'
label var r5ce154   `"Estimates: Female: 62 to 64 years: In labor force: In Armed Forces"'
label var r5ce155   `"Estimates: Female: 62 to 64 years: In labor force: Civilian"'
label var r5ce156   `"Estimates: Female: 62 to 64 years: In labor force: Civilian: Employed"'
label var r5ce157   `"Estimates: Female: 62 to 64 years: In labor force: Civilian: Unemployed"'
label var r5ce158   `"Estimates: Female: 62 to 64 years: Not in labor force"'
label var r5ce159   `"Estimates: Female: 65 to 69 years"'
label var r5ce160   `"Estimates: Female: 65 to 69 years: In labor force"'
label var r5ce161   `"Estimates: Female: 65 to 69 years: In labor force: Employed"'
label var r5ce162   `"Estimates: Female: 65 to 69 years: In labor force: Unemployed"'
label var r5ce163   `"Estimates: Female: 65 to 69 years: Not in labor force"'
label var r5ce164   `"Estimates: Female: 70 to 74 years"'
label var r5ce165   `"Estimates: Female: 70 to 74 years: In labor force"'
label var r5ce166   `"Estimates: Female: 70 to 74 years: In labor force: Employed"'
label var r5ce167   `"Estimates: Female: 70 to 74 years: In labor force: Unemployed"'
label var r5ce168   `"Estimates: Female: 70 to 74 years: Not in labor force"'
label var r5ce169   `"Estimates: Female: 75 years and over"'
label var r5ce170   `"Estimates: Female: 75 years and over: In labor force"'
label var r5ce171   `"Estimates: Female: 75 years and over: In labor force: Employed"'
label var r5ce172   `"Estimates: Female: 75 years and over: In labor force: Unemployed"'
label var r5ce173   `"Estimates: Female: 75 years and over: Not in labor force"'
#delimit ; 
egen pop_16_65 = rowsum(r5ce003 r5ce010 r5ce017 r5ce024 
						r5ce031 r5ce038 r5ce045 r5ce052	
						r5ce059 r5ce066 
						r5ce089 r5ce096 r5ce103 r5ce110
						r5ce117 r5ce124 r5ce131 r5ce138
						r5ce145 r5ce152); 
						
egen female_pop_16_65 = rowsum(r5ce089 r5ce096 r5ce103 r5ce110
						r5ce117 r5ce124 r5ce131 r5ce138
						r5ce145 r5ce152);
						
gen fips = statea||countya  ; 

keep fips pop_16_65 female_pop_16_65;

save 2009pop, replace 
						


