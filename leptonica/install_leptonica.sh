#!/bin/bash
# Install leptonica OCR in Amazon Linux
# Run script under root/sudo
set -x

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
