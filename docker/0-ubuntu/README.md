### Stage 0

This stage illustrates the most basic container build I could think of. Essentially just creates a new container using the Ubuntu Focal base image.

1. Show the build with:

```bash
docker build -t workshop/zero:latest .
```

2. Run the container and explain interactive shell:

```bash
docker run --rm -it workshop/zero:latest /bin/bash
```

3. Dump the container image to Tar file. Open in an archive browser and show image metadata, filesystem layers. Link back to OCI slide.

```bash
docker save workshop/zero:latest -o image.tar
```
