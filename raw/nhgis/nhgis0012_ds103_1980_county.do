* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                 ///
  str     year     1-4        ///
  str     state    5-28       ///
  str     statea   29-30      ///
  str     county   31-87      ///
  str     countya  88-90      ///
  double  c60001   91-99      ///
  double  c60002   100-108    ///
  double  c60003   109-117    ///
  double  c60004   118-126    ///
  double  c60005   127-135    ///
  double  c60006   136-144    ///
  double  c60007   145-153    ///
  double  c60008   154-162    ///
  double  c60009   163-171    ///
  double  c60010   172-180    ///
  double  c60011   181-189    ///
  double  c60012   190-198    ///
  double  c60013   199-207    ///
  double  c60014   208-216    ///
  double  c60015   217-225    ///
  double  c60016   226-234    ///
  double  c60017   235-243    ///
  double  c60018   244-252    ///
  double  c60019   253-261    ///
  double  c60020   262-270    ///
  double  c60021   271-279    ///
  double  c60022   280-288    ///
  double  c60023   289-297    ///
  double  c60024   298-306    ///
  double  c60025   307-315    ///
  double  c60026   316-324    ///
  double  c60027   325-333    ///
  double  c60028   334-342    ///
  double  c60029   343-351    ///
  double  c60030   352-360    ///
  double  c60031   361-369    ///
  double  c60032   370-378    ///
  double  c60033   379-387    ///
  double  c60034   388-396    ///
  double  c60035   397-405    ///
  double  c60036   406-414    ///
  double  c60037   415-423    ///
  double  c60038   424-432    ///
  double  c60039   433-441    ///
  double  c60040   442-450    ///
  double  c60041   451-459    ///
  double  c60042   460-468    ///
  double  c60043   469-477    ///
  double  c60044   478-486    ///
  double  c60045   487-495    ///
  double  c60046   496-504    ///
  double  c60047   505-513    ///
  double  c60048   514-522    ///
  double  c60049   523-531    ///
  double  c60050   532-540    ///
  double  c60051   541-549    ///
  double  c60052   550-558    ///
  double  c60053   559-567    ///
  double  c60054   568-576    ///
  double  c60055   577-585    ///
  double  c60056   586-594    ///
  double  c60057   595-603    ///
  double  c60058   604-612    ///
  double  c60059   613-621    ///
  double  c60060   622-630    ///
  double  c60061   631-639    ///
  double  c60062   640-648    ///
  double  c60063   649-657    ///
  double  c60064   658-666    ///
  double  c60065   667-675    ///
  double  c60066   676-684    ///
  double  c60067   685-693    ///
  double  c60068   694-702    ///
  double  c60069   703-711    ///
  double  c60070   712-720    ///
  double  c60071   721-729    ///
  double  c60072   730-738    ///
  double  c60073   739-747    ///
  double  c60074   748-756    ///
  double  c60075   757-765    ///
  double  c60076   766-774    ///
  double  c62001   775-783    ///
  double  c62002   784-792    ///
  double  c62003   793-801    ///
  double  c62004   802-810    ///
  double  c62005   811-819    ///
  double  c62006   820-828    ///
  double  c62007   829-837    ///
  double  c62008   838-846    ///
  double  c62009   847-855    ///
  double  c62010   856-864    ///
  double  c62011   865-873    ///
  double  c62012   874-882    ///
  double  c62013   883-891    ///
  double  c62014   892-900    ///
  double  c62015   901-909    ///
  double  c62016   910-918    ///
  double  c62017   919-927    ///
  double  c62018   928-936    ///
  double  c62019   937-945    ///
  double  c62020   946-954    ///
  double  c62021   955-963    ///
  double  c62022   964-972    ///
  double  c62023   973-981    ///
  double  c62024   982-990    ///
  double  c62025   991-999    ///
  double  c62026   1000-1008  ///
  double  c62027   1009-1017  ///
  double  c62028   1018-1026  ///
  double  c62029   1027-1035  ///
  double  c62030   1036-1044  ///
  double  c62031   1045-1053  ///
  double  c62032   1054-1062  ///
  double  c62033   1063-1071  ///
  double  c62034   1072-1080  ///
  double  c62035   1081-1089  ///
  double  c62036   1090-1098  ///
  double  c62037   1099-1107  ///
  double  c62038   1108-1116  ///
  double  c62039   1117-1125  ///
  double  c62040   1126-1134  ///
  double  c62041   1135-1143  ///
  double  c62042   1144-1152  ///
  double  c62043   1153-1161  ///
  double  c62044   1162-1170  ///
  double  c62045   1171-1179  ///
  double  c62046   1180-1188  ///
  double  c62047   1189-1197  ///
  double  c62048   1198-1206  ///
  double  c62049   1207-1215  ///
  double  c62050   1216-1224  ///
  double  c62051   1225-1233  ///
  double  c62052   1234-1242  ///
  double  c62053   1243-1251  ///
  double  c62054   1252-1260  ///
  double  c62055   1261-1269  ///
  double  c62056   1270-1278  ///
  double  c62057   1279-1287  ///
  double  c62058   1288-1296  ///
  double  c62059   1297-1305  ///
  double  c62060   1306-1314  ///
  double  c62061   1315-1323  ///
  double  c62062   1324-1332  ///
  double  c62063   1333-1341  ///
  double  c62064   1342-1350  ///
  double  c62065   1351-1359  ///
  double  c62066   1360-1368  ///
  double  c62067   1369-1377  ///
  double  c62068   1378-1386  ///
  double  c62069   1387-1395  ///
  double  c62070   1396-1404  ///
  double  c62071   1405-1413  ///
  double  c62072   1414-1422  ///
  double  c62073   1423-1431  ///
  double  c62074   1432-1440  ///
  double  c62075   1441-1449  ///
  double  c62076   1450-1458  ///
  double  c62077   1459-1467  ///
  double  c62078   1468-1476  ///
  double  c62079   1477-1485  ///
  double  c62080   1486-1494  ///
  double  c62081   1495-1503  ///
  double  c62082   1504-1512  ///
  double  c62083   1513-1521  ///
  double  c62084   1522-1530  ///
  double  c62085   1531-1539  ///
  double  c62086   1540-1548  ///
  double  c62087   1549-1557  ///
  double  c62088   1558-1566  ///
  double  c62089   1567-1575  ///
  double  c62090   1576-1584  ///
  double  c62091   1585-1593  ///
  double  c62092   1594-1602  ///
  double  c62093   1603-1611  ///
  double  c62094   1612-1620  ///
  double  c62095   1621-1629  ///
  double  c62096   1630-1638  ///
  double  c62097   1639-1647  ///
  double  c62098   1648-1656  ///
  double  c62099   1657-1665  ///
  double  c62100   1666-1674  ///
  double  c62101   1675-1683  ///
  double  c62102   1684-1692  ///
  double  c62103   1693-1701  ///
  double  c62104   1702-1710  ///
  double  c62105   1711-1719  ///
  double  c62106   1720-1728  ///
  double  c62107   1729-1737  ///
  double  c62108   1738-1746  ///
  double  c62109   1747-1755  ///
  double  c62110   1756-1764  ///
  double  c62111   1765-1773  ///
  double  c62112   1774-1782  ///
  double  c62113   1783-1791  ///
  double  c62114   1792-1800  ///
  double  c62115   1801-1809  ///
  double  c62116   1810-1818  ///
  double  c62117   1819-1827  ///
  double  c62118   1828-1836  ///
  double  c62119   1837-1845  ///
  double  c62120   1846-1854  ///
  double  c62121   1855-1863  ///
  double  c62122   1864-1872  ///
  double  c62123   1873-1881  ///
  double  c62124   1882-1890  ///
  double  c62125   1891-1899  ///
  double  c62126   1900-1908  ///
  double  c62127   1909-1917  ///
  double  c62128   1918-1926  ///
  double  c62129   1927-1935  ///
  double  c62130   1936-1944  ///
  double  c62131   1945-1953  ///
  double  c62132   1954-1962  ///
  double  c62133   1963-1971  ///
  double  c62134   1972-1980  ///
  double  c62135   1981-1989  ///
  double  c62136   1990-1998  ///
  double  c62137   1999-2007  ///
  double  c62138   2008-2016  ///
  double  c62139   2017-2025  ///
  double  c62140   2026-2034  ///
  double  c62141   2035-2043  ///
  double  c62142   2044-2052  ///
  double  c62143   2053-2061  ///
  double  c62144   2062-2070  ///
  double  c62145   2071-2079  ///
  double  c62146   2080-2088  ///
  double  c62147   2089-2097  ///
  double  c62148   2098-2106  ///
  double  c62149   2107-2115  ///
  double  c62150   2116-2124  ///
  double  c62151   2125-2133  ///
  double  c62152   2134-2142  ///
  using `"nhgis0012_ds103_1980_county.dat"'


format c60001  %9.0f
format c60002  %9.0f
format c60003  %9.0f
format c60004  %9.0f
format c60005  %9.0f
format c60006  %9.0f
format c60007  %9.0f
format c60008  %9.0f
format c60009  %9.0f
format c60010  %9.0f
format c60011  %9.0f
format c60012  %9.0f
format c60013  %9.0f
format c60014  %9.0f
format c60015  %9.0f
format c60016  %9.0f
format c60017  %9.0f
format c60018  %9.0f
format c60019  %9.0f
format c60020  %9.0f
format c60021  %9.0f
format c60022  %9.0f
format c60023  %9.0f
format c60024  %9.0f
format c60025  %9.0f
format c60026  %9.0f
format c60027  %9.0f
format c60028  %9.0f
format c60029  %9.0f
format c60030  %9.0f
format c60031  %9.0f
format c60032  %9.0f
format c60033  %9.0f
format c60034  %9.0f
format c60035  %9.0f
format c60036  %9.0f
format c60037  %9.0f
format c60038  %9.0f
format c60039  %9.0f
format c60040  %9.0f
format c60041  %9.0f
format c60042  %9.0f
format c60043  %9.0f
format c60044  %9.0f
format c60045  %9.0f
format c60046  %9.0f
format c60047  %9.0f
format c60048  %9.0f
format c60049  %9.0f
format c60050  %9.0f
format c60051  %9.0f
format c60052  %9.0f
format c60053  %9.0f
format c60054  %9.0f
format c60055  %9.0f
format c60056  %9.0f
format c60057  %9.0f
format c60058  %9.0f
format c60059  %9.0f
format c60060  %9.0f
format c60061  %9.0f
format c60062  %9.0f
format c60063  %9.0f
format c60064  %9.0f
format c60065  %9.0f
format c60066  %9.0f
format c60067  %9.0f
format c60068  %9.0f
format c60069  %9.0f
format c60070  %9.0f
format c60071  %9.0f
format c60072  %9.0f
format c60073  %9.0f
format c60074  %9.0f
format c60075  %9.0f
format c60076  %9.0f
format c62001  %9.0f
format c62002  %9.0f
format c62003  %9.0f
format c62004  %9.0f
format c62005  %9.0f
format c62006  %9.0f
format c62007  %9.0f
format c62008  %9.0f
format c62009  %9.0f
format c62010  %9.0f
format c62011  %9.0f
format c62012  %9.0f
format c62013  %9.0f
format c62014  %9.0f
format c62015  %9.0f
format c62016  %9.0f
format c62017  %9.0f
format c62018  %9.0f
format c62019  %9.0f
format c62020  %9.0f
format c62021  %9.0f
format c62022  %9.0f
format c62023  %9.0f
format c62024  %9.0f
format c62025  %9.0f
format c62026  %9.0f
format c62027  %9.0f
format c62028  %9.0f
format c62029  %9.0f
format c62030  %9.0f
format c62031  %9.0f
format c62032  %9.0f
format c62033  %9.0f
format c62034  %9.0f
format c62035  %9.0f
format c62036  %9.0f
format c62037  %9.0f
format c62038  %9.0f
format c62039  %9.0f
format c62040  %9.0f
format c62041  %9.0f
format c62042  %9.0f
format c62043  %9.0f
format c62044  %9.0f
format c62045  %9.0f
format c62046  %9.0f
format c62047  %9.0f
format c62048  %9.0f
format c62049  %9.0f
format c62050  %9.0f
format c62051  %9.0f
format c62052  %9.0f
format c62053  %9.0f
format c62054  %9.0f
format c62055  %9.0f
format c62056  %9.0f
format c62057  %9.0f
format c62058  %9.0f
format c62059  %9.0f
format c62060  %9.0f
format c62061  %9.0f
format c62062  %9.0f
format c62063  %9.0f
format c62064  %9.0f
format c62065  %9.0f
format c62066  %9.0f
format c62067  %9.0f
format c62068  %9.0f
format c62069  %9.0f
format c62070  %9.0f
format c62071  %9.0f
format c62072  %9.0f
format c62073  %9.0f
format c62074  %9.0f
format c62075  %9.0f
format c62076  %9.0f
format c62077  %9.0f
format c62078  %9.0f
format c62079  %9.0f
format c62080  %9.0f
format c62081  %9.0f
format c62082  %9.0f
format c62083  %9.0f
format c62084  %9.0f
format c62085  %9.0f
format c62086  %9.0f
format c62087  %9.0f
format c62088  %9.0f
format c62089  %9.0f
format c62090  %9.0f
format c62091  %9.0f
format c62092  %9.0f
format c62093  %9.0f
format c62094  %9.0f
format c62095  %9.0f
format c62096  %9.0f
format c62097  %9.0f
format c62098  %9.0f
format c62099  %9.0f
format c62100  %9.0f
format c62101  %9.0f
format c62102  %9.0f
format c62103  %9.0f
format c62104  %9.0f
format c62105  %9.0f
format c62106  %9.0f
format c62107  %9.0f
format c62108  %9.0f
format c62109  %9.0f
format c62110  %9.0f
format c62111  %9.0f
format c62112  %9.0f
format c62113  %9.0f
format c62114  %9.0f
format c62115  %9.0f
format c62116  %9.0f
format c62117  %9.0f
format c62118  %9.0f
format c62119  %9.0f
format c62120  %9.0f
format c62121  %9.0f
format c62122  %9.0f
format c62123  %9.0f
format c62124  %9.0f
format c62125  %9.0f
format c62126  %9.0f
format c62127  %9.0f
format c62128  %9.0f
format c62129  %9.0f
format c62130  %9.0f
format c62131  %9.0f
format c62132  %9.0f
format c62133  %9.0f
format c62134  %9.0f
format c62135  %9.0f
format c62136  %9.0f
format c62137  %9.0f
format c62138  %9.0f
format c62139  %9.0f
format c62140  %9.0f
format c62141  %9.0f
format c62142  %9.0f
format c62143  %9.0f
format c62144  %9.0f
format c62145  %9.0f
format c62146  %9.0f
format c62147  %9.0f
format c62148  %9.0f
format c62149  %9.0f
format c62150  %9.0f
format c62151  %9.0f
format c62152  %9.0f

label var year    `"Data File Year"'
label var state   `"State Name"'
label var statea  `"State Code"'
label var county  `"County Name"'
label var countya `"County Code"'
label var c60001  `"Under 1 year"'
label var c60002  `"1 year"'
label var c60003  `"2 years"'
label var c60004  `"3 years"'
label var c60005  `"4 years"'
label var c60006  `"5 years"'
label var c60007  `"6 years"'
label var c60008  `"7 years"'
label var c60009  `"8 years"'
label var c60010  `"9 years"'
label var c60011  `"10 years"'
label var c60012  `"11 years"'
label var c60013  `"12 years"'
label var c60014  `"13 years"'
label var c60015  `"14 years"'
label var c60016  `"15 years"'
label var c60017  `"16 years"'
label var c60018  `"17 years"'
label var c60019  `"18 years"'
label var c60020  `"19 years"'
label var c60021  `"20 years"'
label var c60022  `"21 years"'
label var c60023  `"22 years"'
label var c60024  `"23 years"'
label var c60025  `"24 years"'
label var c60026  `"25 years"'
label var c60027  `"26 years"'
label var c60028  `"27 years"'
label var c60029  `"28 years"'
label var c60030  `"29 years"'
label var c60031  `"30 years"'
label var c60032  `"31 years"'
label var c60033  `"32 years"'
label var c60034  `"33 years"'
label var c60035  `"34 years"'
label var c60036  `"35 years"'
label var c60037  `"36 years"'
label var c60038  `"37 years"'
label var c60039  `"38 years"'
label var c60040  `"39 years"'
label var c60041  `"40 years"'
label var c60042  `"41 years"'
label var c60043  `"42 years"'
label var c60044  `"43 years"'
label var c60045  `"44 years"'
label var c60046  `"45 years"'
label var c60047  `"46 years"'
label var c60048  `"47 years"'
label var c60049  `"48 years"'
label var c60050  `"49 years"'
label var c60051  `"50 years"'
label var c60052  `"51 years"'
label var c60053  `"52 years"'
label var c60054  `"53 years"'
label var c60055  `"54 years"'
label var c60056  `"55 years"'
label var c60057  `"56 years"'
label var c60058  `"57 years"'
label var c60059  `"58 years"'
label var c60060  `"59 years"'
label var c60061  `"60 years"'
label var c60062  `"61 years"'
label var c60063  `"62 years"'
label var c60064  `"63 years"'
label var c60065  `"64 years"'
label var c60066  `"65 years"'
label var c60067  `"66 years"'
label var c60068  `"67 years"'
label var c60069  `"68 years"'
label var c60070  `"69 years"'
label var c60071  `"70 years"'
label var c60072  `"71 years"'
label var c60073  `"72 years"'
label var c60074  `"73 years"'
label var c60075  `"74 years"'
label var c60076  `"75+ years"'
label var c62001  `"Male >> Under 1 year"'
label var c62002  `"Male >> 1 year"'
label var c62003  `"Male >> 2 years"'
label var c62004  `"Male >> 3 years"'
label var c62005  `"Male >> 4 years"'
label var c62006  `"Male >> 5 years"'
label var c62007  `"Male >> 6 years"'
label var c62008  `"Male >> 7 years"'
label var c62009  `"Male >> 8 years"'
label var c62010  `"Male >> 9 years"'
label var c62011  `"Male >> 10 years"'
label var c62012  `"Male >> 11 years"'
label var c62013  `"Male >> 12 years"'
label var c62014  `"Male >> 13 years"'
label var c62015  `"Male >> 14 years"'
label var c62016  `"Male >> 15 years"'
label var c62017  `"Male >> 16 years"'
label var c62018  `"Male >> 17 years"'
label var c62019  `"Male >> 18 years"'
label var c62020  `"Male >> 19 years"'
label var c62021  `"Male >> 20 years"'
label var c62022  `"Male >> 21 years"'
label var c62023  `"Male >> 22 years"'
label var c62024  `"Male >> 23 years"'
label var c62025  `"Male >> 24 years"'
label var c62026  `"Male >> 25 years"'
label var c62027  `"Male >> 26 years"'
label var c62028  `"Male >> 27 years"'
label var c62029  `"Male >> 28 years"'
label var c62030  `"Male >> 29 years"'
label var c62031  `"Male >> 30 years"'
label var c62032  `"Male >> 31 years"'
label var c62033  `"Male >> 32 years"'
label var c62034  `"Male >> 33 years"'
label var c62035  `"Male >> 34 years"'
label var c62036  `"Male >> 35 years"'
label var c62037  `"Male >> 36 years"'
label var c62038  `"Male >> 37 years"'
label var c62039  `"Male >> 38 years"'
label var c62040  `"Male >> 39 years"'
label var c62041  `"Male >> 40 years"'
label var c62042  `"Male >> 41 years"'
label var c62043  `"Male >> 42 years"'
label var c62044  `"Male >> 43 years"'
label var c62045  `"Male >> 44 years"'
label var c62046  `"Male >> 45 years"'
label var c62047  `"Male >> 46 years"'
label var c62048  `"Male >> 47 years"'
label var c62049  `"Male >> 48 years"'
label var c62050  `"Male >> 49 years"'
label var c62051  `"Male >> 50 years"'
label var c62052  `"Male >> 51 years"'
label var c62053  `"Male >> 52 years"'
label var c62054  `"Male >> 53 years"'
label var c62055  `"Male >> 54 years"'
label var c62056  `"Male >> 55 years"'
label var c62057  `"Male >> 56 years"'
label var c62058  `"Male >> 57 years"'
label var c62059  `"Male >> 58 years"'
label var c62060  `"Male >> 59 years"'
label var c62061  `"Male >> 60 years"'
label var c62062  `"Male >> 61 years"'
label var c62063  `"Male >> 62 years"'
label var c62064  `"Male >> 63 years"'
label var c62065  `"Male >> 64 years"'
label var c62066  `"Male >> 65 years"'
label var c62067  `"Male >> 66 years"'
label var c62068  `"Male >> 67 years"'
label var c62069  `"Male >> 68 years"'
label var c62070  `"Male >> 69 years"'
label var c62071  `"Male >> 70 years"'
label var c62072  `"Male >> 71 years"'
label var c62073  `"Male >> 72 years"'
label var c62074  `"Male >> 73 years"'
label var c62075  `"Male >> 74 years"'
label var c62076  `"Male >> 75+ years"'
label var c62077  `"Female >> Under 1 year"'
label var c62078  `"Female >> 1 year"'
label var c62079  `"Female >> 2 years"'
label var c62080  `"Female >> 3 years"'
label var c62081  `"Female >> 4 years"'
label var c62082  `"Female >> 5 years"'
label var c62083  `"Female >> 6 years"'
label var c62084  `"Female >> 7 years"'
label var c62085  `"Female >> 8 years"'
label var c62086  `"Female >> 9 years"'
label var c62087  `"Female >> 10 years"'
label var c62088  `"Female >> 11 years"'
label var c62089  `"Female >> 12 years"'
label var c62090  `"Female >> 13 years"'
label var c62091  `"Female >> 14 years"'
label var c62092  `"Female >> 15 years"'
label var c62093  `"Female >> 16 years"'
label var c62094  `"Female >> 17 years"'
label var c62095  `"Female >> 18 years"'
label var c62096  `"Female >> 19 years"'
label var c62097  `"Female >> 20 years"'
label var c62098  `"Female >> 21 years"'
label var c62099  `"Female >> 22 years"'
label var c62100  `"Female >> 23 years"'
label var c62101  `"Female >> 24 years"'
label var c62102  `"Female >> 25 years"'
label var c62103  `"Female >> 26 years"'
label var c62104  `"Female >> 27 years"'
label var c62105  `"Female >> 28 years"'
label var c62106  `"Female >> 29 years"'
label var c62107  `"Female >> 30 years"'
label var c62108  `"Female >> 31 years"'
label var c62109  `"Female >> 32 years"'
label var c62110  `"Female >> 33 years"'
label var c62111  `"Female >> 34 years"'
label var c62112  `"Female >> 35 years"'
label var c62113  `"Female >> 36 years"'
label var c62114  `"Female >> 37 years"'
label var c62115  `"Female >> 38 years"'
label var c62116  `"Female >> 39 years"'
label var c62117  `"Female >> 40 years"'
label var c62118  `"Female >> 41 years"'
label var c62119  `"Female >> 42 years"'
label var c62120  `"Female >> 43 years"'
label var c62121  `"Female >> 44 years"'
label var c62122  `"Female >> 45 years"'
label var c62123  `"Female >> 46 years"'
label var c62124  `"Female >> 47 years"'
label var c62125  `"Female >> 48 years"'
label var c62126  `"Female >> 49 years"'
label var c62127  `"Female >> 50 years"'
label var c62128  `"Female >> 51 years"'
label var c62129  `"Female >> 52 years"'
label var c62130  `"Female >> 53 years"'
label var c62131  `"Female >> 54 years"'
label var c62132  `"Female >> 55 years"'
label var c62133  `"Female >> 56 years"'
label var c62134  `"Female >> 57 years"'
label var c62135  `"Female >> 58 years"'
label var c62136  `"Female >> 59 years"'
label var c62137  `"Female >> 60 years"'
label var c62138  `"Female >> 61 years"'
label var c62139  `"Female >> 62 years"'
label var c62140  `"Female >> 63 years"'
label var c62141  `"Female >> 64 years"'
label var c62142  `"Female >> 65 years"'
label var c62143  `"Female >> 66 years"'
label var c62144  `"Female >> 67 years"'
label var c62145  `"Female >> 68 years"'
label var c62146  `"Female >> 69 years"'
label var c62147  `"Female >> 70 years"'
label var c62148  `"Female >> 71 years"'
label var c62149  `"Female >> 72 years"'
label var c62150  `"Female >> 73 years"'
label var c62151  `"Female >> 74 years"'
label var c62152  `"Female >> 75+ years"'

egen pop_16_65 = rowsum(c62017-c62066 c62093-c62142)
egen femalepop_16_65 = rowsum(c62093-c62142)
gen fips = statea||countya 

keep fips femalepop_16_65 pop_16_65

save 1980pop, replace
