
# modules/monitoring/main.tf
resource "azurerm_log_analytics_workspace" "log" {
  name                = var.log_analytics_workspace
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_portal_dashboard" "dashboard" {
  name                = var.dashboard_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  dashboard_properties = <<DASHBOARD
{
  "lenses": {
    "0": {
      "order": 0,
      "parts": {
        "0": {
          "position": {
            "x": 0,
            "y": 0,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [],
            "type": "Extension/HubsExtension/PartType/MarkdownPart",
            "settings": {
              "content": {
                "settings": {
                  "content": "## VM Monitoring Dashboard\n\nThis dashboard shows key metrics for the virtual machine.",
                  "title": "",
                  "subtitle": ""
                }
              }
            }
          }
        }
      }
    }
  }
}
DASHBOARD
}


resource "azurerm_virtual_machine_scale_set_extension" "azure_monitor_agent" {
  name                         = "AzureMonitorLinuxAgent"
  virtual_machine_scale_set_id = var.vmss_id
  publisher                    = "Microsoft.Azure.Monitor"
  type                         = "AzureMonitorLinuxAgent"
  type_handler_version         = "1.0"
  auto_upgrade_minor_version   = true

  settings = <<SETTINGS
    {
      "workspaceId": "${azurerm_log_analytics_workspace.log.workspace_id}"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${azurerm_log_analytics_workspace.log.primary_shared_key}"
    }
PROTECTED_SETTINGS
}