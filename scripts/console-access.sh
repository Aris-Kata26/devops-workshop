#!/bin/bash
# Script to access VMs via serial console and check/fix networking

PROXMOX_HOST="10.0.10.71"

echo "Checking k8s-master (VM 102) via serial console..."
echo ""
echo "Commands to run in console:"
echo "1. Login with: ubuntu / test..123"
echo "2. Check IP: ip a"
echo "3. Check cloud-init: sudo cloud-init status"
echo "4. Check SSH: sudo systemctl status ssh"
echo ""
echo "Connecting to serial console..."
echo "Press Ctrl+O to exit the console"
echo ""

ssh root@${PROXMOX_HOST} "qm terminal 102"
