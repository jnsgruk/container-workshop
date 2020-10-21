### Stage 3

Same image build as Stage 1, but shows how to create a non-root user.

1. Show the build with:

```bash
docker build -t workshop/three:latest .
```

2. Run the container and explain interactive shell:

```bash
# Run the container
docker run --rm -it workshop/three:latest /bin/ash
# Show that cowsay is installed in the container
echo "Test our package!" | cowsay
# Show that we can't modify priv things
apt update && apt install -y aircrack-ng
echo "DENIED" > /etc/hosts
```
