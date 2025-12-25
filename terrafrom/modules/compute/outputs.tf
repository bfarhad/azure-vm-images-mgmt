output "vmss_id" {
  value = lower(var.os_type) == "linux" ? azurerm_linux_virtual_machine_scale_set.linux_vmss[0].id : azurerm_windows_virtual_machine_scale_set.windows_vmss[0].id
}

output "vmss_name" {
  value = lower(var.os_type) == "linux" ? azurerm_linux_virtual_machine_scale_set.linux_vmss[0].name : azurerm_windows_virtual_machine_scale_set.windows_vmss[0].name
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}

output "nic_name" {
  value = azurerm_network_interface.nic.name
}