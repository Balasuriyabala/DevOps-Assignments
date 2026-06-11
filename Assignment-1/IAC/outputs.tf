output "resource_group_name" {
  value = azurerm_resource_group.demo-storage
}

output "azurerm_virtual_network" {
  description = "Name of the Virtual Network"
  value       = module.vnet.vnet_name
}
