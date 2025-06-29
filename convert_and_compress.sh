#!/bin/bash

rm -rf converted_images
rm -rf temp
mkdir -p converted_images
mkdir -p temp

for file in images/*.jfif; do
    filename=$(basename "$file")
    renamed_filename=$(basename "$file" .jfif).jpg
    ffmpeg -i images/$filename temp/$renamed_filename
done
for file in images/*.jpg; do
    filename=$(basename "$file")
    ffmpeg -i "images/$filename" -vf "scale='min(1920,iw)':-2" -frames:v 1 "converted_images/$filename"
done
for file in images/*.png; do
    filename=$(basename "$file")
    ffmpeg -i "images/$filename" -vf "scale='min(1920,iw)':-2" -frames:v 1 "converted_images/$filename"
done
for file in temp/*.jpg; do
    filename=$(basename "$file")
    ffmpeg -i "temp/$filename" -vf "scale='min(1920,iw)':-2" -frames:v 1 "converted_images/$filename"
done

rm -rf temp
