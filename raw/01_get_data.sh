#!/bin/bash
WGET_OPTS="--no-check-certificate"

[[ -f 1990jtw_raw.txt ]] ||  wget $WGET_OPTS -O 1990jtw_raw.txt https://www2.census.gov/programs-surveys/commuting/datasets/1990/worker-flow/usresco.txt

[[ -f jtw2000_raw.txt ]] || wget $WGET_OPTS -O jtw2000_raw.txt https://www2.census.gov/programs-surveys/decennial/tables/2000/county-to-county-worker-flow-files/2kresco_us.txt 

#[[ -f acs_2009_2013.csv ]] || wget $WGET_OPTS -O acs_2009_2013.csv http://www.census.gov/hhes/commuting/files/2013/Table%201%20County%20to%20County%20Commuting%20Flows-%20ACS%202009-2013.xlsx
[[ -f acs_2009_2013.xlsx ]] || wget $WGET_OPTS -O acs_2009_2013.xlsx https://www2.census.gov/programs-surveys/commuting/tables/time-series/commuting-flows/table1.xlsx

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
