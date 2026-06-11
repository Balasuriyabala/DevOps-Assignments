variable "nsg_name" {
    description = "Name of the NSG"
    type        = string
}

variable "location" {
    description = "Azure region for the NSG"
    type        = string
}

variable "resource_group_name" {
    description = "Name of the resource group where the NSG will be created"
    type        = string
}
