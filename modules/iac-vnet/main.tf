resource "azurerm_virtual_network" "az_vnet" {
  name                = "vnet-iasp-eus-lz-network"
  location            = var.m_location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]
}

# data "azurerm_route_table" "udr" {
#   name                = var.m_route_table_name
#   resource_group_name = data.azurerm_resource_group.spoke.name
# }

resource "azurerm_network_security_group" "nsg-pub" {
  name                = var.m_nsg_pub_name
  resource_group_name = data.azurerm_resource_group.spoke.name
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

resource "azapi_resource" "subnet-pub-1" {
  type      = "Microsoft.Network/virtualNetworks/subnets@2022-07-01"
  name      = "${var.m_subnet_name}-subnet-pub-1"
  parent_id = data.azurerm_virtual_network.spoke.id
  body = jsonencode({
    properties = {
      addressPrefix = "10.236.2.192/27"
      networkSecurityGroup = {
        id = azurerm_network_security_group.nsg-pub.id
      }
      # routeTable = {
      #   id = data.azurerm_route_table.udr.id
      # }
    }
  })
}

resource "azurerm_network_security_group" "nsg-priv" {
  name                = var.m_nsg_priv_name
  resource_group_name = data.azurerm_resource_group.spoke.name
  location            = var.m_location

  security_rule {
    name                       = "AllowVnetInbound"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowVnetOutbound"
    priority                   = 1002
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "DenyInternetOutbound"
    priority                   = 1003
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }
}

resource "azapi_resource" "subnet-priv-1" {
  type      = "Microsoft.Network/virtualNetworks/subnets@2022-07-01"
  name      = "${var.m_subnet_name}-subnet-priv-1"
  parent_id = data.azurerm_virtual_network.spoke.id
  body = jsonencode({
    properties = {
      addressPrefix = "10.236.2.224/28"
      networkSecurityGroup = {
        id = azurerm_network_security_group.nsg-priv.id
      }
      # routeTable = {
      #   id = data.azurerm_route_table.udr.id
      # }
    }
  })
}
