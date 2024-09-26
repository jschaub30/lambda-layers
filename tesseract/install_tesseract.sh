#!/bin/bash
# Install tesseract OCR in Amazon Linux
# Run script under root/sudo
set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

yum update -y
yum install -y gcc gcc-c++ autoconf automake libtool pkgconfig \
    cairo cairo-devel pango pango-devel icu libicu libicu-devel \
    wget git libtiff-devel

# Download the latest Leptonica source code
wget http://www.leptonica.org/source/leptonica-1.82.0.tar.gz

# Extract the tarball
tar -zxvf leptonica-1.82.0.tar.gz

# Move into the source directory
cd leptonica-1.82.0 || exit
./configure
make
make install

# Clone the Tesseract source code from GitHub
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

cd "$SCRIPT_DIR" || exit
git clone https://github.com/tesseract-ocr/tesseract.git
cd tesseract || exit
git checkout 5.4.1
./autogen.sh
./configure

# Compile and install Tesseract
make
make install
ldconfig

wget https://github.com/tesseract-ocr/tessdata/raw/main/eng.traineddata \
    -P /usr/local/share/tessdata
