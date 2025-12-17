# 3 Day DevOps Workshop

A hands-on implementation of DevOps, GitOps, Kubernetes, CI/CD, and Monitoring for BTS Cloud Computing.

## Architecture Overview
- Infrastructure: Proxmox with Terraform-provisioned VMs.
- Orchestration: Kubernetes cluster via Kubespray.
- GitOps: ArgoCD for deployments.
- Application: Mission Control microservices (backend/frontend).
- CI/CD: GitHub Actions with versioned Docker builds to cloud registry.
- Monitoring: kube-prometheus-stack with persistence.
- Storage: local-path provisioner.

## Setup
- Prerequisites: Proxmox access, GitHub account, cloud provider (AWS/AZURE/GCP), WSL2/VS Code.
- Run `terraform apply` in /infra for VMs.

## Documentation
See /docs for diagrams, URLs, credentials.

## Phases
1. Infrastructure Foundation
2. Kubernetes Cluster Deployment
3. Container Registry Setup
4. CI Pipelines
5. GitOps & ArgoCD
6. Monitoring Stack
7. Application Deployment
