#!/bin/bash
# Quick access script for Kubernetes VMs via Proxmox jump host

PROXMOX_HOST="10.0.10.71"
PROXMOX_USER="root"

echo "Testing connectivity to Kubernetes nodes..."
echo ""

echo "==> Master Node (10.0.96.10):"
ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -J ${PROXMOX_USER}@${PROXMOX_HOST} ubuntu@10.0.96.10 'hostname && echo "IP: $(hostname -I)" && echo "Status: OK"' || echo "FAILED"

echo ""
echo "==> Worker Node 1 (10.0.96.11):"
ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -J ${PROXMOX_USER}@${PROXMOX_HOST} ubuntu@10.0.96.11 'hostname && echo "IP: $(hostname -I)" && echo "Status: OK"' || echo "FAILED"

echo ""
echo "==> Worker Node 2 (10.0.96.12):"
ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -J ${PROXMOX_USER}@${PROXMOX_HOST} ubuntu@10.0.96.12 'hostname && echo "IP: $(hostname -I)" && echo "Status: OK"' || echo "FAILED"

echo ""
echo "Done! If all nodes show 'Status: OK', you can proceed with Kubespray."
