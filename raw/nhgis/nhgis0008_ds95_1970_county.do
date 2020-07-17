* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                   ///
  str     year       1-4        ///
  str     state      5-28       ///
  str     statea     29-30      ///
  str     county     31-87      ///
  str     countya    88-90      ///
  str     cty_suba   91-93      ///
  str     placea     94-97      ///
  str     tracta     98-103     ///
  str     scsaa      104-104    ///
  str     smsaa      105-108    ///
  str     urb_areaa  109-112    ///
  str     blocka     113-115    ///
  str     cda        116-117    ///
  str     areaname   118-207    ///
  double  ce6001     208-215    ///
  double  ce6002     216-223    ///
  double  ce6003     224-231    ///
  double  ce6004     232-239    ///
  double  ce6005     240-247    ///
  double  ce6006     248-255    ///
  double  ce6007     256-263    ///
  double  ce6008     264-271    ///
  double  ce6009     272-279    ///
  double  ce6010     280-287    ///
  double  ce6011     288-295    ///
  double  ce6012     296-303    ///
  double  ce6013     304-311    ///
  double  ce6014     312-319    ///
  double  ce6015     320-327    ///
  double  ce6016     328-335    ///
  double  ce6017     336-343    ///
  double  ce6018     344-351    ///
  double  ce6019     352-359    ///
  double  ce6020     360-367    ///
  double  ce6021     368-375    ///
  double  ce6022     376-383    ///
  double  ce6023     384-391    ///
  double  ce6024     392-399    ///
  double  ce6025     400-407    ///
  double  ce6026     408-415    ///
  double  ce6027     416-423    ///
  double  ce6028     424-431    ///
  double  ce6029     432-439    ///
  double  ce6030     440-447    ///
  double  ce6031     448-455    ///
  double  ce6032     456-463    ///
  double  ce6033     464-471    ///
  double  ce6034     472-479    ///
  double  ce6035     480-487    ///
  double  ce6036     488-495    ///
  double  ce6037     496-503    ///
  double  ce6038     504-511    ///
  double  ce6039     512-519    ///
  double  ce6040     520-527    ///
  double  ce6041     528-535    ///
  double  ce6042     536-543    ///
  double  ce6043     544-551    ///
  double  ce6044     552-559    ///
  double  ce6045     560-567    ///
  double  ce6046     568-575    ///
  double  ce6047     576-583    ///
  double  ce6048     584-591    ///
  double  ce6049     592-599    ///
  double  ce6050     600-607    ///
  double  ce6051     608-615    ///
  double  ce6052     616-623    ///
  double  ce6053     624-631    ///
  double  ce6054     632-639    ///
  double  ce6055     640-647    ///
  double  ce6056     648-655    ///
  double  ce6057     656-663    ///
  double  ce6058     664-671    ///
  double  ce6059     672-679    ///
  double  ce6060     680-687    ///
  double  ce6061     688-695    ///
  double  ce6062     696-703    ///
  double  ce6063     704-711    ///
  double  ce6064     712-719    ///
  double  ce6065     720-727    ///
  double  ce6066     728-735    ///
  double  ce6067     736-743    ///
  double  ce6068     744-751    ///
  double  ce6069     752-759    ///
  double  ce6070     760-767    ///
  double  ce6071     768-775    ///
  double  ce6072     776-783    ///
  double  ce6073     784-791    ///
  double  ce6074     792-799    ///
  double  ce6075     800-807    ///
  double  ce6076     808-815    ///
  double  ce6077     816-823    ///
  double  ce6078     824-831    ///
  double  ce6079     832-839    ///
  double  ce6080     840-847    ///
  double  ce6081     848-855    ///
  double  ce6082     856-863    ///
  double  ce6083     864-871    ///
  double  ce6084     872-879    ///
  double  ce6085     880-887    ///
  double  ce6086     888-895    ///
  double  ce6087     896-903    ///
  double  ce6088     904-911    ///
  double  ce6089     912-919    ///
  double  ce6090     920-927    ///
  double  ce6091     928-935    ///
  double  ce6092     936-943    ///
  double  ce6093     944-951    ///
  double  ce6094     952-959    ///
  double  ce6095     960-967    ///
  double  ce6096     968-975    ///
  double  ce6097     976-983    ///
  double  ce6098     984-991    ///
  double  ce6099     992-999    ///
  double  ce6100     1000-1007  ///
  double  ce6101     1008-1015  ///
  double  ce6102     1016-1023  ///
  double  ce6103     1024-1031  ///
  double  ce6104     1032-1039  ///
  double  ce6105     1040-1047  ///
  double  ce6106     1048-1055  ///
  double  ce6107     1056-1063  ///
  double  ce6108     1064-1071  ///
  double  ce6109     1072-1079  ///
  double  ce6110     1080-1087  ///
  double  ce6111     1088-1095  ///
  double  ce6112     1096-1103  ///
  double  ce6113     1104-1111  ///
  double  ce6114     1112-1119  ///
  double  ce6115     1120-1127  ///
  double  ce6116     1128-1135  ///
  double  ce6117     1136-1143  ///
  double  ce6118     1144-1151  ///
  double  ce6119     1152-1159  ///
  double  ce6120     1160-1167  ///
  double  ce6121     1168-1175  ///
  double  ce6122     1176-1183  ///
  double  ce6123     1184-1191  ///
  double  ce6124     1192-1199  ///
  double  ce6125     1200-1207  ///
  double  ce6126     1208-1215  ///
  double  ce6127     1216-1223  ///
  double  ce6128     1224-1231  ///
  double  ce6129     1232-1239  ///
  double  ce6130     1240-1247  ///
  double  ce6131     1248-1255  ///
  double  ce6132     1256-1263  ///
  double  ce6133     1264-1271  ///
  double  ce6134     1272-1279  ///
  double  ce6135     1280-1287  ///
  double  ce6136     1288-1295  ///
  double  ce6137     1296-1303  ///
  double  ce6138     1304-1311  ///
  double  ce6139     1312-1319  ///
  double  ce6140     1320-1327  ///
  double  ce6141     1328-1335  ///
  double  ce6142     1336-1343  ///
  double  ce6143     1344-1351  ///
  double  ce6144     1352-1359  ///
  double  ce6145     1360-1367  ///
  double  ce6146     1368-1375  ///
  double  ce6147     1376-1383  ///
  double  ce6148     1384-1391  ///
  double  ce6149     1392-1399  ///
  double  ce6150     1400-1407  ///
  double  ce6151     1408-1415  ///
  double  ce6152     1416-1423  ///
  double  ce6153     1424-1431  ///
  double  ce6154     1432-1439  ///
  double  ce6155     1440-1447  ///
  double  ce6156     1448-1455  ///
  double  ce6157     1456-1463  ///
  double  ce6158     1464-1471  ///
  double  ce6159     1472-1479  ///
  double  ce6160     1480-1487  ///
  double  ce6161     1488-1495  ///
  double  ce6162     1496-1503  ///
  double  ce6163     1504-1511  ///
  double  ce6164     1512-1519  ///
  double  ce6165     1520-1527  ///
  double  ce6166     1528-1535  ///
  double  ce6167     1536-1543  ///
  double  ce6168     1544-1551  ///
  double  ce6169     1552-1559  ///
  double  ce6170     1560-1567  ///
  double  ce6171     1568-1575  ///
  double  ce6172     1576-1583  ///
  double  ce6173     1584-1591  ///
  double  ce6174     1592-1599  ///
  double  ce6175     1600-1607  ///
  double  ce6176     1608-1615  ///
  double  ce6177     1616-1623  ///
  double  ce6178     1624-1631  ///
  double  ce6179     1632-1639  ///
  double  ce6180     1640-1647  ///
  double  ce6181     1648-1655  ///
  double  ce6182     1656-1663  ///
  double  ce6183     1664-1671  ///
  double  ce6184     1672-1679  ///
  double  ce6185     1680-1687  ///
  double  ce6186     1688-1695  ///
  double  ce6187     1696-1703  ///
  double  ce6188     1704-1711  ///
  double  ce6189     1712-1719  ///
  double  ce6190     1720-1727  ///
  double  ce6191     1728-1735  ///
  double  ce6192     1736-1743  ///
  double  ce6193     1744-1751  ///
  double  ce6194     1752-1759  ///
  double  ce6195     1760-1767  ///
  double  ce6196     1768-1775  ///
  double  ce6197     1776-1783  ///
  double  ce6198     1784-1791  ///
  double  ce6199     1792-1799  ///
  double  ce6200     1800-1807  ///
  double  ce6201     1808-1815  ///
  double  ce6202     1816-1823  ///
  using `"nhgis0008_ds95_1970_county.dat"'


format ce6001    %8.0f
format ce6002    %8.0f
format ce6003    %8.0f
format ce6004    %8.0f
format ce6005    %8.0f
format ce6006    %8.0f
format ce6007    %8.0f
format ce6008    %8.0f
format ce6009    %8.0f
format ce6010    %8.0f
format ce6011    %8.0f
format ce6012    %8.0f
format ce6013    %8.0f
format ce6014    %8.0f
format ce6015    %8.0f
format ce6016    %8.0f
format ce6017    %8.0f
format ce6018    %8.0f
format ce6019    %8.0f
format ce6020    %8.0f
format ce6021    %8.0f
format ce6022    %8.0f
format ce6023    %8.0f
format ce6024    %8.0f
format ce6025    %8.0f
format ce6026    %8.0f
format ce6027    %8.0f
format ce6028    %8.0f
format ce6029    %8.0f
format ce6030    %8.0f
format ce6031    %8.0f
format ce6032    %8.0f
format ce6033    %8.0f
format ce6034    %8.0f
format ce6035    %8.0f
format ce6036    %8.0f
format ce6037    %8.0f
format ce6038    %8.0f
format ce6039    %8.0f
format ce6040    %8.0f
format ce6041    %8.0f
format ce6042    %8.0f
format ce6043    %8.0f
format ce6044    %8.0f
format ce6045    %8.0f
format ce6046    %8.0f
format ce6047    %8.0f
format ce6048    %8.0f
format ce6049    %8.0f
format ce6050    %8.0f
format ce6051    %8.0f
format ce6052    %8.0f
format ce6053    %8.0f
format ce6054    %8.0f
format ce6055    %8.0f
format ce6056    %8.0f
format ce6057    %8.0f
format ce6058    %8.0f
format ce6059    %8.0f
format ce6060    %8.0f
format ce6061    %8.0f
format ce6062    %8.0f
format ce6063    %8.0f
format ce6064    %8.0f
format ce6065    %8.0f
format ce6066    %8.0f
format ce6067    %8.0f
format ce6068    %8.0f
format ce6069    %8.0f
format ce6070    %8.0f
format ce6071    %8.0f
format ce6072    %8.0f
format ce6073    %8.0f
format ce6074    %8.0f
format ce6075    %8.0f
format ce6076    %8.0f
format ce6077    %8.0f
format ce6078    %8.0f
format ce6079    %8.0f
format ce6080    %8.0f
format ce6081    %8.0f
format ce6082    %8.0f
format ce6083    %8.0f
format ce6084    %8.0f
format ce6085    %8.0f
format ce6086    %8.0f
format ce6087    %8.0f
format ce6088    %8.0f
format ce6089    %8.0f
format ce6090    %8.0f
format ce6091    %8.0f
format ce6092    %8.0f
format ce6093    %8.0f
format ce6094    %8.0f
format ce6095    %8.0f
format ce6096    %8.0f
format ce6097    %8.0f
format ce6098    %8.0f
format ce6099    %8.0f
format ce6100    %8.0f
format ce6101    %8.0f
format ce6102    %8.0f
format ce6103    %8.0f
format ce6104    %8.0f
format ce6105    %8.0f
format ce6106    %8.0f
format ce6107    %8.0f
format ce6108    %8.0f
format ce6109    %8.0f
format ce6110    %8.0f
format ce6111    %8.0f
format ce6112    %8.0f
format ce6113    %8.0f
format ce6114    %8.0f
format ce6115    %8.0f
format ce6116    %8.0f
format ce6117    %8.0f
format ce6118    %8.0f
format ce6119    %8.0f
format ce6120    %8.0f
format ce6121    %8.0f
format ce6122    %8.0f
format ce6123    %8.0f
format ce6124    %8.0f
format ce6125    %8.0f
format ce6126    %8.0f
format ce6127    %8.0f
format ce6128    %8.0f
format ce6129    %8.0f
format ce6130    %8.0f
format ce6131    %8.0f
format ce6132    %8.0f
format ce6133    %8.0f
format ce6134    %8.0f
format ce6135    %8.0f
format ce6136    %8.0f
format ce6137    %8.0f
format ce6138    %8.0f
format ce6139    %8.0f
format ce6140    %8.0f
format ce6141    %8.0f
format ce6142    %8.0f
format ce6143    %8.0f
format ce6144    %8.0f
format ce6145    %8.0f
format ce6146    %8.0f
format ce6147    %8.0f
format ce6148    %8.0f
format ce6149    %8.0f
format ce6150    %8.0f
format ce6151    %8.0f
format ce6152    %8.0f
format ce6153    %8.0f
format ce6154    %8.0f
format ce6155    %8.0f
format ce6156    %8.0f
format ce6157    %8.0f
format ce6158    %8.0f
format ce6159    %8.0f
format ce6160    %8.0f
format ce6161    %8.0f
format ce6162    %8.0f
format ce6163    %8.0f
format ce6164    %8.0f
format ce6165    %8.0f
format ce6166    %8.0f
format ce6167    %8.0f
format ce6168    %8.0f
format ce6169    %8.0f
format ce6170    %8.0f
format ce6171    %8.0f
format ce6172    %8.0f
format ce6173    %8.0f
format ce6174    %8.0f
format ce6175    %8.0f
format ce6176    %8.0f
format ce6177    %8.0f
format ce6178    %8.0f
format ce6179    %8.0f
format ce6180    %8.0f
format ce6181    %8.0f
format ce6182    %8.0f
format ce6183    %8.0f
format ce6184    %8.0f
format ce6185    %8.0f
format ce6186    %8.0f
format ce6187    %8.0f
format ce6188    %8.0f
format ce6189    %8.0f
format ce6190    %8.0f
format ce6191    %8.0f
format ce6192    %8.0f
format ce6193    %8.0f
format ce6194    %8.0f
format ce6195    %8.0f
format ce6196    %8.0f
format ce6197    %8.0f
format ce6198    %8.0f
format ce6199    %8.0f
format ce6200    %8.0f
format ce6201    %8.0f
format ce6202    %8.0f

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
label var ce6001    `"Male >> Under 1 year"'
label var ce6002    `"Male >> 1 year"'
label var ce6003    `"Male >> 2 years"'
label var ce6004    `"Male >> 3 years"'
label var ce6005    `"Male >> 4 years"'
label var ce6006    `"Male >> 5 years"'
label var ce6007    `"Male >> 6 years"'
label var ce6008    `"Male >> 7 years"'
label var ce6009    `"Male >> 8 years"'
label var ce6010    `"Male >> 9 years"'
label var ce6011    `"Male >> 10 years"'
label var ce6012    `"Male >> 11 years"'
label var ce6013    `"Male >> 12 years"'
label var ce6014    `"Male >> 13 years"'
label var ce6015    `"Male >> 14 years"'
label var ce6016    `"Male >> 15 years"'
label var ce6017    `"Male >> 16 years"'
label var ce6018    `"Male >> 17 years"'
label var ce6019    `"Male >> 18 years"'
label var ce6020    `"Male >> 19 years"'
label var ce6021    `"Male >> 20 years"'
label var ce6022    `"Male >> 21 years"'
label var ce6023    `"Male >> 22 years"'
label var ce6024    `"Male >> 23 years"'
label var ce6025    `"Male >> 24 years"'
label var ce6026    `"Male >> 25 years"'
label var ce6027    `"Male >> 26 years"'
label var ce6028    `"Male >> 27 years"'
label var ce6029    `"Male >> 28 years"'
label var ce6030    `"Male >> 29 years"'
label var ce6031    `"Male >> 30 years"'
label var ce6032    `"Male >> 31 years"'
label var ce6033    `"Male >> 32 years"'
label var ce6034    `"Male >> 33 years"'
label var ce6035    `"Male >> 34 years"'
label var ce6036    `"Male >> 35 years"'
label var ce6037    `"Male >> 36 years"'
label var ce6038    `"Male >> 37 years"'
label var ce6039    `"Male >> 38 years"'
label var ce6040    `"Male >> 39 years"'
label var ce6041    `"Male >> 40 years"'
label var ce6042    `"Male >> 41 years"'
label var ce6043    `"Male >> 42 years"'
label var ce6044    `"Male >> 43 years"'
label var ce6045    `"Male >> 44 years"'
label var ce6046    `"Male >> 45 years"'
label var ce6047    `"Male >> 46 years"'
label var ce6048    `"Male >> 47 years"'
label var ce6049    `"Male >> 48 years"'
label var ce6050    `"Male >> 49 years"'
label var ce6051    `"Male >> 50 years"'
label var ce6052    `"Male >> 51 years"'
label var ce6053    `"Male >> 52 years"'
label var ce6054    `"Male >> 53 years"'
label var ce6055    `"Male >> 54 years"'
label var ce6056    `"Male >> 55 years"'
label var ce6057    `"Male >> 56 years"'
label var ce6058    `"Male >> 57 years"'
label var ce6059    `"Male >> 58 years"'
label var ce6060    `"Male >> 59 years"'
label var ce6061    `"Male >> 60 years"'
label var ce6062    `"Male >> 61 years"'
label var ce6063    `"Male >> 62 years"'
label var ce6064    `"Male >> 63 years"'
label var ce6065    `"Male >> 64 years"'
label var ce6066    `"Male >> 65 years"'
label var ce6067    `"Male >> 66 years"'
label var ce6068    `"Male >> 67 years"'
label var ce6069    `"Male >> 68 years"'
label var ce6070    `"Male >> 69 years"'
label var ce6071    `"Male >> 70 years"'
label var ce6072    `"Male >> 71 years"'
label var ce6073    `"Male >> 72 years"'
label var ce6074    `"Male >> 73 years"'
label var ce6075    `"Male >> 74 years"'
label var ce6076    `"Male >> 75 years"'
label var ce6077    `"Male >> 76 years"'
label var ce6078    `"Male >> 77 years"'
label var ce6079    `"Male >> 78 years"'
label var ce6080    `"Male >> 79 years"'
label var ce6081    `"Male >> 80 years"'
label var ce6082    `"Male >> 81 years"'
label var ce6083    `"Male >> 82 years"'
label var ce6084    `"Male >> 83 years"'
label var ce6085    `"Male >> 84 years"'
label var ce6086    `"Male >> 85 years"'
label var ce6087    `"Male >> 86 years"'
label var ce6088    `"Male >> 87 years"'
label var ce6089    `"Male >> 88 years"'
label var ce6090    `"Male >> 89 years"'
label var ce6091    `"Male >> 90 years"'
label var ce6092    `"Male >> 91 years"'
label var ce6093    `"Male >> 92 years"'
label var ce6094    `"Male >> 93 years"'
label var ce6095    `"Male >> 94 years"'
label var ce6096    `"Male >> 95 years"'
label var ce6097    `"Male >> 96 years"'
label var ce6098    `"Male >> 97 years"'
label var ce6099    `"Male >> 98 years"'
label var ce6100    `"Male >> 99 years"'
label var ce6101    `"Male >> 100 years and over"'
label var ce6102    `"Female >> Under 1 year"'
label var ce6103    `"Female >> 1 year"'
label var ce6104    `"Female >> 2 years"'
label var ce6105    `"Female >> 3 years"'
label var ce6106    `"Female >> 4 years"'
label var ce6107    `"Female >> 5 years"'
label var ce6108    `"Female >> 6 years"'
label var ce6109    `"Female >> 7 years"'
label var ce6110    `"Female >> 8 years"'
label var ce6111    `"Female >> 9 years"'
label var ce6112    `"Female >> 10 years"'
label var ce6113    `"Female >> 11 years"'
label var ce6114    `"Female >> 12 years"'
label var ce6115    `"Female >> 13 years"'
label var ce6116    `"Female >> 14 years"'
label var ce6117    `"Female >> 15 years"'
label var ce6118    `"Female >> 16 years"'
label var ce6119    `"Female >> 17 years"'
label var ce6120    `"Female >> 18 years"'
label var ce6121    `"Female >> 19 years"'
label var ce6122    `"Female >> 20 years"'
label var ce6123    `"Female >> 21 years"'
label var ce6124    `"Female >> 22 years"'
label var ce6125    `"Female >> 23 years"'
label var ce6126    `"Female >> 24 years"'
label var ce6127    `"Female >> 25 years"'
label var ce6128    `"Female >> 26 years"'
label var ce6129    `"Female >> 27 years"'
label var ce6130    `"Female >> 28 years"'
label var ce6131    `"Female >> 29 years"'
label var ce6132    `"Female >> 30 years"'
label var ce6133    `"Female >> 31 years"'
label var ce6134    `"Female >> 32 years"'
label var ce6135    `"Female >> 33 years"'
label var ce6136    `"Female >> 34 years"'
label var ce6137    `"Female >> 35 years"'
label var ce6138    `"Female >> 36 years"'
label var ce6139    `"Female >> 37 years"'
label var ce6140    `"Female >> 38 years"'
label var ce6141    `"Female >> 39 years"'
label var ce6142    `"Female >> 40 years"'
label var ce6143    `"Female >> 41 years"'
label var ce6144    `"Female >> 42 years"'
label var ce6145    `"Female >> 43 years"'
label var ce6146    `"Female >> 44 years"'
label var ce6147    `"Female >> 45 years"'
label var ce6148    `"Female >> 46 years"'
label var ce6149    `"Female >> 47 years"'
label var ce6150    `"Female >> 48 years"'
label var ce6151    `"Female >> 49 years"'
label var ce6152    `"Female >> 50 years"'
label var ce6153    `"Female >> 51 years"'
label var ce6154    `"Female >> 52 years"'
label var ce6155    `"Female >> 53 years"'
label var ce6156    `"Female >> 54 years"'
label var ce6157    `"Female >> 55 years"'
label var ce6158    `"Female >> 56 years"'
label var ce6159    `"Female >> 57 years"'
label var ce6160    `"Female >> 58 years"'
label var ce6161    `"Female >> 59 years"'
label var ce6162    `"Female >> 60 years"'
label var ce6163    `"Female >> 61 years"'
label var ce6164    `"Female >> 62 years"'
label var ce6165    `"Female >> 63 years"'
label var ce6166    `"Female >> 64 years"'
label var ce6167    `"Female >> 65 years"'
label var ce6168    `"Female >> 66 years"'
label var ce6169    `"Female >> 67 years"'
label var ce6170    `"Female >> 68 years"'
label var ce6171    `"Female >> 69 years"'
label var ce6172    `"Female >> 70 years"'
label var ce6173    `"Female >> 71 years"'
label var ce6174    `"Female >> 72 years"'
label var ce6175    `"Female >> 73 years"'
label var ce6176    `"Female >> 74 years"'
label var ce6177    `"Female >> 75 years"'
label var ce6178    `"Female >> 76 years"'
label var ce6179    `"Female >> 77 years"'
label var ce6180    `"Female >> 78 years"'
label var ce6181    `"Female >> 79 years"'
label var ce6182    `"Female >> 80 years"'
label var ce6183    `"Female >> 81 years"'
label var ce6184    `"Female >> 82 years"'
label var ce6185    `"Female >> 83 years"'
label var ce6186    `"Female >> 84 years"'
label var ce6187    `"Female >> 85 years"'
label var ce6188    `"Female >> 86 years"'
label var ce6189    `"Female >> 87 years"'
label var ce6190    `"Female >> 88 years"'
label var ce6191    `"Female >> 89 years"'
label var ce6192    `"Female >> 90 years"'
label var ce6193    `"Female >> 91 years"'
label var ce6194    `"Female >> 92 years"'
label var ce6195    `"Female >> 93 years"'
label var ce6196    `"Female >> 94 years"'
label var ce6197    `"Female >> 95 years"'
label var ce6198    `"Female >> 96 years"'
label var ce6199    `"Female >> 97 years"'
label var ce6200    `"Female >> 98 years"'
label var ce6201    `"Female >> 99 years"'
label var ce6202    `"Female >> 100 years and over"'

/***************************************
Creating populations 
*******************************************/
egen pop_16_65 = rowtotal(ce6017-ce6066 ce6118-ce6167)
egen femalepop_16_65 = rowtotal(ce6118-ce6167)
gen fips = statea+countya 

keep fips pop_16_65 femalepop_16_65 
save 1970pop.dta, replace 

