
# modules/monitoring/main.tf
resource "azurerm_monitor_log_analytics_workspace" "log" {
  name                = var.log_analytics_workspace
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_monitor_dashboard" "dashboard" {
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
        },
        "1": {
          "position": {
            "x": 6,
            "y": 0,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "resourceTypeMode",
                "value": "microsoft.compute/virtualmachines"
              },
              {
                "name": "ComponentId",
                "value": {
                  "Name": "/subscriptions/{subscriptionId}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Compute/virtualMachines/{vmName}",
                  "SubscriptionId": "{subscriptionId}",
                  "ResourceGroup": "${var.resource_group_name}"
                }
              }
            ],
            "type": "Extension/Microsoft_Azure_Monitoring/PartType/MetricsChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "/subscriptions/{subscriptionId}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Compute/virtualMachines/{vmName}"
                        },
                        "name": "Percentage CPU",
                        "aggregationType": 4,
                        "namespace": "Microsoft.Compute/virtualMachines",
                        "metricVisualization": {
                          "displayName": "Percentage CPU",
                          "resourceDisplayName": "VM CPU Usage"
                        }
                      }
                    ],
                    "title": "CPU Usage",
                    "titleKind": 2,
                    "visualization": {
                      "chartType": 2,
                      "legend": {
                        "isVisible": true,
                        "position": 2
                      },
                      "axis": {
                        "x": {
                          "isVisible": true,
                          "axisType": 2
                        },
                        "y": {
                          "isVisible": true,
                          "axisType": 1
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  },
  "metadata": {
    "model": {
      "timeRange": {
        "value": {
          "relative": {
            "duration": 24,
            "timeUnit": 1
          }
        },
        "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
      },
      "filterLocale": {
        "value": "en-us"
      },
      "filters": {
        "value": {
          "MsPortalFx_TimeRange": {
            "model": {
              "format": "utc",
              "granularity": "auto",
              "relative": "24h"
            },
            "displayCache": {
              "name": "UTC Time",
              "value": "Past 24 hours"
            },
            "filteredPartIds": [
              "StartboardPart-UnboundPart-ae44c9b5-90e7-4a7b-8b8a-123456789012"
            ]
          }
        }
      }
    }
  }
}
DASHBOARD
}

resource "azurerm_virtual_machine_extension" "azure_monitor_agent" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = var.vm_id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "workspaceId": "${azurerm_monitor_log_analytics_workspace.log.workspace_id}"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${azurerm_monitor_log_analytics_workspace.log.primary_shared_key}"
    }
PROTECTED_SETTINGS

  tags = var.tags
}