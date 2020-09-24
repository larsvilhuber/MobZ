#!/bin/bash
WGET_OPTS="--no-check-certificate"

# CZ
curl https://www.ers.usda.gov/webdocs/DataFiles/48457/czlma903.xls?v=6997.1 > czlma903.xls

# JTW
[[ -f 1990jtw_raw.txt ]] ||  wget $WGET_OPTS -O 1990jtw_raw.txt https://www2.census.gov/programs-surveys/commuting/datasets/1990/worker-flow/usresco.txt

[[ -f jtw2000_raw.txt ]] || wget $WGET_OPTS -O jtw2000_raw.txt https://www2.census.gov/programs-surveys/decennial/tables/2000/county-to-county-worker-flow-files/2kresco_us.txt 

## this has been moved to the next program
## [[ -f acs_2009_2013.xlsx ]] || wget $WGET_OPTS -O acs_2009_2013.xlsx https://www2.census.gov/programs-surveys/commuting/tables/time-series/commuting-flows/table1.xlsx

# BEA

[[ -f CAINC30.zip ]] || wget $WGET_OPTS https://apps.bea.gov/regional/zip/CAINC30.zip
if [[ -f CAINC30__ALL_AREAS_1969_2018.csv ]]
then
   echo "BEA present"
else
   if [[ -f CAINC30.zip ]]
   then
      unzip CAINC30.zip CAINC30__ALL_AREAS_1969_2018.csv
      echo "Unzipped BEA file"
   fi 
fi  
# LAUS

function do_nothing {
# these are actually not parsable by machine... easily anyway

for (( i=90; i<100; i++ ))
do
 file=laucnty$i.txt
 [[ -f $file ]] ||  wget $WGET_OPTS https://www.bls.gov/lau/$file
done

for (( i=0; i<10; i++ ))
do
 file=laucnty0$i.txt
 [[ -f $file ]] ||  wget $WGET_OPTS https://www.bls.gov/lau/$file
done

for (( i=10; i<16; i++ ))
do
 file=laucnty$i.txt
 [[ -f $file ]] ||  wget $WGET_OPTS https://www.bls.gov/lau/$file
done
}

# alternate way to get the LAU data
UFILE=la.data.0.CurrentU_ALL
if [[ -f $UFILE ]]
then
	echo $UFILE already present - if you want to re-run this, remove it manually
	echo rm -f $UFILE
else 
 for arg in 00-04 05-09 10-14 15-19 90-94 95-99
 do
  wget -O - $WGET_OPTS https://download.bls.gov/pub/time.series/la/la.data.0.CurrentU$arg | grep LAUCN >> $UFILE
 done
fi

# SEER data
#if [ ! -f  us.1990_2018.singleages.adjusted.txt.gz ]
#then
#curl  https://seer.cancer.gov/popdata/yr1990_2018.singleages/us.1990_2018.singleages.adjusted.txt.gz >  us.1990_2018.singleages.adjusted.txt.gz
#fi
curl https://data.nber.org/seer-pop/uswbosingleagesadj.dta.zip > uswbosingleagesadj.dta.zip
unzip uswbosingleagesadj.dta.zip
