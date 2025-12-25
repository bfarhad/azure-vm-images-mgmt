#####
## Terraform modules management # main.tf (Root)
#####
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}
module "networking" {
  source              = "./modules/networking"
  vnet_name           = local.vnet_name
  vnet_cidr           = var.vnet_cidr
  subnet_cidr         = var.subnet_cidr
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
  depends_on          = [azurerm_resource_group.rg]
}

module "security" {
  source              = "./modules/security"
  keyvault_name       = local.keyvault_name
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
  admin_password      = null
  allowed_ip          = var.allowed_ip
  depends_on          = [azurerm_resource_group.rg]
}

module "compute" {
  source              = "./modules/compute"
  vm_size             = var.vm_size
  os_type             = var.os_type
  subnet_id           = module.networking.subnet_id
  location            = var.location
  resource_group_name = local.resource_group_name
  tags                = var.tags
  image_publisher     = var.image_publisher
  image_offer         = var.image_offer
  image_sku           = var.image_sku
  image_version       = var.image_version
  enable_custom_image = var.enable_image_builder
  custom_image_id     = null
  key_vault_id        = module.security.key_vault_id
  depends_on          = [azurerm_resource_group.rg, module.networking, module.security, module.image-builder]
}

module "monitoring" {
  source                  = "./modules/monitoring"
  log_analytics_workspace = local.log_analytics_workspace
  location                = var.location
  resource_group_name     = local.resource_group_name
  tags                    = var.tags
  vmss_id                 = module.compute.vmss_id
  dashboard_name          = "${local.resource_group_name}-dashboard"
  depends_on              = [azurerm_resource_group.rg]
}

module "automation" {
  source                  = "./modules/automation"
  automation_account_name = var.automation_account_name
  location                = var.location
  resource_group_name     = local.resource_group_name
  tags                    = var.tags
  depends_on              = [azurerm_resource_group.rg]
}

module "image-builder" {
  count                = var.enable_image_builder ? 1 : 0
  source               = "./modules/image-builder"
  location             = var.location
  resource_group_name  = local.resource_group_name
  tags                 = var.tags
  build_image_name     = var.build_image_name
  base_image_publisher = var.base_image_publisher
  base_image_offer     = var.base_image_offer
  base_image_sku       = var.base_image_sku
  build_script         = var.build_script
  gallery_name         = local.gallery_name

  depends_on = [azurerm_resource_group.rg]
}







