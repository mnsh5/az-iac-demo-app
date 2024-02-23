resource "azurerm_user_assigned_identity" "functions" {
  name                = "assigned-identity-emat-back-dev"
  location            = var.m_location
  resource_group_name = var.rg_name
}

resource "azurerm_service_plan" "az_app_svc_plan" {
  name                = "app-svc-plan-emat-back-dev"
  location            = var.m_location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "emat_func_app" {
  name                       = "fnc-emat-back-dev"
  location                   = var.m_location
  resource_group_name        = var.rg_name
  service_plan_id            = azurerm_service_plan.az_app_svc_plan.id
  storage_account_name       = data.azurerm_storage_account.az_storage_account_back.name
  storage_account_access_key = data.azurerm_storage_account.az_storage_account_back.primary_access_key
  https_only                 = true

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE       = 1
    FUNCTIONS_WORKER_RUNTIME       = "python"
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.main.instrumentation_key
  }

  site_config {
    # application_insights_key               = azurerm_application_insights.main.instrumentation_key
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

  identity {
    type         = "SystemAssigned"
  }

  zip_deploy_file = "${abspath(path.module)}/HttpExample/HttpExample.zip"
  depends_on = [azurerm_storage_blob.storage_blob_function]
}

resource "azurerm_function_app_function" "emat_func_app" {
  name            = azurerm_linux_function_app.emat_func_app.name
  function_app_id = azurerm_linux_function_app.emat_func_app.id
  language        = "Python"
  test_data = jsonencode({
    "name" = "Azure"
  })
  file {
    name    = "function_app.py"
    content = file("${path.module}/HttpExample/function_app.py")
  }
  config_json = jsonencode({
    "scriptFile": "function_app.py",
    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "name" = "req"
        "type" = "httpTrigger",
        "methods": ["get", "post"]
        "route"     = "HttpExample",
      },
      {
        "direction" = "out"
        "name"      = "$return"
        "type"      = "http"
      },
    ]
  })
}

data "archive_file" "function_zip" {
  type        = "zip"
  output_path = "${abspath(path.module)}/HttpExample/HttpExample.zip"
  source {
    content  = file("${path.module}/HttpExample/function_app.py")
    filename = "function_app.py"
  }

  source {
    content  = file("${path.module}/HttpExample/requirements.txt")
    filename = "requirements.txt"
  }

  source {
    content  = file("${path.module}/HttpExample/host.json")
    filename = "host.json"
  }
}

