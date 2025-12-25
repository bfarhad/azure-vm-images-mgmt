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