variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}


variable "subnet_id" {
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

variable "image_publisher" {
  type = string
}

variable "image_offer" {
  type = string
}

variable "image_sku" {
  type = string
}

variable "image_version" {
  type = string
}

variable "enable_custom_image" {
  type = bool
  default = false
}

variable "custom_image_id" {
  type = string
  default = null
}

variable "key_vault_id" {
  type = string
}

variable "os_type" {
  type = string
  default = "linux"
  validation {
    condition = contains(["linux", "windows"], var.os_type)
    error_message = "os_type must be either 'linux' or 'windows'."
  }
}