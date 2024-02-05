resource "azurerm_network_security_group" "az_nsg" {
  name                = "az-jazz-nsg"
  location            = "East US"
  resource_group_name = "rg-emat-app-dev"

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
