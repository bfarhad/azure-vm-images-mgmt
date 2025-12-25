resource "azurerm_automation_account" "automation" {
  name                = var.automation_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Basic"
  tags                = var.tags
}

resource "azurerm_automation_runbook" "runbook" {
  name                    = "ImageCustomizationRunbook"
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.automation.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "Runbook for image customization tasks"
  runbook_type            = "PowerShell"

  content = <<-EOT
    # Sample PowerShell runbook
    Write-Output "Hello from Azure Automation Runbook"
  EOT

  tags = var.tags
}