### Workshop Infrastructure

This Terraform code will provision the following on Microsoft Azure:

- 1x Azure Kubernetes Service cluster with 3 nodes

  - Azure Active Directory RBAC Enabled
  - System Assigned Identity
  - Node admin username is `azure_admin`
  - Azure CNI enabled for Network Policy enablement
  - A static load balancer IP

- 3x Azure Virtual Machines

  - Public IPs assigned, accessible from IP that deployed the resources
  - SSH and HTTP ports accessible from deployment IP

- 3x DNS Records on DigitalOcean (if [dns.tf](./dns.tf)) contents uncommented
  - Used to demonstrate a Helm deployment of Gitlab
  - Can be created manually to point to the Load Balancer public IP
