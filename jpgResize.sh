#!/bin/bash -eu
input=/img/full/
output=/img/full/
ext=.jpg
startDir=$(pwd)
minSize=2400

resizeJpg() {
    inputFile="$1"; shift
    fileName=$(basename -s .jpg ${inputFile});
    convert ${inputFile} -resize "${minSize}x${minSize}^>" -strip ${startDir}${output}${fileName}${ext}
    echo "image" $fileName "done!"
}

for photo in ${startDir}${input}*.jpg ; do resizeJpg ${photo} ; done
echo "job done!"
