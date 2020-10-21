## 4 - Load Balancer Demo

Review the [lb.yml](./lb.yml) file. Here we will create:

- A Kubernetes [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) called `whoami`
- Create a deployment of the `whoami` container with 4 replicas
- Create a load balancer to expose this service on port 5000

```bash
# Create the namespace, deployment and service
kubectl apply -f lb.yml
# Show everything in our new namespace
kubectl -n whoami get all
```

This should have exposed our `whoami` deployment on the static public IP that is provisioned by the Terraform. Check the output of `kubectl -n whoami get svc` to get the IP:

```bash
$ kubectl get svc
NAME     TYPE           CLUSTER-IP   EXTERNAL-IP   PORT(S)          AGE
whoami   LoadBalancer   10.0.29.13   20.50.99.56   5000:30916/TCP   60s
```

In this case, the service is now exposed at [http://20.50.99.56:5000](http://20.50.99.56:5000). Performing multiple `curl`s against this endpoint should show the underlying pod IP changing as the load balancer rotates the traffic:

```bash
❯ curl 20.50.99.56:5000
Hostname: whoami-5ddb55dbc4-77gnk
IP: 127.0.0.1
IP: 10.240.0.36                    # <------------
RemoteAddr: 10.240.0.66:30439
GET / HTTP/1.1
Host: 20.50.99.56:5000
User-Agent: curl/7.73.0
Accept: */*

❯ curl 20.50.99.56:5000
Hostname: whoami-5ddb55dbc4-wj7r2
IP: 127.0.0.1
IP: 10.240.0.10                     # <------------
RemoteAddr: 10.240.0.4:37081
GET / HTTP/1.1
Host: 20.50.99.56:5000
User-Agent: curl/7.73.0
Accept: */*

❯ curl 20.50.99.56:5000
Hostname: whoami-5ddb55dbc4-grjhd
IP: 127.0.0.1
IP: 10.240.0.75                     # <------------
RemoteAddr: 10.240.0.35:35402
GET / HTTP/1.1
Host: 20.50.99.56:5000
User-Agent: curl/7.73.0
Accept: */*
```
