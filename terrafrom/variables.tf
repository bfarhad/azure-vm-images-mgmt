# Variables
variable "environment" {
  type = string
  default = "dev"
}

variable "project_name" {
  type = string
  default = "azure-vm-images-mgmt"
}

variable "vnet_name" {
  type = string
}

variable "vnet_cidr" {
  type = string
  default = "192.168.1.0/24"
}

variable "subnet_cidr" {
  type = string
  default = "192.168.1.0/27"
}

variable "vm_size" {
  type = string
  default = "Standard_B1s"
  description = "The size of the virtual machine. Possible choices: Standard_B1s, Standard_B2s, Standard_B4ms, etc."
}

variable "os_type" {
  type = string
  default = "Linux"
  description = "The operating system type. Possible choices: Linux, Windows"
}

variable "image_publisher" {
  type = string
  default = "Canonical"
  description = "The publisher of the VM image. Possible choices: Canonical, MicrosoftWindowsServer, etc."
}

variable "image_offer" {
  type = string
  default = "UbuntuServer"
  description = "The offer of the VM image. Possible choices: UbuntuServer, WindowsServer, etc."
}

variable "image_sku" {
  type = string
  default = "22.04-LTS"
  description = "The SKU of the VM image. Possible choices: 22.04-LTS, 2019-Datacenter, etc."
}

variable "image_version" {
  type = string
  default = "latest"
  description = "The version of the VM image. Possible choices: latest, or specific version"
}

variable "enable_image_builder" {
  type = bool
  default = false
  description = "Whether to enable the image builder module"
}

variable "build_image_name" {
  type = string
  default = "custom-image"
  description = "The name of the custom image to build"
}

variable "base_image_publisher" {
  type = string
  default = "Canonical"
  description = "The publisher of the base image for image builder"
}

variable "base_image_offer" {
  type = string
  default = "UbuntuServer"
  description = "The offer of the base image for image builder"
}

variable "base_image_sku" {
  type = string
  default = "22.04-LTS"
  description = "The SKU of the base image for image builder"
}

variable "build_script" {
  type = string
  default = "echo 'Customizing image'"
  description = "The inline script to run during image build"
}

variable "automation_account_name" {
  type = string
  default = "automation-account"
  description = "Name of the Azure Automation account"
}

variable "admin_username" {
  type = string
  default = "adminuser"
}

variable "admin_password" {
  type = string
}

variable "keyvault_name" {
  type = string
}

variable "log_analytics_workspace" {
  type = string
}

variable "location" {
  type = string
  default = "West Europe"
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    "Project owner" = "bfarhad"
    "Project name" = "azure-vm-images-mgmt"
    "region" = "west europe"
    "cost" = "medium"
    "env" = "dev"
  }
}