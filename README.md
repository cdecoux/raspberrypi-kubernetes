# raspberrypi-kubernetes
This repo manages a Raspberry Pi K3s (Kubernetes) cluster. 

k3s: https://k3s.io/

## Prerequisites
### Raspberry PIs:
- Setup Raspberry Pis with Raspbian (Can try other OS's, but I tested this with Raspbian Buster)
- Setup SSH (preferably passwordless with ssh key)
- Setup host names for driver and worker nodes. I used `raspberry-driver` as the driver node hostname (which is referenced in the Makefile.)
### Local
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- Terraform ([tfenv](https://github.com/tfutils/tfenv) supported via the `.terraform-version` file.)
- [Lens IDE](https://k8slens.dev/) (Recommended for general K8s Management, not needed to run through this repo)

## Steps
Once nodes are setup as specified above and SSH connection is setup, proceedd with using Ansible and Terraform for setup:
1) Add node hostnames or IPs to `inventory/hosts.ini`
2) If needed, edit `inventory/group_vars/all.yml` to match your environment (such as SSH username).
3) Run `make install` (runs through the ansible playbook)
4) Run `make kubeconfig` (copies the kubeconfig from the driver node to `~/.kube/config-pi`) 
   1) This config location is the default for the Terraform configs.
5) Run `terraform init`
6) Run `terraform apply`

---
### TODO
- K8s Ingresses for LAN connection
- [SealedSecrets](https://github.com/bitnami-labs/sealed-secrets)
- [Local Docker Registry](https://docs.docker.com/registry/) (To host local custom Dockerfiles)