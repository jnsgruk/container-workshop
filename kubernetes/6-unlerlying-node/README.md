## 6 - Underlying Nodes

This section will show some interaction with the underlying compute nodes that support the AKS cluster.

Firstly, let's show the nodes:

```bash
# Get the nodes
❯ kubectl get nodes
NAME                              STATUS   ROLES   AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
aks-default-21036679-vmss000000   Ready    agent   37m   v1.18.6   10.240.0.4    <none>        Ubuntu 18.04.5 LTS   5.4.0-1026-azure   docker://19.3.12
aks-default-21036679-vmss000001   Ready    agent   37m   v1.18.6   10.240.0.35   <none>        Ubuntu 18.04.5 LTS   5.4.0-1026-azure   docker://19.3.12
aks-default-21036679-vmss000002   Ready    agent   37m   v1.18.6   10.240.0.66   <none>        Ubuntu 18.04.5 LTS   5.4.0-1026-azure   docker://19.3.12
```

Next inspect the [node.yml](./node.yml). Before applying you need to take the following steps (**NOTE**: this will put your private key on the cluster as a secret):

```bash
# This will replace the key data with the base64 encoded version of your private key
sed -i "0,/key: .*$/s//key: $(cat ~/.ssh/id_rsa | base64 -w0)/" node.yml
```

Now we'll create the resources, and ssh into the underlying node from a pod (a scenario you'd probably want to block with network policy in production!)

```bash
# Create the resources
kubectl create -f node.yml
# Exec into the container in the pod
kubectl exec -n node-test -it aks-ssh -- /bin/bash
# Now, inside the container...
# Install the OpenSSH client in the container
apt update && apt install -y openssh-client
# SSH into the node - choose a node IP from the output of kubectl get nodes -o wide
ssh azure_admin@10.240.0.4
# Show all the K8s stuff (and our deployments!) running on the node
docker ps -a
# Quit the SSH with Ctrl+D, then Ctrl+D again to drop out of the container shell
# Now back on your machine...
# Cleanup the resources we created
kubectl delete -f node.yml
```
