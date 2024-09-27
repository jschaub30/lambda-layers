# Lambda layer for Poppler Utilities

[Poppler](https://poppler.freedesktop.org/) is an open source PDF rendering library.

The lambda layer is [layer/poppler-layer.zip](layer/poppler-layer.zip).
- Version 22.08.0 of Poppler
- `arm64` architecture

 # Build it yourself
Create the docker image
```bash
docker build -t amazonlinux-poppler .
```

```bash
docker run -it amazonlinux-poppler  # the "SRC" container (see script)
```

Edit and run the [`create_layer.sh`](create_layer.sh) script.
