resource "azurerm_network_security_group" "az_nsg" {
  name                = "nsg-az-emat-app"
  location            = var.m_location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_virtual_network" "az_vnet" {
  name                = "vnet-az-emat"
  location            = var.m_location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "vnet-az-emat-subnet-1"
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.az_nsg.id
  }

  subnet {
    name           = "vnet-az-emat-subnet-2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.az_nsg.id
  }

  tags = {
    environment = "Dev"
  }
}
