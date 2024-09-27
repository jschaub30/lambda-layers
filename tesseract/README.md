# Lambda layers for tesseract

The combined layer was 60MB, so I split these layers into 2 files:
- [layer/tesseract-layer.zip](layer/tesseract-layer.zip) tesseract binary and most library files
- [layer/tesseract-lib-layer.zip](layer/tesseract-lib-layer.zip) libtesseract files

I used a Macbook with an M1 chip, so use the `arm64` architecture in the Lambda function.

To build for yourself, follow these steps.

Create the docker image
```bash
docker build -t amazonlinux-tesseract.
```

Run the container:
```bash
docker run -it amazonlinux-tesseract  # the "SRC" container (see script)
```

Edit and run the [`create_layers.sh`](create_layers.sh) script.
