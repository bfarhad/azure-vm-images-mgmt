variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "build_image_name" {
  type        = string
  description = "The name of the custom image to build"
}

variable "base_image_publisher" {
  type        = string
  description = "The publisher of the base image"
}

variable "base_image_offer" {
  type        = string
  description = "The offer of the base image"
}

variable "base_image_sku" {
  type        = string
  description = "The SKU of the base image"
}

variable "build_script" {
  type        = string
  description = "The inline script to run during image build"
}

variable "managed_image_id" {
  type        = string
  default     = null
  description = "ID of managed image to use for creating gallery image version"
}


variable "gallery_name" {
  type        = string
  description = "The name of the shared image gallery"
}

variable "source_vm_id" {
  type        = string
  default     = null
  description = "The ID of the source VM to create the managed image from"
}