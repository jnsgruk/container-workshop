## 2 - Deployments

[Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) are a simple way to enable Kubernetes to manage a set of pods. They ensure that a certain number of replicas of a specified pod are always running - meaning if a pod crashed, or is deleted, it will be automatically recreated

```bash
# Create a deployment
kubectl apply -f deployment.yml
# Show the deployment
kubectl get deployments
kubectl describe deployment
# Show the pods
kubectl get pods
```

Deployments can be easily updated. Next we'll scale the deployment up and down using two seperate methods. The first involves editing the yaml file and re-applying it. The second uses the `kubectl` tool.

```bash
# Update the deployment yaml
sed -i 's/replicas: 2/replicas: 4/g' deployment.yml
# Reapply the manifest
kubectl apply -f deployment.yml
# Show the new pods created
kubectl get pods
# Scale the deployment back down
kubectl scale deployment httpbin --replicas=2
# Show old pods terminating/removed
kubectl get pods
```
