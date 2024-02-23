resource "azurerm_postgresql_server" "example" {
  name                = "postgresql-emat-dev"
  location            = var.m_location
  resource_group_name = var.m_rg_name

  administrator_login          = "psqladmin"
  administrator_login_password = "admin123"

  sku_name   = "GP_Gen5_4"
  version    = "11"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}