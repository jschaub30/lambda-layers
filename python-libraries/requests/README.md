# Lambda layer for python requests

```bash
docker build -t amazonlinux-py39-requests .
```

```bash
docker run -it amazonlinux-py39-requests .
```

In another terminal:
```
docker ps  # note the container ID
docker cp CONTAINER:/requests-layer.zip requests-py39-layer.zip
```
