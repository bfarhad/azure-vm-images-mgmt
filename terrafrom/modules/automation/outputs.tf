output "automation_account_id" {
  value = azurerm_automation_account.automation.id
}

output "automation_account_name" {
  value = azurerm_automation_account.automation.name
}

output "runbook_name" {
  value = azurerm_automation_runbook.runbook.name
}