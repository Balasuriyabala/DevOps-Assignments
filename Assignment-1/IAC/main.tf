resource "azurerm_resource_group" "demo-storage" {
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  subnets             = var.subnets
  vnet_name           = var.vnet_name
}

module "nsg" {
  source              = "./modules/nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  nsg_name            = var.nsg_name
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  nic_id              = module.vnet.nic_id
}
resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = module.vnet.nic_id   
  network_security_group_id = module.nsg.nsg_id    
}

