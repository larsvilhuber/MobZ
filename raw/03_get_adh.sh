adh_baseurl=http://www.ddorn.net/data/
adh_file=Autor-Dorn-Hanson-ChinaSyndrome-FileArchive.zip
adh_url=$adh_baseurl/$adh_file
wget $adh_url
[[ -d adh_data ]] || mkdir adh_data
cd adh_data
unzip ../$adh_file
