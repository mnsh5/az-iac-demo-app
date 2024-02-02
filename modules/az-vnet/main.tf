resource "azurerm_virtual_network" "az_vnet" {
  name                = "az-jazz-vnet"
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name
  address_space       = ["10.0.0.0/24"]

  subnet {
    name           = "az-jazz-subnet-1"
    address_prefix = "10.0.1.0/25"
    security_group = azurerm_network_security_group.az_nsg.id
  }

  subnet {
    name           = "az-jazz-subnet-2"
    address_prefix = "10.0.2.0/25"
    security_group = azurerm_network_security_group.az_nsg.id
  }

  tags = {
    environment = "Dev"
  }
}
