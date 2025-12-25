# modules/compute/main.tf
resource "tls_private_key" "ssh" {
  count     = var.os_type == "linux" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_password" "admin_password" {
  count   = var.os_type == "windows" ? 1 : 0
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

resource "azurerm_key_vault_secret" "ssh_private_key" {
  count        = var.os_type == "linux" ? 1 : 0
  name         = "ssh-private-key"
  value        = tls_private_key.ssh[0].private_key_pem
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "admin_password" {
  count        = var.os_type == "windows" ? 1 : 0
  name         = "admin-password"
  value        = random_password.admin_password[0].result
  key_vault_id = var.key_vault_id
}

resource "azurerm_linux_virtual_machine_scale_set" "linux_vmss" {
  count               = var.os_type == "linux" ? 1 : 0
  name                = "${var.resource_group_name}-vmss"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vm_size
  instances           = 0  # Empty, ready for use
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh[0].public_key_openssh
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${var.resource_group_name}-nic"
    primary = true

    ip_configuration {
      name      = "${var.resource_group_name}-ipconfig"
      primary   = true
      subnet_id = var.subnet_id
    }
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine_scale_set" "windows_vmss" {
  count               = var.os_type == "windows" ? 1 : 0
  name                = "${var.resource_group_name}-vmss"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vm_size
  instances           = 0  # Empty, ready for use
  admin_username      = var.admin_username
  admin_password      = random_password.admin_password[0].result

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${var.resource_group_name}-nic"
    primary = true

    ip_configuration {
      name      = "${var.resource_group_name}-ipconfig"
      primary   = true
      subnet_id = var.subnet_id
    }
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
