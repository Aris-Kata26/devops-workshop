#!/bin/bash
# Manual test - run these commands in k8s-master console

echo "Run these on k8s-master console to verify SSH:"
echo ""
echo "1. Check SSH is listening:"
echo "   sudo ss -tlnp | grep :22"
echo ""
echo "2. Check firewall:"
echo "   sudo ufw status"
echo ""
echo "3. Try SSH from Proxmox:"
echo "   # On Proxmox host, run:"
echo "   ssh -v ubuntu@10.0.96.10"
echo ""
echo "4. If password is asked, you can also copy SSH key:"
echo "   # From k8s-master:"
echo "   echo 'YOUR_SSH_PUBLIC_KEY' >> ~/.ssh/authorized_keys"
