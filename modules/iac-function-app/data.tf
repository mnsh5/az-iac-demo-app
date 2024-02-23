data "azurerm_storage_account" "az_storage_account_back" {
  name                     = "teparazrldematbackdev"
  resource_group_name      = var.m_rg_name
}