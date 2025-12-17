#!/bin/bash
# Quick SSH test to all Kubernetes nodes

echo "Testing SSH connectivity to all nodes..."
echo ""

echo "==> Testing k8s-master (10.0.96.10):"
timeout 10 ssh -o ProxyJump=root@10.0.10.71 \
    -o StrictHostKeyChecking=no \
    -o KexAlgorithms=+diffie-hellman-group14-sha1 \
    -o HostKeyAlgorithms=+ssh-rsa \
    -o PubkeyAcceptedKeyTypes=+ssh-rsa \
    -o ConnectTimeout=5 \
    ubuntu@10.0.96.10 'hostname && echo "Status: OK"' 2>&1 || echo "FAILED"

echo ""
echo "==> Testing k8s-worker-1 (10.0.96.11):"
timeout 10 ssh -o ProxyJump=root@10.0.10.71 \
    -o StrictHostKeyChecking=no \
    -o KexAlgorithms=+diffie-hellman-group14-sha1 \
    -o HostKeyAlgorithms=+ssh-rsa \
    -o PubkeyAcceptedKeyTypes=+ssh-rsa \
    -o ConnectTimeout=5 \
    ubuntu@10.0.96.11 'hostname && echo "Status: OK"' 2>&1 || echo "FAILED"

echo ""
echo "==> Testing k8s-worker-2 (10.0.96.12):"
timeout 10 ssh -o ProxyJump=root@10.0.10.71 \
    -o StrictHostKeyChecking=no \
    -o KexAlgorithms=+diffie-hellman-group14-sha1 \
    -o HostKeyAlgorithms=+ssh-rsa \
    -o PubkeyAcceptedKeyTypes=+ssh-rsa \
    -o ConnectTimeout=5 \
    ubuntu@10.0.96.12 'hostname && echo "Status: OK"' 2>&1 || echo "FAILED"

echo ""
echo "Test complete!"
