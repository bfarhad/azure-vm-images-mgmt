variable "log_analytics_workspace" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vmss_id" {
  type        = string
  description = "The ID of the VMSS to monitor"
}

variable "dashboard_name" {
  type        = string
  description = "The name of the monitoring dashboard"
}
