## Container Networking

The aim of this step is demonstrate network isolation of containers by default, how to pass through host-networking and create container networks that allow containers to talk to each other.

1. Create a container and run `ip a` to get the interface/address information. Note that it has it's own NATd IP address by default:

```bash
# Show container's IP information
docker run --rm --name network-test -i alpine:latest ip a
```

2. Containers can share host networking, although generally this is not a good idea from a security standpoint:

```bash
# Container has same networking as host here
docker run --rm --name network-test --network host -i alpine:latest ip a
```

3. Next we'll demonstrate how two containers, when created with no specific network configuration, cannot talk to each other.

```bash
# Create a container that sleeps for 3600 seconds
docker run --rm --name alpine1 --hostname alpine1 -d alpine:latest sleep 3600
# Create another container, try to ping the first. This should fail
docker run --rm --name alpine2 --hostname alpine2 -i alpine:latest ping alpine1
# Kill the containers
docker stop alpine1 alpine2
```

4. Docker does have provision to create "container networks" to enable groups of containers to talk

```bash
# Create a network
docker network create workshop-network
# Create a container and place it in the network - sleep for 3600s
docker run --rm --name alpine1-net --hostname alpine1-net --network workshop-network -d alpine:latest sleep 3600
# Create another container and ping the other container - this should succeed
docker run --rm --name alpine2-net --hostname alpine2-net --network workshop-network -i alpine:latest ping alpine1-net
# Destroy the containers and network
docker stop alpine1-net alpine2-net
docker network rm workshop-network
```
