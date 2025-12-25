# modules/compute/main.tf
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.resource_group_name}-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "${var.resource_group_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    id = var.enable_custom_image ? var.custom_image_id : null
    publisher = var.enable_custom_image ? null : var.image_publisher
    offer     = var.enable_custom_image ? null : var.image_offer
    sku       = var.enable_custom_image ? null : var.image_sku
    version   = var.enable_custom_image ? null : var.image_version
  }

  os_profile {
    computer_name  = "${var.resource_group_name}-vm"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = var.tags
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.resource_group_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.resource_group_name}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}
