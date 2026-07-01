variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "project_name" {
  description = "Project name used in tags and resource names"
  type        = string
  default     = "terafarmtes"
}

variable "instance_type" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH to the VM"
  type        = string
  default     = "0.0.0.0/0"
}

variable "admin_username" {
  description = "Admin username for the Linux VM"
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "SSH public key for VM admin login"
  type        = string
}

variable "vm_name" {
  description = "Optional custom VM name override"
  type        = string
  default     = ""
}