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
  type = string
  description = "The name of the custom image to build"
}

variable "base_image_publisher" {
  type = string
  description = "The publisher of the base image"
}

variable "base_image_offer" {
  type = string
  description = "The offer of the base image"
}

variable "base_image_sku" {
  type = string
  description = "The SKU of the base image"
}

variable "build_script" {
  type = string
  description = "The inline script to run during image build"
}


variable "gallery_name" {
  type = string
  description = "The name of the shared image gallery"
}