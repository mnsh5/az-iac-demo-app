resource "azurerm_network_security_group" "nsg-pub" {
  name                = var.m_nsg_pub_name
  resource_group_name = var.rg_name
  location            = var.m_location

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "az_vnet" {
  name                = var.m_virtual_network_name 
  location            = var.m_location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "${var.m_subnet_name}-subnet-pub-1"
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.nsg-pub.id
  }

  subnet {
    name           = "${var.m_subnet_name}-subnet-pub-2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.nsg-pub.id
  }
}
