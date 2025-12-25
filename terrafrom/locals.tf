locals {
  resource_group_name     = "${var.environment}-${var.project_name}-rg"
  vnet_name               = "${var.environment}-${var.project_name}-vnet"
  keyvault_name           = substr(replace("${var.environment}${var.project_name}kv", "-", ""), 0, 24)
  log_analytics_workspace = "${var.environment}-${var.project_name}-law"
  gallery_name            = substr(replace("${local.resource_group_name}gallery", "-", ""), 0, 24)
}