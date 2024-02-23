resource "azurerm_storage_account" "example" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "development"
  }
}

resource "azurerm_storage_container" "az_storage_back" {
  name                  = "ematbackdev"
  storage_account_name  = data.azurerm_storage_account.az_storage_account_back.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "storage_blob_function" {
  name                   = "fncematbackdev"
  storage_account_name   = data.azurerm_storage_account.az_storage_account_back.name
  storage_container_name = azurerm_storage_container.az_storage_back.name
  content_md5            = data.archive_file.function_zip.output_md5
  type                   = "Block"

  source = "${abspath(path.module)}/HttpExample/HttpExample.zip"
}