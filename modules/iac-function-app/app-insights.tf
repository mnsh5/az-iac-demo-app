resource "azurerm_application_insights" "main" {
  name                = "appinsights-demo-dev"
  location            = var.m_location
  resource_group_name = var.m_rg_name
  application_type    = var.m_appinsights_apptype
}
