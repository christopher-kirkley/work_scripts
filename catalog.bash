#!/bin/bash

# Small script to generate directory structure for
# record catalog project.

while [[ $catalog_number == "" ]]
do
	read -p "catalog number : " catalog_number
done

read -p "artist name : " artist_name

while [[ $catalog_name == "" ]]
do
	read -p "catalog name : " catalog_name
done

if [[ $artist_name == "" ]]; then
	dir=${catalog_number}_${catalog_name// /_}
else
	dir=${catalog_number}_${artist_name// /_}_${catalog_name// /_}
fi

mkdir -p $dir $dir/art/{lookbook,draft,final} $dir/audio/{rough,ddp,wav} $dir/info/{photos,press}

# copy templates

# create some blank files
