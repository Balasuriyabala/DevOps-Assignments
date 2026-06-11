resource "azurerm_virtual_network" "demo-vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name 
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.demo-vnet.name
  address_prefixes     = [each.value]

  depends_on = [azurerm_virtual_network.demo-vnet]
}

# Route Tables
resource "azurerm_route_table" "public_rt" {
  name                = "public-rt"
  location            = var.location
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_virtual_network.demo-vnet]
  route {
    name                   = "public-rt"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "public_rt_assoc" {
   for_each = {
    for k, v in azurerm_subnet.subnet :
    k => v if strcontains(k, "public")
  }
  subnet_id      = each.value.id
  route_table_id = azurerm_route_table.public_rt.id
}

# private route table
resource "azurerm_route_table" "private_rt" {
  name                = "private-rt"
  location            = var.location
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_virtual_network.demo-vnet]
  route {
    name                   = "private-rt"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "11.0.1.10"
  }
}

resource "azurerm_subnet_route_table_association" "pvt_rt_assc" {
  for_each = {
    for k, v in azurerm_subnet.subnet :
    k => v if strcontains(k, "private")
  }
  subnet_id      = each.value.id
  route_table_id = azurerm_route_table.private_rt.id

  depends_on = [azurerm_route_table.private_rt] 
}

resource "azurerm_public_ip" "pub_ip" {
  name                = "pub-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic_pub" {
  name                = "nic-pub"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet["public-subnet-1a"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pub_ip.id
  }
}
