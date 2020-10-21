### Stage 6

Illustrates a multi-stage build that can be used to reduce the overall size of a deployed image and guarantee that build dependencies are not included in production/runtime containers. Also shows to to build a container from scratch where possible.

1. Show the build with:

```bash
# Build the container
docker build -t workshop/six:latest .
# Show the size difference..
docker images | grep -E "golang|six"
```

2. Run the container and browse to the [page presented](http://localhost)

```bash
docker run --rm --name app -d -p 80:8080 workshop/six:latest
```

3. Demonstrate contents of a scratch container

```bash
# Exec into the container - oops, we can't!
docker exec -it app /bin/bash
# Maybe try listing directory?
docker exec app ls /
# Nope!
```

4. Demonstrate exporting a running container. Open the resulting tar file and show the filesystem layer (singular!)

```bash
docker export app -o app.tar && sudo chown jon: app.tar && open app.tar
```

5. Kill the container

```bash
docker stop app
```
