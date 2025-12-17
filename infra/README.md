# Terraform Infrastructure for Kubernetes Cluster

This Terraform configuration provisions 3 VMs on Proxmox for a Kubernetes cluster.

## Prerequisites

1. **Proxmox Setup:**
   - Template VM 200 (ubuntu-2404-template) must exist on node bcc07
   - Template must have cloud-init and qemu-guest-agent installed
   - API token created in Proxmox

2. **Local Setup:**
   - Terraform >= 1.0 installed
   - SSH key pair generated

## Configuration Files

- `providers.tf` - Terraform and provider configuration
- `variables.tf` - Variable definitions
- `main.tf` - VM resource definitions
- `outputs.tf` - Output values
- `terraform.tfvars` - Your actual configuration (git-ignored)

## Setup Instructions

### 1. Create API Token in Proxmox

```bash
# SSH to Proxmox host
pveum role add TerraformRole -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit"
pveum user token add root@pam terraform-token --privsep=0
```

### 2. Create terraform.tfvars

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your values:
- Add your Proxmox API token
- Update IP addresses if needed
- Add your SSH public key

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Plan Deployment

```bash
terraform plan
```

### 5. Deploy VMs

```bash
terraform apply
```

### 6. Access VMs

```bash
# SSH to master node
ssh ubuntu@10.0.96.10

# SSH to worker nodes
ssh ubuntu@10.0.96.11
ssh ubuntu@10.0.96.12
```

## VM Configuration

Each VM will be created with:
- **CPU:** 2 cores (host passthrough)
- **Memory:** 8192 MB (8GB)
- **Disk:** 15 GB (SSD, iothread, discard enabled)
- **Network:** virtio on vmbr0
- **BIOS:** OVMF (UEFI)
- **Machine:** q35
- **Storage:** local-lvm for disks, local for cloud-init

## Network Configuration

Default network settings (update in terraform.tfvars):
- Gateway: 10.0.96.1
- Master: 10.0.96.10/24
- Worker 1: 10.0.96.11/24
- Worker 2: 10.0.96.12/24

## Outputs

After successful deployment:
```bash
terraform output
```

Shows:
- VM IDs
- VM names
- IP addresses
- Master node details
- Worker node details

## Cleanup

To destroy all VMs:
```bash
terraform destroy
```

## Troubleshooting

### Cloud-init not completing
- Verify template has cloud-init installed
- Check VM console in Proxmox
- Verify network connectivity

### SSH connection fails
- Ensure SSH key is correct in terraform.tfvars
- Check VM has booted completely (wait 2-3 minutes)
- Verify IP addresses are correct and not in use

### API authentication errors
- Verify API token is correct
- Check token permissions in Proxmox
- Ensure endpoint URL is correct

## Next Steps

After VMs are provisioned:
1. Verify all VMs are accessible via SSH
2. Proceed to Kubespray installation in ../k8s/
3. Deploy Kubernetes cluster
