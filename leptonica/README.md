# Lambda layer for leptonica

v1.82

The lambda layer is [layer/leptonica-layer.zip](layer/leptonica-layer.zip).

To build for yourself, follow these steps.

## Create the docker image
```bash
docker build -t amazonlinux-leptonica .
```

## Run the container:
```bash
docker run -it amazonlinux-leptonica  # the "SRC" container (see script)
```

Edit and run the [`create_layer.sh`](create_layer.sh) script.

I used a Macbook with an M1 chip, so use the `arm64` architecture in the Lambda function.
