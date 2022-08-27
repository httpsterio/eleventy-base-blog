#!/bin/bash
output=_data/photos.json
imageFolder=img/full/
thumbFolder=img/thumb/
altPrefix="kuva"

createImageObject() {
local height=$(ffprobe -v quiet -show_streams -print_format json ./$1 | jq '.[] | .[] | .height');
local width=$(ffprobe -v quiet -show_streams -print_format json ./$1 | jq '.[] | .[] | .width');
local url="$1";
local thumb=$(echo $1|sed 's|full|thumb|g')

echo "  {" | tee -a $output
echo "    \"url\": \"/$url\"," | tee -a $output
echo "    \"thumb\": \"/$thumb\"," | tee -a $output
echo "    \"width\": $width," | tee -a $output
echo "    \"height\": $height" | tee -a $output
echo "  }," | tee -a $output
}

echo "[" | tee $output
for photo in ${imageFolder}*.jpg ; do createImageObject ${photo} ; done
echo "  {}" | tee -a $output
echo "]" | tee -a $output
