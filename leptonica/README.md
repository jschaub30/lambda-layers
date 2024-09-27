# Lambda layer for leptonica

[Leptonica](http://www.leptonica.org/) is a open source library containing software that
is broadly useful for image processing and image analysis applications.

The lambda layer is [layer/leptonica-layer.zip](layer/leptonica-layer.zip).
- v1.8.2
- arm64 architecture

## Build it yourself
Create the docker image
```bash
docker build -t amazonlinux-leptonica .
```

Run the container:
```bash
docker run -it amazonlinux-leptonica  # the "SRC" container (see script)
```

Edit and run the [`create_layer.sh`](create_layer.sh) script.
