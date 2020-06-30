* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                   ///
  str     year       1-4        ///
  str     anrca      5-6        ///
  str     aianhha    7-10       ///
  str     res_onlya  11-14      ///
  str     trusta     15-18      ///
  str     tracta     19-24      ///
  str     c_citya    25-29      ///
  str     county     30-86      ///
  str     countya    87-89      ///
  str     cty_suba   90-94      ///
  str     divisiona  95-95      ///
  str     msa_cmsaa  96-99      ///
  str     placea     100-104    ///
  str     pmsaa      105-108    ///
  str     regiona    109-109    ///
  str     state      110-133    ///
  str     statea     134-135    ///
  str     urb_areaa  136-139    ///
  str     anpsadpi   140-205    ///
  double  exl001     206-214    ///
  double  exl002     215-223    ///
  double  exl003     224-232    ///
  double  exl004     233-241    ///
  double  exl005     242-250    ///
  double  exl006     251-259    ///
  double  exl007     260-268    ///
  double  exl008     269-277    ///
  double  exl009     278-286    ///
  double  exl010     287-295    ///
  double  exl011     296-304    ///
  double  exl012     305-313    ///
  double  exl013     314-322    ///
  double  exl014     323-331    ///
  double  exl015     332-340    ///
  double  exl016     341-349    ///
  double  exl017     350-358    ///
  double  exl018     359-367    ///
  double  exl019     368-376    ///
  double  exl020     377-385    ///
  double  exl021     386-394    ///
  double  exl022     395-403    ///
  double  exl023     404-412    ///
  double  exl024     413-421    ///
  double  exl025     422-430    ///
  double  exl026     431-439    ///
  double  exl027     440-448    ///
  double  exl028     449-457    ///
  double  exl029     458-466    ///
  double  exl030     467-475    ///
  double  exl031     476-484    ///
  double  exl032     485-493    ///
  double  exl033     494-502    ///
  double  exl034     503-511    ///
  double  exl035     512-520    ///
  double  exl036     521-529    ///
  double  exl037     530-538    ///
  double  exl038     539-547    ///
  double  exl039     548-556    ///
  double  exl040     557-565    ///
  double  exl041     566-574    ///
  double  exl042     575-583    ///
  double  exl043     584-592    ///
  double  exl044     593-601    ///
  double  exl045     602-610    ///
  double  exl046     611-619    ///
  double  exl047     620-628    ///
  double  exl048     629-637    ///
  double  exl049     638-646    ///
  double  exl050     647-655    ///
  double  exl051     656-664    ///
  double  exl052     665-673    ///
  double  exl053     674-682    ///
  double  exl054     683-691    ///
  double  exl055     692-700    ///
  double  exl056     701-709    ///
  double  exl057     710-718    ///
  double  exl058     719-727    ///
  double  exl059     728-736    ///
  double  exl060     737-745    ///
  double  exl061     746-754    ///
  double  exl062     755-763    ///
  double  exl063     764-772    ///
  double  exl064     773-781    ///
  double  exl065     782-790    ///
  double  exl066     791-799    ///
  double  exl067     800-808    ///
  double  exl068     809-817    ///
  double  exl069     818-826    ///
  double  exl070     827-835    ///
  double  exl071     836-844    ///
  double  exl072     845-853    ///
  double  exl073     854-862    ///
  double  exl074     863-871    ///
  double  exl075     872-880    ///
  double  exl076     881-889    ///
  double  exl077     890-898    ///
  double  exl078     899-907    ///
  double  exl079     908-916    ///
  double  exl080     917-925    ///
  double  exl081     926-934    ///
  double  exl082     935-943    ///
  double  exl083     944-952    ///
  double  exl084     953-961    ///
  double  exl085     962-970    ///
  double  exl086     971-979    ///
  double  exl087     980-988    ///
  double  exl088     989-997    ///
  double  exl089     998-1006   ///
  double  exl090     1007-1015  ///
  double  exl091     1016-1024  ///
  double  exl092     1025-1033  ///
  double  exl093     1034-1042  ///
  double  exl094     1043-1051  ///
  double  exl095     1052-1060  ///
  double  exl096     1061-1069  ///
  double  exl097     1070-1078  ///
  double  exl098     1079-1087  ///
  double  exl099     1088-1096  ///
  double  exl100     1097-1105  ///
  double  exl101     1106-1114  ///
  double  exl102     1115-1123  ///
  double  exl103     1124-1132  ///
  double  exl104     1133-1141  ///
  double  exl105     1142-1150  ///
  double  exl106     1151-1159  ///
  double  exl107     1160-1168  ///
  double  exl108     1169-1177  ///
  double  exl109     1178-1186  ///
  double  exl110     1187-1195  ///
  double  exl111     1196-1204  ///
  double  exl112     1205-1213  ///
  double  exl113     1214-1222  ///
  double  exl114     1223-1231  ///
  double  exl115     1232-1240  ///
  double  exl116     1241-1249  ///
  double  exl117     1250-1258  ///
  double  exl118     1259-1267  ///
  double  exl119     1268-1276  ///
  double  exl120     1277-1285  ///
  double  exl121     1286-1294  ///
  double  exl122     1295-1303  ///
  double  exl123     1304-1312  ///
  double  exl124     1313-1321  ///
  double  exl125     1322-1330  ///
  double  exl126     1331-1339  ///
  double  exl127     1340-1348  ///
  double  exl128     1349-1357  ///
  double  exl129     1358-1366  ///
  double  exl130     1367-1375  ///
  double  exl131     1376-1384  ///
  double  exl132     1385-1393  ///
  double  exl133     1394-1402  ///
  double  exl134     1403-1411  ///
  double  exl135     1412-1420  ///
  double  exl136     1421-1429  ///
  double  exl137     1430-1438  ///
  double  exl138     1439-1447  ///
  double  exl139     1448-1456  ///
  double  exl140     1457-1465  ///
  double  exl141     1466-1474  ///
  double  exl142     1475-1483  ///
  double  exl143     1484-1492  ///
  double  exl144     1493-1501  ///
  double  exl145     1502-1510  ///
  double  exl146     1511-1519  ///
  double  exl147     1520-1528  ///
  double  exl148     1529-1537  ///
  double  exl149     1538-1546  ///
  double  exl150     1547-1555  ///
  double  exl151     1556-1564  ///
  double  exl152     1565-1573  ///
  double  exl153     1574-1582  ///
  double  exl154     1583-1591  ///
  double  exl155     1592-1600  ///
  double  exl156     1601-1609  ///
  double  exl157     1610-1618  ///
  double  exl158     1619-1627  ///
  double  exl159     1628-1636  ///
  double  exl160     1637-1645  ///
  double  exl161     1646-1654  ///
  double  exl162     1655-1663  ///
  double  exl163     1664-1672  ///
  double  exl164     1673-1681  ///
  double  exl165     1682-1690  ///
  double  exl166     1691-1699  ///
  double  exl167     1700-1708  ///
  double  exl168     1709-1717  ///
  double  exl169     1718-1726  ///
  double  exl170     1727-1735  ///
  double  exl171     1736-1744  ///
  double  exl172     1745-1753  ///
  double  exl173     1754-1762  ///
  double  exl174     1763-1771  ///
  double  exl175     1772-1780  ///
  double  exl176     1781-1789  ///
  double  exl177     1790-1798  ///
  double  exl178     1799-1807  ///
  double  exl179     1808-1816  ///
  double  exl180     1817-1825  ///
  double  exl181     1826-1834  ///
  double  exl182     1835-1843  ///
  double  exl183     1844-1852  ///
  double  exl184     1853-1861  ///
  double  exl185     1862-1870  ///
  double  exl186     1871-1879  ///
  double  exl187     1880-1888  ///
  double  exl188     1889-1897  ///
  double  exl189     1898-1906  ///
  double  exl190     1907-1915  ///
  double  exl191     1916-1924  ///
  double  exl192     1925-1933  ///
  double  exl193     1934-1942  ///
  double  exl194     1943-1951  ///
  double  exl195     1952-1960  ///
  double  exl196     1961-1969  ///
  double  exl197     1970-1978  ///
  double  exl198     1979-1987  ///
  double  exl199     1988-1996  ///
  double  exl200     1997-2005  ///
  double  exl201     2006-2014  ///
  double  exl202     2015-2023  ///
  double  exl203     2024-2032  ///
  double  exl204     2033-2041  ///
  double  exl205     2042-2050  ///
  double  exl206     2051-2059  ///
  using `"nhgis0009_ds122_1990_county.dat"'


format exl001    %9.0f
format exl002    %9.0f
format exl003    %9.0f
format exl004    %9.0f
format exl005    %9.0f
format exl006    %9.0f
format exl007    %9.0f
format exl008    %9.0f
format exl009    %9.0f
format exl010    %9.0f
format exl011    %9.0f
format exl012    %9.0f
format exl013    %9.0f
format exl014    %9.0f
format exl015    %9.0f
format exl016    %9.0f
format exl017    %9.0f
format exl018    %9.0f
format exl019    %9.0f
format exl020    %9.0f
format exl021    %9.0f
format exl022    %9.0f
format exl023    %9.0f
format exl024    %9.0f
format exl025    %9.0f
format exl026    %9.0f
format exl027    %9.0f
format exl028    %9.0f
format exl029    %9.0f
format exl030    %9.0f
format exl031    %9.0f
format exl032    %9.0f
format exl033    %9.0f
format exl034    %9.0f
format exl035    %9.0f
format exl036    %9.0f
format exl037    %9.0f
format exl038    %9.0f
format exl039    %9.0f
format exl040    %9.0f
format exl041    %9.0f
format exl042    %9.0f
format exl043    %9.0f
format exl044    %9.0f
format exl045    %9.0f
format exl046    %9.0f
format exl047    %9.0f
format exl048    %9.0f
format exl049    %9.0f
format exl050    %9.0f
format exl051    %9.0f
format exl052    %9.0f
format exl053    %9.0f
format exl054    %9.0f
format exl055    %9.0f
format exl056    %9.0f
format exl057    %9.0f
format exl058    %9.0f
format exl059    %9.0f
format exl060    %9.0f
format exl061    %9.0f
format exl062    %9.0f
format exl063    %9.0f
format exl064    %9.0f
format exl065    %9.0f
format exl066    %9.0f
format exl067    %9.0f
format exl068    %9.0f
format exl069    %9.0f
format exl070    %9.0f
format exl071    %9.0f
format exl072    %9.0f
format exl073    %9.0f
format exl074    %9.0f
format exl075    %9.0f
format exl076    %9.0f
format exl077    %9.0f
format exl078    %9.0f
format exl079    %9.0f
format exl080    %9.0f
format exl081    %9.0f
format exl082    %9.0f
format exl083    %9.0f
format exl084    %9.0f
format exl085    %9.0f
format exl086    %9.0f
format exl087    %9.0f
format exl088    %9.0f
format exl089    %9.0f
format exl090    %9.0f
format exl091    %9.0f
format exl092    %9.0f
format exl093    %9.0f
format exl094    %9.0f
format exl095    %9.0f
format exl096    %9.0f
format exl097    %9.0f
format exl098    %9.0f
format exl099    %9.0f
format exl100    %9.0f
format exl101    %9.0f
format exl102    %9.0f
format exl103    %9.0f
format exl104    %9.0f
format exl105    %9.0f
format exl106    %9.0f
format exl107    %9.0f
format exl108    %9.0f
format exl109    %9.0f
format exl110    %9.0f
format exl111    %9.0f
format exl112    %9.0f
format exl113    %9.0f
format exl114    %9.0f
format exl115    %9.0f
format exl116    %9.0f
format exl117    %9.0f
format exl118    %9.0f
format exl119    %9.0f
format exl120    %9.0f
format exl121    %9.0f
format exl122    %9.0f
format exl123    %9.0f
format exl124    %9.0f
format exl125    %9.0f
format exl126    %9.0f
format exl127    %9.0f
format exl128    %9.0f
format exl129    %9.0f
format exl130    %9.0f
format exl131    %9.0f
format exl132    %9.0f
format exl133    %9.0f
format exl134    %9.0f
format exl135    %9.0f
format exl136    %9.0f
format exl137    %9.0f
format exl138    %9.0f
format exl139    %9.0f
format exl140    %9.0f
format exl141    %9.0f
format exl142    %9.0f
format exl143    %9.0f
format exl144    %9.0f
format exl145    %9.0f
format exl146    %9.0f
format exl147    %9.0f
format exl148    %9.0f
format exl149    %9.0f
format exl150    %9.0f
format exl151    %9.0f
format exl152    %9.0f
format exl153    %9.0f
format exl154    %9.0f
format exl155    %9.0f
format exl156    %9.0f
format exl157    %9.0f
format exl158    %9.0f
format exl159    %9.0f
format exl160    %9.0f
format exl161    %9.0f
format exl162    %9.0f
format exl163    %9.0f
format exl164    %9.0f
format exl165    %9.0f
format exl166    %9.0f
format exl167    %9.0f
format exl168    %9.0f
format exl169    %9.0f
format exl170    %9.0f
format exl171    %9.0f
format exl172    %9.0f
format exl173    %9.0f
format exl174    %9.0f
format exl175    %9.0f
format exl176    %9.0f
format exl177    %9.0f
format exl178    %9.0f
format exl179    %9.0f
format exl180    %9.0f
format exl181    %9.0f
format exl182    %9.0f
format exl183    %9.0f
format exl184    %9.0f
format exl185    %9.0f
format exl186    %9.0f
format exl187    %9.0f
format exl188    %9.0f
format exl189    %9.0f
format exl190    %9.0f
format exl191    %9.0f
format exl192    %9.0f
format exl193    %9.0f
format exl194    %9.0f
format exl195    %9.0f
format exl196    %9.0f
format exl197    %9.0f
format exl198    %9.0f
format exl199    %9.0f
format exl200    %9.0f
format exl201    %9.0f
format exl202    %9.0f
format exl203    %9.0f
format exl204    %9.0f
format exl205    %9.0f
format exl206    %9.0f

label var year      `"Data File Year"'
label var anrca     `"Alaska Native Regional Corporation Code"'
label var aianhha   `"American Indian Area/Alaska Native Area/Hawaiian Home Land Code"'
label var res_onlya `"American Indian Reservation [excluding trust lands] Code"'
label var trusta    `"American Indian Reservation [trust lands only] Code"'
label var tracta    `"Census Tract Code"'
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
label var urb_areaa `"Urban Area Code"'
label var anpsadpi  `"Area Name/PSAD Term/Part Indicator"'
label var exl001    `"Male >> Under 1 year"'
label var exl002    `"Male >> 1 year"'
label var exl003    `"Male >> 2 years"'
label var exl004    `"Male >> 3 years"'
label var exl005    `"Male >> 4 years"'
label var exl006    `"Male >> 5 years"'
label var exl007    `"Male >> 6 years"'
label var exl008    `"Male >> 7 years"'
label var exl009    `"Male >> 8 years"'
label var exl010    `"Male >> 9 years"'
label var exl011    `"Male >> 10 years"'
label var exl012    `"Male >> 11 years"'
label var exl013    `"Male >> 12 years"'
label var exl014    `"Male >> 13 years"'
label var exl015    `"Male >> 14 years"'
label var exl016    `"Male >> 15 years"'
label var exl017    `"Male >> 16 years"'
label var exl018    `"Male >> 17 years"'
label var exl019    `"Male >> 18 years"'
label var exl020    `"Male >> 19 years"'
label var exl021    `"Male >> 20 years"'
label var exl022    `"Male >> 21 years"'
label var exl023    `"Male >> 22 years"'
label var exl024    `"Male >> 23 years"'
label var exl025    `"Male >> 24 years"'
label var exl026    `"Male >> 25 years"'
label var exl027    `"Male >> 26 years"'
label var exl028    `"Male >> 27 years"'
label var exl029    `"Male >> 28 years"'
label var exl030    `"Male >> 29 years"'
label var exl031    `"Male >> 30 years"'
label var exl032    `"Male >> 31 years"'
label var exl033    `"Male >> 32 years"'
label var exl034    `"Male >> 33 years"'
label var exl035    `"Male >> 34 years"'
label var exl036    `"Male >> 35 years"'
label var exl037    `"Male >> 36 years"'
label var exl038    `"Male >> 37 years"'
label var exl039    `"Male >> 38 years"'
label var exl040    `"Male >> 39 years"'
label var exl041    `"Male >> 40 years"'
label var exl042    `"Male >> 41 years"'
label var exl043    `"Male >> 42 years"'
label var exl044    `"Male >> 43 years"'
label var exl045    `"Male >> 44 years"'
label var exl046    `"Male >> 45 years"'
label var exl047    `"Male >> 46 years"'
label var exl048    `"Male >> 47 years"'
label var exl049    `"Male >> 48 years"'
label var exl050    `"Male >> 49 years"'
label var exl051    `"Male >> 50 years"'
label var exl052    `"Male >> 51 years"'
label var exl053    `"Male >> 52 years"'
label var exl054    `"Male >> 53 years"'
label var exl055    `"Male >> 54 years"'
label var exl056    `"Male >> 55 years"'
label var exl057    `"Male >> 56 years"'
label var exl058    `"Male >> 57 years"'
label var exl059    `"Male >> 58 years"'
label var exl060    `"Male >> 59 years"'
label var exl061    `"Male >> 60 years"'
label var exl062    `"Male >> 61 years"'
label var exl063    `"Male >> 62 years"'
label var exl064    `"Male >> 63 years"'
label var exl065    `"Male >> 64 years"'
label var exl066    `"Male >> 65 years"'
label var exl067    `"Male >> 66 years"'
label var exl068    `"Male >> 67 years"'
label var exl069    `"Male >> 68 years"'
label var exl070    `"Male >> 69 years"'
label var exl071    `"Male >> 70 years"'
label var exl072    `"Male >> 71 years"'
label var exl073    `"Male >> 72 years"'
label var exl074    `"Male >> 73 years"'
label var exl075    `"Male >> 74 years"'
label var exl076    `"Male >> 75 years"'
label var exl077    `"Male >> 76 years"'
label var exl078    `"Male >> 77 years"'
label var exl079    `"Male >> 78 years"'
label var exl080    `"Male >> 79 years"'
label var exl081    `"Male >> 80 years"'
label var exl082    `"Male >> 81 years"'
label var exl083    `"Male >> 82 years"'
label var exl084    `"Male >> 83 years"'
label var exl085    `"Male >> 84 years"'
label var exl086    `"Male >> 85 years"'
label var exl087    `"Male >> 86 years"'
label var exl088    `"Male >> 87 years"'
label var exl089    `"Male >> 88 years"'
label var exl090    `"Male >> 89 years"'
label var exl091    `"Male >> 90 years"'
label var exl092    `"Male >> 91 years"'
label var exl093    `"Male >> 92 years"'
label var exl094    `"Male >> 93 years"'
label var exl095    `"Male >> 94 years"'
label var exl096    `"Male >> 95 years"'
label var exl097    `"Male >> 96 years"'
label var exl098    `"Male >> 97 years"'
label var exl099    `"Male >> 98 years"'
label var exl100    `"Male >> 99 years"'
label var exl101    `"Male >> 100 to 104 years"'
label var exl102    `"Male >> 105 to 109 years"'
label var exl103    `"Male >> 110 years and over"'
label var exl104    `"Female >> Under 1 year"'
label var exl105    `"Female >> 1 year"'
label var exl106    `"Female >> 2 years"'
label var exl107    `"Female >> 3 years"'
label var exl108    `"Female >> 4 years"'
label var exl109    `"Female >> 5 years"'
label var exl110    `"Female >> 6 years"'
label var exl111    `"Female >> 7 years"'
label var exl112    `"Female >> 8 years"'
label var exl113    `"Female >> 9 years"'
label var exl114    `"Female >> 10 years"'
label var exl115    `"Female >> 11 years"'
label var exl116    `"Female >> 12 years"'
label var exl117    `"Female >> 13 years"'
label var exl118    `"Female >> 14 years"'
label var exl119    `"Female >> 15 years"'
label var exl120    `"Female >> 16 years"'
label var exl121    `"Female >> 17 years"'
label var exl122    `"Female >> 18 years"'
label var exl123    `"Female >> 19 years"'
label var exl124    `"Female >> 20 years"'
label var exl125    `"Female >> 21 years"'
label var exl126    `"Female >> 22 years"'
label var exl127    `"Female >> 23 years"'
label var exl128    `"Female >> 24 years"'
label var exl129    `"Female >> 25 years"'
label var exl130    `"Female >> 26 years"'
label var exl131    `"Female >> 27 years"'
label var exl132    `"Female >> 28 years"'
label var exl133    `"Female >> 29 years"'
label var exl134    `"Female >> 30 years"'
label var exl135    `"Female >> 31 years"'
label var exl136    `"Female >> 32 years"'
label var exl137    `"Female >> 33 years"'
label var exl138    `"Female >> 34 years"'
label var exl139    `"Female >> 35 years"'
label var exl140    `"Female >> 36 years"'
label var exl141    `"Female >> 37 years"'
label var exl142    `"Female >> 38 years"'
label var exl143    `"Female >> 39 years"'
label var exl144    `"Female >> 40 years"'
label var exl145    `"Female >> 41 years"'
label var exl146    `"Female >> 42 years"'
label var exl147    `"Female >> 43 years"'
label var exl148    `"Female >> 44 years"'
label var exl149    `"Female >> 45 years"'
label var exl150    `"Female >> 46 years"'
label var exl151    `"Female >> 47 years"'
label var exl152    `"Female >> 48 years"'
label var exl153    `"Female >> 49 years"'
label var exl154    `"Female >> 50 years"'
label var exl155    `"Female >> 51 years"'
label var exl156    `"Female >> 52 years"'
label var exl157    `"Female >> 53 years"'
label var exl158    `"Female >> 54 years"'
label var exl159    `"Female >> 55 years"'
label var exl160    `"Female >> 56 years"'
label var exl161    `"Female >> 57 years"'
label var exl162    `"Female >> 58 years"'
label var exl163    `"Female >> 59 years"'
label var exl164    `"Female >> 60 years"'
label var exl165    `"Female >> 61 years"'
label var exl166    `"Female >> 62 years"'
label var exl167    `"Female >> 63 years"'
label var exl168    `"Female >> 64 years"'
label var exl169    `"Female >> 65 years"'
label var exl170    `"Female >> 66 years"'
label var exl171    `"Female >> 67 years"'
label var exl172    `"Female >> 68 years"'
label var exl173    `"Female >> 69 years"'
label var exl174    `"Female >> 70 years"'
label var exl175    `"Female >> 71 years"'
label var exl176    `"Female >> 72 years"'
label var exl177    `"Female >> 73 years"'
label var exl178    `"Female >> 74 years"'
label var exl179    `"Female >> 75 years"'
label var exl180    `"Female >> 76 years"'
label var exl181    `"Female >> 77 years"'
label var exl182    `"Female >> 78 years"'
label var exl183    `"Female >> 79 years"'
label var exl184    `"Female >> 80 years"'
label var exl185    `"Female >> 81 years"'
label var exl186    `"Female >> 82 years"'
label var exl187    `"Female >> 83 years"'
label var exl188    `"Female >> 84 years"'
label var exl189    `"Female >> 85 years"'
label var exl190    `"Female >> 86 years"'
label var exl191    `"Female >> 87 years"'
label var exl192    `"Female >> 88 years"'
label var exl193    `"Female >> 89 years"'
label var exl194    `"Female >> 90 years"'
label var exl195    `"Female >> 91 years"'
label var exl196    `"Female >> 92 years"'
label var exl197    `"Female >> 93 years"'
label var exl198    `"Female >> 94 years"'
label var exl199    `"Female >> 95 years"'
label var exl200    `"Female >> 96 years"'
label var exl201    `"Female >> 97 years"'
label var exl202    `"Female >> 98 years"'
label var exl203    `"Female >> 99 years"'
label var exl204    `"Female >> 100 to 104 years"'
label var exl205    `"Female >> 105 to 109 years"'
label var exl206    `"Female >> 110 years and over"'

gen fips = statea+countya 
egen pop_16_65 = rowtotal(exl017-exl066 exl120-exl169)
egen female_pop_16_65 = rowtotal(exl120-exl169)

keep fips pop_16_65 female_pop_16_65 
save 1990pop, replace

