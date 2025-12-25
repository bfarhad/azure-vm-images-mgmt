# providers.tf
terraform {
  backend "azurerm" {
    resource_group_name  = "global-management-RG"
    storage_account_name = var.storage_account_name
    container_name       = "terraformstate"
    key                  = "azvmimages/terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

provider "random" {}
