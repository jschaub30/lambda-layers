#!/bin/bash
# Create Lambda layer from Docker image
# Copy bin and library files from source container

set -ex

rm -rf layer
mkdir -p layer/lib64
mkdir -p layer/lib
mkdir -p layer/bin

SRC=5d0ba7366eb2  # docker container

for binfn in convertfilestopdf  convertfilestops  convertformat  convertsegfilestopdf  convertsegfilestops  converttopdf  converttops  fileinfo  imagetops  xtractprotos; do
	docker cp "$SRC:/usr/local/bin/$binfn" layer/bin
done

# Copy the library files loaded at runtime
docker exec "$SRC" ldd /usr/local/bin/converttopdf | grep lib64 | perl -pe "s/^\s(.*) =\>.*/\1/" >lib64_files.txt
docker exec "$SRC" ldd /usr/local/bin/converttopdf | grep "/usr/local" | perl -pe "s/^\s(.*) =\>.*/\1/" >lib_files.txt

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

cd layer || exit
zip -r9 leptonica-layer.zip .
echo "Created Lambda layer layer/leptonica-layer.zip"
