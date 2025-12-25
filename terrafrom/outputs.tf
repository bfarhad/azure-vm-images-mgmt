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

# Compute outputs
output "vm_id" {
  value = module.compute.vm_id
}

output "vm_name" {
  value = module.compute.vm_name
}

output "nic_id" {
  value = module.compute.nic_id
}

output "nic_name" {
  value = module.compute.nic_name
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

# Monitoring outputs
output "log_analytics_workspace_id" {
  value = module.monitoring.log_analytics_workspace_id
}

output "log_analytics_workspace_name" {
  value = module.monitoring.log_analytics_workspace_name
}

output "dashboard_id" {
  value = module.monitoring.dashboard_id
}

output "dashboard_name" {
  value = module.monitoring.dashboard_name
}

output "vm_extension_id" {
  value = module.monitoring.vm_extension_id
}

output "vm_extension_name" {
  value = module.monitoring.vm_extension_name
}

# Image Builder outputs (conditional)
output "gallery_id" {
  value = var.enable_image_builder ? module.image-builder[0].gallery_id : null
}

output "gallery_name" {
  value = var.enable_image_builder ? module.image-builder[0].gallery_name : null
}

output "built_image_id" {
  value = var.enable_image_builder ? module.image-builder[0].image_id : null
}

output "built_image_name" {
  value = var.enable_image_builder ? module.image-builder[0].image_name : null
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

output "image_builder_template_name" {
  value = var.enable_image_builder ? module.image-builder[0].template_name : null
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}