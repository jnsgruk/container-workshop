## 9 - Istio

**NOTE**: This page needs more detail: not quite finished

A very basic introduction to [Istio](https://istio.io/) service mesh.

1. Install Istio using the demo profile (all dashboards/features enabled)

```bash
istioctl install --set profile=demo
```

2. Label the default namespace to enable automatic sidecar injection

```bash
# apply label
kubectl label namespace default istio-injection=enabled
# deploy the bookinfo demo application
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.6/samples/bookinfo/platform/kube/bookinfo.yaml
# add a gateway to access the application
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.6/samples/bookinfo/networking/bookinfo-gateway.yaml
# Get information about istio deployment
kubectl -n istio-system get pods
kubectl -n istio-system get svc
kubectl get describe vs # show route defintions
kubectl get pods # show sidecars
```

3. You should be able to navigate to the hosted Bookinfo application at `http://<ingress ip>/productpage`

4. Use the Kiali dashboard to visually inspect the service mesh:

```bash
istioctl dashboard kiali
```
