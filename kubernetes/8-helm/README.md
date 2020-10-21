## 8 - Helm

[Helm](https://helm.sh/) is a package manager for Kubernetes. We will use it here to deploy Wordpress and Gitlab to our cluster...

1. First on our admin machine, ensure Helm is installed and add some third-party repos.

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add gitlab https://charts.gitlab.io/
helm repo update
```

2. First, we'll deploy Wordpress...

```bash
# Create a new namespace
kubectl create namespace wordpress
# Install the release into the namespace
helm install wordpress bitnami/wordpress -n wordpress
# Wait for the pods to be Running
❯ kubectl -n wordpress get pods
NAME                         READY   STATUS    RESTARTS   AGE
wordpress-6bfff7bc48-92rgm   1/1     Running   0          12m
wordpress-mariadb-0          1/1     Running   0          12m
# Get the service/IP details
❯ kubectl -n wordpress get svc
NAME                TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
wordpress           LoadBalancer   10.0.103.205   20.49.143.255   80:32391/TCP,443:30526/TCP   15s
wordpress-mariadb   ClusterIP      10.0.241.155   <none>          3306/TCP                     15s
```

3. Browser to the service IP! In this case [http://20.49.143.255](http://20.49.143.255) and [http://20.49.143.255/admin](http://20.49.143.255/admin)

4. Next we'll install a version of Gitlab, and allow `cert-manager` to auto-provision us some TLS certificates. Note you may need to adjust domain names/email addresses for your use

```bash
# Create a namespace to deploy into
kubectl create namespace gitlab

# Deploy using Helm, specify our static IP LB and domains (created using Terrafor,)
helm upgrade --install gitlab gitlab/gitlab \
--namespace gitlab \
--set global.hosts.domain=jon0.co.uk \
--set global.hosts.externalIP="$(az network public-ip show -g aks-js-wksp-nodes -n pip-aks-lb-js-wksp --query "ipAddress" -otsv)" \
--set ingress.annotations="service\.beta\.kubernetes\.io/azure-dns-label-name"="pip-aks-lb-js-wksp.uksouth.cloudapp.azure.com" \
--set certmanager-issuer.email="test@email.com"

# Wait for the pods to all show running - like so:
❯ kubectl -n gitlab get pods
NAME                                                    READY   STATUS      RESTARTS   AGE
cm-acme-http-solver-4px5b                               1/1     Running     0          16m
cm-acme-http-solver-5zqjg                               1/1     Running     0          16m
cm-acme-http-solver-xf8qb                               1/1     Running     0          16m
gitlab-cainjector-67dbdcc896-qskvl                      1/1     Running     0          17m
gitlab-cert-manager-69bd6d746f-ldfbv                    1/1     Running     0          17m
gitlab-gitaly-0                                         1/1     Running     0          17m
gitlab-gitlab-exporter-bd459bcd5-tjv8g                  1/1     Running     0          17m
gitlab-gitlab-runner-78fb8c76-gcxg4                     1/1     Running     0          17m
gitlab-gitlab-shell-645664c74b-cfvbn                    1/1     Running     0          17m
gitlab-gitlab-shell-645664c74b-nxpgk                    1/1     Running     0          16m
gitlab-issuer.1-p4ph5                                   0/1     Completed   0          17m
gitlab-migrations.1-7hv5l                               0/1     Completed   0          17m
gitlab-minio-56667f8cb4-rk7m4                           1/1     Running     0          17m
gitlab-minio-create-buckets.1-f6d99                     0/1     Completed   0          17m
gitlab-nginx-ingress-controller-6866c54468-b24z6        1/1     Running     0          17m
gitlab-nginx-ingress-controller-6866c54468-dlcsj        1/1     Running     0          17m
gitlab-nginx-ingress-controller-6866c54468-ggbnr        1/1     Running     0          17m
gitlab-nginx-ingress-default-backend-55754744c6-llfww   1/1     Running     0          17m
gitlab-nginx-ingress-default-backend-55754744c6-wp4j7   1/1     Running     0          17m
gitlab-postgresql-0                                     2/2     Running     0          17m
gitlab-prometheus-server-768cd8f69-dj2x6                2/2     Running     0          17m
gitlab-redis-master-0                                   2/2     Running     0          17m
gitlab-registry-6b87c6c747-28nbq                        1/1     Running     0          17m
gitlab-registry-6b87c6c747-t7p74                        1/1     Running     0          17m
gitlab-sidekiq-all-in-1-v1-6976f7fbcb-q2j5c             1/1     Running     0          17m
gitlab-task-runner-5575c7bbc-6sfx6                      1/1     Running     0          17m
gitlab-webservice-67cbb6c45d-5p4m2                      2/2     Running     0          17m
gitlab-webservice-67cbb6c45d-9whxw                      2/2     Running     0          16m
```

5. If using the managed DNS setup through the Terraform provided, browse to [https://gitlab.jon0.co.uk](https://gitlab.jon0.co.uk)!
