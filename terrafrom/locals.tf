locals {
  resource_group_name     = "${var.environment}-${var.project_name}-rg"
  vnet_name               = "${var.environment}-${var.project_name}-vnet"
  keyvault_name           = "${var.environment}-${var.project_name}-kv"
  log_analytics_workspace = "${var.environment}-${var.project_name}-law"
  gallery_name            = "${var.resource_group_name}-gallery"
}