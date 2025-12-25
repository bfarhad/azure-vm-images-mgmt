output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.log.id
}

output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.log.name
}


output "vm_extension_id" {
  value = azurerm_virtual_machine_extension.azure_monitor_agent.id
}

output "vm_extension_name" {
  value = azurerm_virtual_machine_extension.azure_monitor_agent.name
}

output "dashboard_id" {
  value = azurerm_portal_dashboard.dashboard.id
}

output "dashboard_name" {
  value = azurerm_portal_dashboard.dashboard.name
}