## 7 - Network Policy

Here we will demonstrate very basic [network policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/) by blocking all communications to a specific namespace.

1. Get the IPs of some pods....

```bash
# First in the whoami namespace - note the full name and IP of a pod
❯ kubectl get pods -n whoami -o custom-columns=NAME:.metadata.name,IP:.status.podIP
NAME                      IP
whoami-5ddb55dbc4-77gnk   10.240.0.36
whoami-5ddb55dbc4-grjhd   10.240.0.75
whoami-5ddb55dbc4-jqbm5   10.240.0.15
whoami-5ddb55dbc4-wj7r2   10.240.0.10
# Same in the default namespace - note the full name and IP of a pod
❯ kubectl get pods -n default -o custom-columns=NAME:.metadata.name,IP:.status.podIP
NAME                       IP
httpbin-77bfc6b755-gds5c   10.240.0.84
httpbin-77bfc6b755-kgs8d   10.240.0.39
```

2. Now , we'll exec into a pod in the `httpbin` deployment, and curl a pod in the `whoami` namespace

```bash
# Exec into httpbin
kubectl exec -it httpbin-77bfc6b755-gds5c -- /bin/bash
# install curl in the container
$ apt update && apt install -y curl
# curl a pod in the whoami namespace
$ curl 10.240.0.36
Hostname: whoami-5ddb55dbc4-77gnk
IP: 127.0.0.1
IP: 10.240.0.36
RemoteAddr: 10.240.0.84:36918
GET / HTTP/1.1
Host: 10.240.0.36
User-Agent: curl/7.58.0
Accept: */*
# Exit the container shell with Ctrl+D
```

3. Now we'll apply the [network policy](./policy.yml) and try again...

```bash
# apply the policy - blocks comms to whoami namespace
kubectl apply -f policy.yml
# Exec into httpbin
kubectl exec -it httpbin-77bfc6b755-gds5c -- /bin/bash
# try to curl
$ curl 10.240.0.36
# fails! our policy works!
```
