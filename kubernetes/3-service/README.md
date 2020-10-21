## 3 - Services

[Services](https://kubernetes.io/docs/concepts/services-networking/service/) provide a means of access control to a set of pods. The simplest example is exposing the ports listening inside a deployment's pods using a load balancer.

```bash
# Create a service to expose the httpbin deployment
kubectl apply -f service.yml
# Show the service
kubectl get svc
kubectl describe svc
```

This should have exposed our httpbin deployment on the static public IP that is provisioned by the Terraform. Check the output of `kubectl get svc` to get the IP:

```bash
$ kubectl get svc
NAME         TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)          AGE
httpbin      LoadBalancer   10.0.188.74   20.49.221.222   8000:30011/TCP   3m12s
kubernetes   ClusterIP      10.0.0.1      <none>          443/TCP          18m
```

In this case, the service is now exposed at [http://20.49.221.222:8000](http://20.49.221.222:8000).
