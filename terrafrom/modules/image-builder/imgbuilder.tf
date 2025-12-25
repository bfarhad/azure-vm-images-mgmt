# modules/image-builder/main.tf

resource "azurerm_shared_image_gallery" "gallery" {
  name                = var.gallery_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_network_interface" "base_nic" {
  count               = var.create_base_vm ? 1 : 0
  name                = "${var.build_image_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "base_vm" {
  count                           = var.create_base_vm ? 1 : 0
  name                            = "${var.build_image_name}-vm"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = "P@ssw0rd123!"
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.base_nic[0].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.base_image_publisher
    offer     = var.base_image_offer
    sku       = var.base_image_sku
    version   = "latest"
  }

  tags = var.tags
}

resource "azurerm_image" "managed" {
  count                     = var.create_base_vm || var.source_vm_id != null ? 1 : 0
  name                      = "${var.build_image_name}-managed"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  source_virtual_machine_id = var.create_base_vm ? azurerm_linux_virtual_machine.base_vm[0].id : var.source_vm_id
  tags                      = var.tags
  depends_on                = [azurerm_linux_virtual_machine.base_vm]
}

data "azurerm_image" "managed" {
  count               = var.create_base_vm || var.source_vm_id != null ? 1 : 0
  name                = azurerm_image.managed[0].name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_image.managed]
}


resource "azurerm_shared_image" "image" {
  name                = var.build_image_name
  gallery_name        = azurerm_shared_image_gallery.gallery.name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"

  identifier {
    publisher = var.base_image_publisher
    offer     = var.base_image_offer
    sku       = var.base_image_sku
  }

  tags = var.tags
}

resource "azurerm_shared_image_version" "example" {
  count               = var.managed_image_id != null || var.source_vm_id != null ? 1 : 0
  name                = "0.0.1"
  gallery_name        = azurerm_shared_image.image.gallery_name
  image_name          = azurerm_shared_image.image.name
  resource_group_name = var.resource_group_name
  location            = var.location
  managed_image_id    = var.managed_image_id != null ? var.managed_image_id : data.azurerm_image.managed[0].id

  target_region {
    name                   = var.location
    regional_replica_count = 2
    storage_account_type   = "Standard_LRS"
  }
}