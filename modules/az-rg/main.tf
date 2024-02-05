locals {
  rg_name = "rg-emat-app-dev"
}

resource "azurerm_resource_group" "az_rg" {
  name     = local.rg_name
  location = var.m_location
}
