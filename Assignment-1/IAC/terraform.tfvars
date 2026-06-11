subscription_id     = "1"
resource_group_name = "test-rg"
vnet_name           = "testvnet"
address_space       = ["11.0.0.0/16"]
location            = "South India"
subnets = {
  "public-subnet-1a"  = "11.0.1.0/24"
  "private-subnet-1b" = "11.0.2.0/24"
  "public-subnet-2a"  = "11.0.3.0/24"
  "private-subnet-2b" = "11.0.4.0/24"
}
nsg_name          = "test-nsg"
vm_name           = "testvm"
vm_size           = "Standard_B1s"
admin_username    = "azureuser"
ssh_public_key_path = "C:\\Users\\DELL\\.ssh\\azure_vm_key.pub"
