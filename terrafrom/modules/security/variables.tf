variable "keyvault_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "allowed_ip" {
  type        = string
  description = "The public IP address allowed to access the VM via SSH and RDP"
}