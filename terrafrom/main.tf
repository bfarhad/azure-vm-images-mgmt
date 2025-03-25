# providers.tf
provider "azurerm" {
  features {}
}

# main.tf (Root)
module "network" {
  source = "./modules/network"
}

module "compute" {
  source = "./modules/compute"
  network_id = module.network.vnet_id
}

module "security" {
  source = "./modules/security"
}

module "monitoring" {
  source = "./modules/monitoring"
}

# modules/network/main.tf
resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  location            = "East US"
  resource_group_name = "my-rg"
  address_space       = ["10.0.0.0/16"]
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

# modules/compute/main.tf
resource "azurerm_virtual_machine" "vm" {
  name                  = "my-vm"
  location              = "East US"
  resource_group_name   = "my-rg"
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_DS1_v2"
}

resource "azurerm_network_interface" "nic" {
  name                = "my-nic"
  location            = "East US"
  resource_group_name = "my-rg"
}

# modules/security/main.tf
resource "azurerm_network_security_group" "nsg" {
  name                = "my-nsg"
  location            = "East US"
  resource_group_name = "my-rg"
}

# modules/monitoring/main.tf
resource "azurerm_monitor_log_analytics_workspace" "log" {
  name                = "my-log-analytics"
  location            = "East US"
  resource_group_name = "my-rg"
}
