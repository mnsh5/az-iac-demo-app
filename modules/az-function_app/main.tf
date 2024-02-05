resource "azurerm_storage_account" "example" {
  name                     = "functionsappexamlpesa"
  location            = "East US"
  resource_group_name = "rg-emat-app-dev"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "example" {
  name                = "azure-functions-example-sp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  lifecycle {
    ignore_changes = [
      kind
    ]
  }
}

resource "azurerm_function_app" "example" {
  name                       = "example-azure-function"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  os_type                    = "linux"
  version                    = "~4"

  app_settings {
    FUNCTIONS_WORKER_RUNTIME = "python"
    "AzureWebJobsStorage"      = azurerm_storage_account.example.primary_connection_string
  }

  site_config {
    cors {
      allowed_origins = ["*"]
    }
    linux_fx_version = "python|3.11"
  }

  depends_on = [azurerm_storage_blob.example]
}

resource "azurerm_storage_blob" "example" {
  name                   = "example-zip"
  storage_account_name  = azurerm_storage_account.example.name
  storage_container_name = "zip-container"
  type                   = "Block"

  source {
    content = file("path/to/your/function_app_code.zip") # file("${abspath(path.module)}/back/function_app.zip")
  }
}
