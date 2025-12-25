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
