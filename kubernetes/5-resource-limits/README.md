## 5 - Resource Limits

[Resource Limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) allow the operator to control how much CPU and memory a pod/deployment is allowed to consume.

Review [resources.yml](./resources.yml) and note the limits on the pod spec. This will be deployed into a new namespace named `whoami-limited`

```bash
# Create the namespace, deployment
kubectl apply -f resources.yml
# Show everything in our new namespace
kubectl -n whoami-limited get all
# Describe the deployment
❯ kubectl -n whoami-limited describe deployment
Name:                   whoami-limited
Namespace:              whoami-limited
CreationTimestamp:      Wed, 21 Oct 2020 10:31:31 +0100
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=whoami-limited
Replicas:               4 desired | 4 updated | 4 total | 4 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=whoami-limited
  Containers:
   whoami-limited:
    Image:      docker.io/containous/whoami
    Port:       80/TCP
    Host Port:  0/TCP
    Limits:
      cpu:     250m
      memory:  128Mi
    Requests:
      cpu:        100m
      memory:     64Mi
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   whoami-limited-f6df44b5f (4/4 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  49s   deployment-controller  Scaled up replica set whoami-limited-f6df44b5f to 4
```
