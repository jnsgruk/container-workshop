## Ansible Playbook Demos

This section contains some basic Ansible examples to demonstrate how Ansible can be used to

- Configure virtual machines
- Address different [groups of hosts](./inventory)
- [Interact with Docker](./docker-playbook.yml) on a remote host
- [Interact with a Kubernetes Cluster](./k8s-playbook.yml)

### Role/Playbook Explanation

```bash
├── docker-playbook.yml     # Show how to build a Docker image and run a container
├── files                   # Contains service definition used by k8s-playbook.yml
├── inventory               # Ansible inventory
├── k8s-playbook.yml        # Create namespace, inline deployment, service from file
├── main-playbook.yml       # Configures Azure VMs in various roles
├── README.md
└── roles
    ├── common              # Installs some generic packages, configures UFW
    ├── database            # Installs PostgreSQL and configures firewall
    ├── docker              # Installs Docker and Docker Compose
    └── webserver           # Installs nginx and configures a default webpage (jnsgr.uk)
```

### Configuring/Using These Roles

If using the infrastructure deployment that [ships with this repo](../terraform), you'll need to populate the [inventory](./inventory) with some IP addresses returned by `terraform output` once the infra is created.

The playbooks are run like so:

```bash
# Run the main playbook to configure web/database servers
ansible-playbook -i inventory main-playbook.yml
# Run the Docker playbook on local machine
ansible-playbook -K docker-playbook.yml
# Run the K8s playbook on local machine
ansible-playbook -K k8s-playbook.yml
```
