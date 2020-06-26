adh_baseurl=http://www.ddorn.net/data/
adh_file=Autor-Dorn-Hanson-ChinaSyndrome-FileArchive.zip
adh_url=$adh_baseurl/$adh_file

cwczone_file=cw_cty_czone.zip
cwczone_url=$adh_baseurl/$cwczone_file


[[ -d adh_data ]] || mkdir adh_data
for arg in $adh_file $cwczone_file
do
  wget $adh_baseurl/$arg
  cd adh_data
  unzip ../$arg
  cd -
done
