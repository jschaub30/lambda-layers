#!/bin/bash
# Create Lambda layer from Docker image
# Copy bin and library files from source container

set -ex

rm -rf layer
mkdir -p layer/lib64
mkdir -p layer/lib
mkdir -p layer/bin

for binfn in convertfilestopdf convertfilestops convertformat convertsegfilestopdf convertsegfilestops converttopdf converttops fileinfo imagetops xtractprotos; do
	cp "/usr/local/bin/$binfn" layer/bin
done

# Copy the library files loaded at runtime
ldd /usr/local/bin/converttopdf | grep "=> /lib64" |
	perl -pe "s/^\s(.*) =\>.*/\1/" >lib64_files.txt
ldd /usr/local/bin/converttopdf | grep "/usr/local" |
	perl -pe "s/^\s(.*) =\>.*/\1/" >lib_files.txt

while IFS= read -r filename; do
	linked_file=$(readlink -f "/usr/lib64/$filename")
	echo "Copying $linked_file to layer/lib64/$filename"
	cp "$linked_file" "layer/lib64/$filename"
done <lib64_files.txt

while IFS= read -r filename; do
	linked_file=$(readlink -f "/usr/local/lib/$filename")
	echo "Copying $linked_file to layer/lib/$filename"
	cp "$linked_file" "layer/lib/$filename"
done <lib_files.txt

cp -r img layer/test

cd layer || exit
zip -r9 leptonica-layer.zip .
echo "Created Lambda layer layer/leptonica-layer.zip"
