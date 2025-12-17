output "vm_ids" {
  description = "Proxmox VM IDs"
  value       = proxmox_virtual_environment_vm.k8s_nodes[*].vm_id
}

output "vm_names" {
  description = "VM names"
  value       = proxmox_virtual_environment_vm.k8s_nodes[*].name
}

output "vm_ips" {
  description = "Assigned IP addresses"
  value       = var.vm_ips
}

output "master_node" {
  description = "Master node details"
  value = {
    name = proxmox_virtual_environment_vm.k8s_nodes[0].name
    id   = proxmox_virtual_environment_vm.k8s_nodes[0].vm_id
    ip   = var.vm_ips[0]
  }
}

output "worker_nodes" {
  description = "Worker node details"
  value = [
    for idx in range(1, length(var.vm_names)) : {
      name = proxmox_virtual_environment_vm.k8s_nodes[idx].name
      id   = proxmox_virtual_environment_vm.k8s_nodes[idx].vm_id
      ip   = var.vm_ips[idx]
    }
  ]
}
