# Use a base image - Alpine Linux
FROM alpine:latest
# Update package index and install a package
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  apk add cowsay