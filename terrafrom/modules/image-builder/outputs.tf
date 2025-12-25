output "gallery_id" {
  value = azurerm_shared_image_gallery.gallery.id
}

output "gallery_name" {
  value = azurerm_shared_image_gallery.gallery.name
}

output "image_id" {
  value = azurerm_shared_image.image.id
}

output "image_name" {
  value = azurerm_shared_image.image.name
}

output "template_id" {
  value = azurerm_image_template.template.id
}

output "template_name" {
  value = azurerm_image_template.template.name
}