## Kubernetes Demos

These demos are designed to be used by the AKS cluster provisioned by [this Terraform code](../infra/aks.tf)

Once the cluster has deployed, your local kubeconfig can be populated with:

```bash
# login to Azure
az login
# Get the admin creds for the cluster
az aks get-credentials -g rg-js-wksp -n aks-js-wksp --admin
```
