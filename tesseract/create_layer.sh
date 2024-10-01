#!/bin/bash
# Create Lambda layers for:
# - tesseract binary and most library files
# - tesseract libtesseract

set -ex

rm -rf layer
mkdir -p layer/lib64
mkdir -p layer/lib
mkdir -p layer/bin
mkdir -p layer/test
# mkdir -p layer/tessdata

cp img/* layer/test/

cp /usr/local/bin/tesseract layer/bin

# Copy the library files loaded at runtime
ldd /usr/local/bin/tesseract | \
  grep "/lib64" | grep -v "ld-linux" | \
  perl -pe "s/^\s(.*) =\>.*/\1/" >lib64_files.txt

ldd /usr/local/bin/tesseract | \
  grep "/usr/local" | perl -pe "s/^\s(.*) =\>.*/\1/" >lib_files.txt

while IFS= read -r filename; do
	echo "Copying $filename to layer/lib64"
	# cp "/usr/lib64/$filename" layer/lib64/
	linked_file=$(readlink -f "/usr/lib64/$filename")
	echo "Copying $linked_file to layer/lib64/$filename"
	cp "$linked_file" "layer/lib64/$filename"
done <lib64_files.txt

while IFS= read -r filename; do
	echo "Copying $filename to layer/lib"
	# cp "/usr/local/lib/$filename" layer/lib/
	linked_file=$(readlink -f "/usr/local/lib/$filename")
	echo "Copying $linked_file to layer/lib/$filename"
	cp "$linked_file" "layer/lib/$filename"
done <lib_files.txt

# Download english data
#if [ ! -f "layer/tessdata/eng.traineddata" ]; then
#  wget https://github.com/tesseract-ocr/tessdata/raw/main/eng.traineddata \
#      -P layer/tessdata
#fi
cp -r /usr/local/share/tessdata layer/tessdata

cd layer || exit
zip -r9 tesseract-layer.zip *
echo "Created Lambda layer layer/tesseract-layer.zip"
