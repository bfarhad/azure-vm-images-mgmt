variable "automation_account_name" {
  type = string
  description = "Name of the Azure Automation account"
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