variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string 
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string  
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
}

variable "ssh_public_key_path" {
  description = "The path to the public SSH key."
  type        = string
}

variable "nic_id" {
  description = "The ID of the network interface to attach to the VM."
  type        = string
  
}
