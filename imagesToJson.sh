#!/bin/bash -eu
output=_data/photos.json
imageFolder=img/full/

createImageObject() {
local height=$(ffprobe -v quiet -show_streams -print_format json ./$1 | jq '.[] | .[] | .height');
local width=$(ffprobe -v quiet -show_streams -print_format json ./$1 | jq '.[] | .[] | .width');
local imgName=$(echo $1|sed 's|full/||g' | sed 's|img/||g' | sed s'|.jpg||g');
local url="/img/full/$imgName";
local thumb="img/thumb/jpg/$imgName";
local avif="img/thumb/avif/$imgName"
local altText="kuva $imgName";

echo "  {" | tee -a $output
echo "    \"url\": \"$url.jpg\"," | tee -a $output
echo "    \"alt\": \"$altText\"," | tee -a $output
echo "    \"thumb\": \"$thumb.jpg\"," | tee -a $output
echo "    \"thumbAvif\": \"$avif.avif\"," | tee -a $output
echo "    \"thumbSize\": 300", | tee -a $output
echo "    \"width\": $width," | tee -a $output
echo "    \"height\": $height" | tee -a $output
echo "  }," | tee -a $output
}

echo "[" | tee $output
for photo in ${imageFolder}*.jpg ; do createImageObject ${photo} ; done
echo "  {}" | tee -a $output
echo "]" | tee -a $output
