# Kubernetes Cluster Setup with Kubespray

This directory contains the configuration for deploying a Kubernetes cluster using Kubespray.

## Cluster Details

- **Master Node:** k8s-master (10.0.96.10)
- **Worker Nodes:** 
  - k8s-worker-1 (10.0.96.11)
  - k8s-worker-2 (10.0.96.12)

## Prerequisites

1. VMs provisioned via Terraform (completed ✅)
2. SSH access to all nodes
3. Ansible installed on local machine
4. Python3 and pip installed

## Setup Steps

### 1. Install Ansible and Dependencies

```bash
# Install Ansible
sudo apt update
sudo apt install -y python3-pip git

# Install required Python packages
pip3 install --upgrade pip
pip3 install ansible cryptography jinja2 netaddr pbr jmespath ruamel.yaml
```

### 2. Clone Kubespray

```bash
cd k8s
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
git checkout release-2.24  # Use stable release
```

### 3. Install Python Dependencies

```bash
pip3 install -r requirements.txt
```

### 4. Copy and Configure Inventory

```bash
cp -rfp inventory/sample inventory/mycluster
```

### 5. Update Inventory File

Edit `inventory/mycluster/inventory.ini`:

```ini
[all]
k8s-master ansible_host=10.0.96.10 ip=10.0.96.10
k8s-worker-1 ansible_host=10.0.96.11 ip=10.0.96.11
k8s-worker-2 ansible_host=10.0.96.12 ip=10.0.96.12

[kube_control_plane]
k8s-master

[etcd]
k8s-master

[kube_node]
k8s-worker-1
k8s-worker-2

[k8s_cluster:children]
kube_control_plane
kube_node
```

### 6. Configure Cluster Parameters

Edit `inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml`:

```yaml
kube_version: v1.28.6
kube_network_plugin: calico
cluster_name: devops-workshop
```

Edit `inventory/mycluster/group_vars/all/all.yml`:

```yaml
ansible_user: ubuntu
ansible_become: true
ansible_ssh_private_key_file: ~/.ssh/id_rsa
```

### 7. Test Connectivity

```bash
ansible -i inventory/mycluster/inventory.ini all -m ping
```

### 8. Deploy Kubernetes

```bash
ansible-playbook -i inventory/mycluster/inventory.ini cluster.yml -b -v
```

This will take 15-30 minutes depending on your network speed.

### 9. Configure kubectl Access

After deployment:

```bash
# SSH to master node
ssh ubuntu@10.0.96.10

# Copy kubeconfig
mkdir -p ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
sudo chown ubuntu:ubuntu ~/.kube/config

# Test cluster
kubectl get nodes
kubectl get pods -A
```

### 10. Copy kubeconfig to Local Machine

```bash
# On local machine
scp ubuntu@10.0.96.10:~/.kube/config ~/.kube/config-devops-workshop

# Set context
export KUBECONFIG=~/.kube/config-devops-workshop
kubectl get nodes
```

## Verification

```bash
# Check all nodes are Ready
kubectl get nodes

# Check all system pods are Running
kubectl get pods -A

# Check cluster info
kubectl cluster-info
```

## Troubleshooting

### SSH Connection Issues
- Verify VMs are running in Proxmox
- Check network connectivity: `ping 10.0.96.10`
- Verify SSH key: `ssh ubuntu@10.0.96.10`

### Ansible Fails
- Check Python version: `python3 --version`
- Reinstall dependencies: `pip3 install -r requirements.txt`
- Verify inventory file syntax

### Pods Not Starting
- Check node status: `kubectl get nodes`
- Check pod logs: `kubectl logs -n kube-system <pod-name>`
- Check kubelet: `sudo systemctl status kubelet`

## Next Steps

After successful deployment:
1. Install local-path provisioner (storage)
2. Deploy ArgoCD (GitOps)
3. Deploy kube-prometheus-stack (monitoring)
4. Deploy Mission Control application
