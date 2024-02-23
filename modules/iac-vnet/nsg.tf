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
