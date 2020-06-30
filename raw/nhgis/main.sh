#!/bin/bash

stata=$(which stata)

if [[ -z $stata ]]
then
	echo "Need stata in the path, or edit the script"
	exit 2
fi

for arg in $(ls *do)
do
	$stata -b do $arg
done

