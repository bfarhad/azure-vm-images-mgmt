# modules/image-builder/main.tf

resource "azurerm_shared_image_gallery" "gallery" {
  name                = var.gallery_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
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

resource "azurerm_shared_image_version" "version" {
  name                = "1.0.0"
  gallery_name        = azurerm_shared_image_gallery.gallery.name
  image_name          = azurerm_shared_image.image.name
  resource_group_name = var.resource_group_name
  location            = var.location

  target_region {
    name                   = var.location
    regional_replica_count = 1
  }

  # Note: For actual image building, use managed_image_id from a captured VM
  # This is a placeholder for versioning structure
  managed_image_id = null  # Replace with actual managed image ID

  tags = var.tags
}
