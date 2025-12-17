# Architecture Overview

## System Layers

### Infrastructure Layer
- Proxmox VMs (Terraform)

### Orchestration Layer
- Kubernetes (Kubespray)

### GitOps Layer
- ArgoCD

### Application Layer
- Mission Control (Backend/Frontend)

### CI/CD Layer
- GitHub Actions -> Cloud Registry

### Monitoring Layer
- Prometheus/Grafana/AlertManager

### Storage Layer
- Local-Path PV

## Data Flow
1. Code pushed to GitHub
2. GitHub Actions builds Docker images
3. Images pushed to cloud registry
4. ArgoCD syncs from Git manifests
5. Kubernetes deploys applications
6. Prometheus monitors cluster and apps
7. Grafana visualizes metrics
