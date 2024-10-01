# Lambda layers for tesseract

[Tesseract](https://github.com/tesseract-ocr/tesseract) is an open source optical
character recognition (OCR) engine.

The layer can be found at [layers/tesseract-layer-x86_64.zip](layers/tesseract-layer-x86_64.zip).

Use the [lambda_test_function.py](lambda_test_function.py) to test.  It should complete in around
13 seconds with the default Lambda memory settings.

### Details
- tesseract v5.4.1
  - leptonica-1.82.0
  - libpng 1.6.37
  - libtiff 4.4.0
  - zlib 1.2.11
- arm64 architecture

## Build it yourself
Create an EC2 instance using the amazonlinux:2023 AMI.

Copy and run the [`install_tesseract.sh`](install_tesseract.sh) script.

Run the [`create_layers.sh`](create_layers.sh) script.
