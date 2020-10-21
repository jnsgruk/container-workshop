### Stage 2

Another really simple build just showing that containers can be built from completely different base images, but achieve largely the same thing.

1. Show the build with:

```bash
docker build -t workshop/two:latest .
```

2. Run the container and explain interactive shell:

```bash
# Run the container
docker run --rm -it workshop/two:latest /bin/ash
# Show that cowsay is installed in the container
echo "Test our package!" | cowsay
```

3. Show how despite being functionally similar, the container size can vary dramatically!

```bash
docker images | grep workshop
```

4. Dump the container image to Tar file. Open in an archive browser and show image metadata, filesystem layers. Illustrate the extra layers that were created by us modifying the contents of the container.

```bash
docker save workshop/two:latest -o image.tar
```
