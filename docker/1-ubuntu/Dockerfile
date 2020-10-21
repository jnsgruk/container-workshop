# Use a base image - Ubuntu Focal Fossa 20.04
FROM ubuntu:focal
# Set an environment variable for the package managere
ENV DEBIAN_FRONTEND=noninteractive
# Update package index and install a package
RUN apt-get update && apt-get install -y cowsay 
# Update the PATH varaible to include the package
ENV PATH=/usr/games:$PATH