# Lambda layer for poppler utilities

Create the docker image
```bash
docker build -t amazonlinux-poppler .
```

Run the container:
```bash
docker run -it amazonlinux-poppler  # the "SRC" container (see script)
```

See the [`create_layer.sh`][create_layer.sh] script for more details.

The resulting lambda layer is [layer/poppler-layer.zip](layer/poppler-layer.zip).

I used a Macbook with an M1 chip, so use the `arm64` architecture in the Lambda function.
