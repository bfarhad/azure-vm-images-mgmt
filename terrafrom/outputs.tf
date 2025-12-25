# Networking outputs
output "vnet_id" {
  value = module.networking.vnet_id
}

output "vnet_name" {
  value = module.networking.vnet_name
}

output "subnet_id" {
  value = module.networking.subnet_id
}

output "subnet_name" {
  value = module.networking.subnet_name
}

# Security outputs
output "key_vault_id" {
  value = module.security.key_vault_id
}

output "key_vault_name" {
  value = module.security.key_vault_name
}

output "nsg_id" {
  value = module.security.nsg_id
}

output "nsg_name" {
  value = module.security.nsg_name
}

# Image Builder outputs (conditional)
output "gallery_id" {
  value = length(module.image-builder) > 0 ? module.image-builder[0].gallery_id : null
}

output "gallery_name" {
  value = length(module.image-builder) > 0 ? module.image-builder[0].gallery_name : null
}


output "built_image_name" {
  value = length(module.image-builder) > 0 ? module.image-builder[0].image_name : null
}

# Automation outputs
output "automation_account_id" {
  value = module.automation.automation_account_id
}

output "automation_account_name" {
  value = module.automation.automation_account_name
}

output "runbook_name" {
  value = module.automation.runbook_name
}


output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}