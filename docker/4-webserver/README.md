### Stage 4

Builds a custom webserver container. Based upon nginx, and static content from [jnsgr.uk](https://jnsgr.uk) copied across into default web root

1. Show the build with:

```bash
docker build -t workshop/four:latest .
```

2. Run the container **as a daemon** this time - explain the difference:

```bash
# run the container
docker run --rm --name nginx -d workshop/four:latest
# show it in the list of running containers
docker ps -a
```

3. Note that this is a little useless, and we'd need to expose a port to the container host to access the webserver in the container. Restart the container with a port mapping:

```bash
# stop the old container
docker stop nginx
# create a new container with a port mapping
docker run --rm --name nginx -d -p 80:80 workshop/four:latest
# show the port mapping
docker ps -a
# show how while in daemon mode, you can still exec into the container
docker exec -it nginx /bin/bash
# show how to get the logs of a background container
docker logs nginx
# follow the logs
docker logs -f nginx
# kill the container
docker stop nginx
```
