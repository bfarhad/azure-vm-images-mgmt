output "vm_id" {
  value = var.os_type == "linux" ? azurerm_linux_virtual_machine.linux_vm[0].id : azurerm_windows_virtual_machine.windows_vm[0].id
}

output "vm_name" {
  value = var.os_type == "linux" ? azurerm_linux_virtual_machine.linux_vm[0].name : azurerm_windows_virtual_machine.windows_vm[0].name
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}

output "nic_name" {
  value = azurerm_network_interface.nic.name
}