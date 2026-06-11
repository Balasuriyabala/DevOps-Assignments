output "linux_vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "linux_vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "linux_vm_public_ip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}
