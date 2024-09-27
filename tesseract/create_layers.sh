#!/bin/bash
# Create Lambda layers for:
# - tesseract binary and most library files
# - tesseract libtesseract
# Copy bin and library files from running source container (where tesseract is installed)

set -ex

rm -rf layer
mkdir -p layer/lib64
mkdir -p layer/lib
mkdir -p layer/bin
mkdir -p layer/tessdata

SRC=8346f42936e0  # docker container

for binfn in tesseract; do
	docker cp "$SRC:/usr/local/bin/$binfn" layer/bin
done

# Copy the library files loaded at runtime
docker exec "$SRC" ldd /usr/local/bin/tesseract | \
  grep lib64 | perl -pe "s/^\s(.*) =\>.*/\1/" >lib64_files.txt

docker exec "$SRC" ldd /usr/local/bin/tesseract | \
  grep "/usr/local" | perl -pe "s/^\s(.*) =\>.*/\1/" >lib_files.txt

while IFS= read -r filename; do
	echo "Copying $filename to layer/lib64"
	docker cp "$SRC:/usr/lib64/$filename" layer/lib64/
	linked_file=$(docker exec "$SRC" readlink -f "/usr/lib64/$filename")
	echo "Copying $linked_file to layer/lib64"
	docker cp "$SRC:$linked_file" layer/lib64/
done <lib64_files.txt

while IFS= read -r filename; do
	echo "Copying $filename to layer/lib"
	docker cp "$SRC:/usr/local/lib/$filename" layer/lib/
	linked_file=$(docker exec "$SRC" readlink -f "/usr/local/lib/$filename")
	echo "Copying $linked_file to layer/lib"
	docker cp "$SRC:$linked_file" layer/lib/
done <lib_files.txt

# Download english data
wget https://github.com/tesseract-ocr/tessdata/raw/main/eng.traineddata \
    -P layer/tessdata

cd layer || exit
zip -r9 tesseract-layer.zip bin lib64 lib/liblept* tessdata/* test/*
zip -r9 tesseract-lib-layer.zip lib/libt*
echo "Created Lambda layer layer/tesseract-layer.zip"
