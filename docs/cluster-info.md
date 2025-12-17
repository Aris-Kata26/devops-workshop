# Cluster Information

## Infrastructure

### Proxmox Details
- **Host:** 10.0.10.71
- **Node:** bcc07
- **Template ID:** 200 (ubuntu-2404-template)

### VM Details

| VM Name | VM ID | IP Address | Role | CPU | Memory | Disk |
|---------|-------|------------|------|-----|--------|------|
| k8s-master | 102 | 10.0.96.10/24 | Control Plane | 2 cores | 8GB | 15GB |
| k8s-worker-1 | 103 | 10.0.96.11/24 | Worker | 2 cores | 8GB | 15GB |
| k8s-worker-2 | 104 | 10.0.96.12/24 | Worker | 2 cores | 8GB | 15GB |

### Network Configuration
- **Gateway:** 10.0.96.1
- **Subnet:** 10.0.96.0/24
- **Bridge:** vmbr0

## Access Credentials

### SSH Access
- **Username:** ubuntu
- **Password:** test..123
- **SSH Key:** katar711@school.lu

```bash
# Connect to master
ssh ubuntu@10.0.96.10

# Connect to workers
ssh ubuntu@10.0.96.11
ssh ubuntu@10.0.96.12
```

## Kubernetes Cluster

### Cluster Configuration
- **Cluster Name:** devops-workshop
- **Kubernetes Version:** v1.28.6 (to be installed)
- **CNI Plugin:** Calico
- **Container Runtime:** containerd

### Components to Install
- [x] Infrastructure (Terraform) - **Completed**
- [ ] Kubernetes Cluster (Kubespray) - **Next**
- [ ] Local-path Provisioner (Storage)
- [ ] ArgoCD (GitOps)
- [ ] kube-prometheus-stack (Monitoring)
- [ ] Mission Control Application

## Service URLs (After Deployment)

Will be updated after services are deployed:

- **Kubernetes API:** https://10.0.96.10:6443
- **ArgoCD:** https://argocd.devops-workshop.local (TBD)
- **Grafana:** https://grafana.devops-workshop.local (TBD)
- **Prometheus:** https://prometheus.devops-workshop.local (TBD)
- **Mission Control Frontend:** https://mission-control.devops-workshop.local (TBD)
- **Mission Control Backend:** https://api.mission-control.devops-workshop.local (TBD)

## Important Notes

- VMs take 2-3 minutes to fully boot after creation
- QEMU guest agent warnings are normal during initial boot
- Ensure all nodes are reachable before running Kubespray
- Keep this document updated as services are deployed

## Terraform State

- **State File:** `infra/terraform.tfstate`
- **Backend:** Local
- **Last Applied:** December 16, 2025
