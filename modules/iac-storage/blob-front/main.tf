resource "azurerm_storage_account" "example" {
  name                     = "azmalalademo"
  resource_group_name      = var.rg_name
  location                 = var.m_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "development"
  }
}

resource "azurerm_storage_container" "az_web" {
  name                  = "$web"
  storage_account_name  = data.azurerm_storage_account.az_storage_front.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "storage_blob_function" {
  name                   = "index.html"
  storage_account_name   = data.azurerm_storage_account.az_storage_front.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "${abspath(path.module)}/EmatFront/dist/index.html"
  # source                 = "${abspath(path.module)}/app/index.html"
}

resource "azurerm_cdn_profile" "example" {
  name                = "ematapp-cdn-profile"
  location            = var.m_location
  resource_group_name = var.m_rg_name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "example" {
  name                = "cdn-endopoint-123"
  profile_name        = azurerm_cdn_profile.example.name
  location            = var.m_location
  resource_group_name = var.m_rg_name
  is_http_allowed     = true
  is_https_allowed     = true

  origin {
    name      = ""
    host_name = ""
    http_port = 80
    https_port = 443
    
  }
}

# # Custom Domain
# resource "azurerm_cdn_endpoint_custom_domain" "myCustomDomain" {
#   name            = "cdnendpoint-cdomain-ematapp-dev"
#   cdn_endpoint_id = azurerm_cdn_endpoint.example.id
#   host_name       = ""
# }

