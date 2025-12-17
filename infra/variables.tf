variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
  default     = "https://10.0.10.71:8006"
}

variable "proxmox_api_token" {
  description = "Proxmox API token (format: user@realm!tokenid=secret)"
  type        = string
  sensitive   = true
}

variable "node" {
  description = "Proxmox node name"
  type        = string
  default     = "bcc07"
}

variable "template_id" {
  description = "Template VM ID to clone from (201 has OpenSSH pre-installed)"
  type        = number
  default     = 201
}

variable "vm_names" {
  description = "Names for the Kubernetes VMs"
  type        = list(string)
  default     = ["k8s-master", "k8s-worker-1", "k8s-worker-2"]
}

variable "vm_ips" {
  description = "Static IP addresses for the VMs (CIDR notation)"
  type        = list(string)
  # Update these IPs to match your network
  default     = ["10.0.96.10/24", "10.0.96.11/24", "10.0.96.12/24"]
}

variable "gateway" {
  description = "Network gateway"
  type        = string
  default     = "10.0.96.1"
}

variable "ssh_key" {
  description = "SSH public key for VM access"
  type        = string
  sensitive   = true
}

variable "vm_password" {
  description = "Default password for ubuntu user"
  type        = string
  sensitive   = true
  default     = ""
}

variable "vm_cpu_cores" {
  description = "Number of CPU cores per VM"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Memory in MB per VM"
  type        = number
  default     = 8192
}

variable "vm_disk_size" {
  description = "Disk size in GB per VM"
  type        = number
  default     = 15
}

variable "disk_datastore" {
  description = "Datastore for VM disks"
  type        = string
  default     = "local-lvm"
}

variable "cloudinit_datastore" {
  description = "Datastore for CloudInit drive"
  type        = string
  default     = "local"
}

variable "network_bridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr0"
}
