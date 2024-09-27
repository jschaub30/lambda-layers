# Lambda layers for tesseract

[Tesseract](https://github.com/tesseract-ocr/tesseract) is an open source optical
character recognition (OCR) engine.

The combined layer was 60MB, so I split these layers into 2 files:
- [layer/tesseract-layer.zip](layer/tesseract-layer.zip) tesseract binary and most library files
- [layer/tesseract-lib-layer.zip](layer/tesseract-lib-layer.zip) libtesseract files

Details:
- tesseract v5.4.1
  - leptonica-1.82.0
  - libpng 1.6.37
  - libtiff 4.4.0
  - zlib 1.2.11
- arm64 architecture

## Build it yourself
Create the docker image
```bash
docker build -t amazonlinux-tesseract.
```

Run the container:
```bash
docker run -it amazonlinux-tesseract  # the "SRC" container (see script)
```

Edit and run the [`create_layers.sh`](create_layers.sh) script.
