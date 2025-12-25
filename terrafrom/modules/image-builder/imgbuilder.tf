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

resource "azurerm_image_template" "template" {
  name                = "${var.build_image_name}-template"
  resource_group_name = var.resource_group_name
  location            = var.location

  source {
    platform_image {
      publisher = var.base_image_publisher
      offer     = var.base_image_offer
      sku       = var.base_image_sku
      version   = "latest"
    }
  }

  customize {
    inline_script {
      inline = [var.build_script]
    }
  }

  distribute {
    shared_image {
      gallery_name   = azurerm_shared_image_gallery.gallery.name
      image_version  = "1.0.0"
      resource_group = var.resource_group_name
      image_name     = azurerm_shared_image.image.name
      replication_regions = [var.location]
    }
  }

  tags = var.tags
}