resource "proxmox_virtual_environment_vm" "k8s_nodes" {
  count       = length(var.vm_names)
  name        = var.vm_names[count.index]
  node_name   = var.node
  description = "Kubernetes ${count.index == 0 ? "Master" : "Worker"} Node - Managed by Terraform"
  
  tags        = ["kubernetes", "terraform", count.index == 0 ? "master" : "worker"]

  # Full clone from template
  clone {
    vm_id = var.template_id
    full  = true
  }

  # CPU configuration
  cpu {
    cores = var.vm_cpu_cores
    type  = "host"
  }

  # Memory configuration
  memory {
    dedicated = var.vm_memory
  }

  # QEMU Guest Agent
  agent {
    enabled = true
    timeout = "15m"
  }

  # Cloud-Init configuration
  initialization {
    datastore_id = var.cloudinit_datastore
    
    ip_config {
      ipv4 {
        address = var.vm_ips[count.index]
        gateway = var.gateway
      }
    }

    user_account {
      username = "ubuntu"
      password = var.vm_password
      keys     = [trimspace(var.ssh_key)]
    }
  }

  # Network configuration
  network_device {
    bridge   = var.network_bridge
    model    = "virtio"
    firewall = true
  }

  # Prevent accidental deletion
  lifecycle {
    prevent_destroy = false
  }
}
