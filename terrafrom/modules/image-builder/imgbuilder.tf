# modules/image-builder/main.tf

resource "azurerm_shared_image_gallery" "gallery" {
  name                = var.gallery_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags = var.tags
}

# Example of image versioning - set managed_image_id variable to enable
resource "azurerm_shared_image_version" "version" {
  count               = var.managed_image_id != null ? 1 : 0
  name                = "1.0.0"
  gallery_name        = azurerm_shared_image_gallery.gallery.name
  image_name          = azurerm_shared_image.image.name
  resource_group_name = var.resource_group_name
  location            = var.location

  target_region {
    name                   = var.location
    regional_replica_count = 1
  }

  managed_image_id = var.managed_image_id

  tags = var.tags
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

