# Subscription ID:
variable "subscription_id" {
  description = "Subscription ID"
  type        = string
}

# Resource Group Name:
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

# Location:
variable "location" {
  description = "The Azure Region where resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "address prefixes for subnets"
  type        = map(string)
}

variable "nsg_name" {
  description = "Name of the NSG"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key for the virtual machine"
  type        = string
}
