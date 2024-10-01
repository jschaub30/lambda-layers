#!/bin/bash
# Create bin and library files from Poppler Utilities
LAYER_DIR=$1

[ -z "$LAYER_DIR" ] && LAYER_DIR="layer"
set -ex

rm -rf "$LAYER_DIR"
mkdir -p "$LAYER_DIR/lib64"
mkdir -p "$LAYER_DIR/bin"

for binfn in pdfattach pdfdetach pdffonts pdfimages pdfinfo pdfsig pdftocairo pdftohtml pdftoppm pdftops pdftotext pdfunite; do
	cp "/usr/bin/$binfn" "$LAYER_DIR/bin"
done

# Copy the library files loaded at runtime
ldd /usr/bin/pdftohtml | grep "=> /lib64" | \
  perl -pe "s/^\s(.*) =\>.*/\1/" >library_files.txt

while IFS= read -r filename; do
	echo "Copying $filename to $LAYER_DIR/lib64"
	docker cp "/usr/lib64/$filename" "$LAYER_DIR/lib64/"
	linked_file=$(readlink -f "/usr/lib64/$filename")
	echo "Copying $linked_file to $LAYER_DIR/lib64"
	docker cp "$linked_file" "$LAYER_DIR/lib64/$filename"
done <library_files.txt

cd "$LAYER_DIR" || exit
zip -r9 poppler-$LAYER_DIR.zip .
echo "Created Lambda layer $LAYER_DIR/poppler-layer.zip"
