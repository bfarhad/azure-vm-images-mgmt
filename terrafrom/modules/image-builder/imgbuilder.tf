# modules/image-builder/main.tf

resource "azurerm_shared_image_gallery" "gallery" {
  name                = var.gallery_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_image" "managed" {
  count                     = var.source_vm_id != null ? 1 : 0
  name                      = "${var.build_image_name}-managed"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  source_virtual_machine_id = var.source_vm_id
  tags                      = var.tags
}

data "azurerm_image" "managed" {
  count               = var.source_vm_id != null ? 1 : 0
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

data "azurerm_shared_image" "existing" {
  name                = var.build_image_name
  gallery_name        = azurerm_shared_image_gallery.gallery.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_shared_image_version" "example" {
  count               = var.source_vm_id != null ? 1 : 0
  name                = "0.0.1"
  gallery_name        = data.azurerm_shared_image.existing.gallery_name
  image_name          = data.azurerm_shared_image.existing.name
  resource_group_name = data.azurerm_shared_image.existing.resource_group_name
  location            = data.azurerm_shared_image.existing.location
  managed_image_id    = data.azurerm_image.managed[0].id

  target_region {
    name                   = data.azurerm_shared_image.existing.location
    regional_replica_count = 2
    storage_account_type   = "Standard_LRS"
  }
}