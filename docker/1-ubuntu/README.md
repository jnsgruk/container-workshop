### Stage 1

A slightly more complex example that downloads and installs a new package, and adjusts the PATH variable inside the container

1. Show the build with:

```bash
docker build -t workshop/one:latest .
```

2. Run the container and explain interactive shell:

```bash
# Run the container
docker run --rm -it workshop/one:latest /bin/bash
# Show that cowsay is installed in the container
echo "Test our package!" | cowsay
```

3. Show how we can manipulate the container hostname from the command line as we start the container:

```bash
docker run --rm --name test --hostname ubuntu -it workshop/one:latest /bin/bash
```

4. Dump the container image to Tar file. Open in an archive browser and show image metadata, filesystem layers. Illustrate the extra layers that were created by us modifying the contents of the container.

```bash
docker save workshop/one:latest -o image.tar
```
