### 1 - Pods

[Pods](https://kubernetes.io/docs/concepts/workloads/pods/) are the smallest deployable unit in a Kubernetes cluster. A pod represents one or more running containers.

```bash
# Apply the pod spec in this directory
kubectl apply -f pod.yml
# Watch the pod starting up
kubectl get pods -w
# Get details about the pod
kubectl describe pod httpbin
# See events from the cluster
kubectl get events
```

The `kubectl` tool can also accept input from stdin, one could create the same pod like so:

```bash
cat <<-EOF | kubectl apply -f -
---
apiVersion: v1
kind: Pod
metadata:
  name: httpbin
spec:
  containers:
    - image: docker.io/kennethreitz/httpbin
      imagePullPolicy: IfNotPresent
      name: httpbin
      ports:
        - containerPort: 80
EOF
```
