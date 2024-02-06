resource "azurerm_storage_account" "az_storage_account" {
  name                     = "azematbackstorageacc"
  location                 = var.m_location
  resource_group_name      = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "az_app_svc_plan" {
  name                = "az-emat-back-svc-plan"
  location            = var.m_location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_storage_container" "az_storage_container" {
  name                  = "az-emat-back-storage-container"
  storage_account_name  = azurerm_storage_account.az_storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "function_blob" {
  name                   = "az-emat-back-blob-storage"
  storage_account_name   = azurerm_storage_account.az_storage_account.name
  storage_container_name = azurerm_storage_container.az_storage_container.name
  type                   = "Block"

  source = "${abspath(path.module)}/az-emat-back/az-emat-back.zip"
  # source = data.archive_file.function_zip.output_path
}

resource "azurerm_linux_function_app" "az_demo_app" {
  name                       = "az-function-emat-back"
  location                   = var.m_location
  resource_group_name        = var.rg_name
  service_plan_id            = azurerm_service_plan.az_app_svc_plan.id
  storage_account_name       = azurerm_storage_account.az_storage_account.name
  storage_account_access_key = azurerm_storage_account.az_storage_account.primary_access_key
  https_only                 = true

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "python"
  }

  site_config {
    # linux_fx_version = "python|3.11"
    application_stack {
      python_version = "3.11"
    }
  }

  lifecycle {
    ignore_changes = [
      app_settings,
    ]
  }

  depends_on = [azurerm_storage_blob.function_blob]
}

resource "azurerm_function_app_function" "az_demo_app" {
  name            = "az-function-emat-back"
  function_app_id = azurerm_linux_function_app.az_demo_app.id
  language        = "Python"
  test_data = jsonencode({
    "name" = "Azure"
  })
  config_json = jsonencode({
    "bindings" = [
      {
        "authLevel" = "function",
        "direction" = "in",
        "name"      = "req",
        "type"      = "httpTrigger",
        "methods"   = ["GET", "POST"],
        "route"     = "MyHttpTrigger",
      },
      {
        "direction" = "out",
        "name"      = "$return",
        "type"      = "http",
      },
    ],
  })
}


data "archive_file" "function_zip" {
  type        = "zip"
  output_path = "${abspath(path.module)}/az-emat-back/az-emat-back.zip"

  source {
    content  = file("${path.module}/az-emat-back/function_app.py")
    filename = "function_app.py"
  }

  source {
    content  = file("${path.module}/az-emat-back/requirements.txt")
    filename = "requirements.txt"
  }
}
