resource "azurerm_storage_account" "az_storage_account" {
  name                     = "rgazteparazrldematd8ee7"
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
  # kind                = "FunctionApp"
  sku_name            = "Y1"
}

resource "azurerm_storage_container" "az_storage_container" {
  name                  = "az-emat-back-storage-container"
  storage_account_name  = azurerm_storage_account.az_storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "function_blob" {
  name                   = var.az_blob_storage_be
  storage_account_name   = azurerm_storage_account.az_storage_account.name
  storage_container_name = azurerm_storage_container.az_storage_container.name
  type                   = "Block"

  source = "${abspath(path.module)}/az-emat-back/az-emat-back.zip"
}

resource "azurerm_application_insights" "az_app_insights" {
  name                = "az-emat-appinsights"
  location            = var.m_location
  resource_group_name = var.rg_name
  application_type    = "web"
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
    WEBSITE_RUN_FROM_PACKAGE          = 1
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.az_app_insights.instrumentation_key
  }

  site_config {
    # linux_fx_version = "python|3.11"
    always_on        = true
    application_stack {
      python_version = "3.11"
    }
    cors {
      allowed_origins     = ["https://portal.azure.com"]
      support_credentials = true
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
  file {
    name    = "function_app.py"
    content = file("${path.module}/az-emat-back/function_app.py")
  }
   config_json = jsonencode({
    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "methods" = [
          "get",
          "post",
        ]
        "name" = "req"
        "type" = "httpTrigger"
        "route"     = "MyHttpTrigger"
      },
      {
        "direction" = "out"
        "name"      = "$return"
        "type"      = "http"
      },
    ]
  })
  # config_json = jsonencode({
  #   "bindings" = [
  #     {
  #       "authLevel" = "function",
  #       "direction" = "in",
  #       "name"      = "req",
  #       "type"      = "httpTrigger",
  #       "methods"   = ["GET", "POST"],
  #       "route"     = "MyHttpTrigger",
  #     },
  #     {
  #       "direction" = "out",
  #       "name"      = "$return",
  #       "type"      = "http",
  #     },
  #   ],
  # })
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
