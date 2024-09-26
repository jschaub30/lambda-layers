#!/bin/bash
# Copy bin and library files from source container (where poppler is installed)

set -ex

# rm -rf layer
mkdir -p layer/lib64
mkdir -p layer/bin

SRC=7f30e5e3cc24 # docker container

for binfn in pdfattach pdfdetach pdffonts pdfimages pdfinfo pdfsig pdftocairo pdftohtml pdftoppm pdftops pdftotext pdfunite; do
	docker cp "$SRC:/usr/bin/$binfn" layer/bin
done

# Copy the library files loaded at runtime
docker exec "$SRC" ldd /usr/bin/pdftohtml | grep lib64 | perl -pe "s/^\s(.*) =\>.*/\1/" > library_files.txt

while IFS= read -r filename; do
	echo "Copying $filename to layer/lib64"
	docker cp "$SRC:/usr/lib64/$filename" layer/lib64/
	linked_file=$(docker exec "$SRC" readlink -f "/usr/lib64/$filename")
	echo "Copying $linked_file to layer/lib64"
	docker cp "$SRC:$linked_file" layer/lib64/
done < library_files.txt

cd layer || exit
zip -r9 poppler-layer.zip .
echo "Created Lambda layer layer/poppler-layer.zip"
