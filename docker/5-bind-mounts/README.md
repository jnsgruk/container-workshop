## Stage 5

This shows how we can achieve the same result as Stage 4, but by just bind mounting a directory into the nginx container

1. Run the container with a bind mount:

```
docker run --rm --name website -v $PWD/website-src:/usr/share/nginx/html -p 80:80 -d nginx:latest
```

2. Demonstrate running container and logs

```bash
# show running container, ports, etc.
docker ps -a
# show the logs
docker logs -f website
```

3. Browse to the website, show it running and kill the container

```bash
docker stop website
```
