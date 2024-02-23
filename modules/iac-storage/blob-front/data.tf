data "azurerm_storage_account" "az_storage_front" {
  name                     = "teparazrldematfrontdev"
  resource_group_name      = var.m_rg_name
}

data "archive_file" "app_front" {
  type        = "zip"
  output_path = "${abspath(path.module)}/EmatFront/dist/dist.zip"
  source {
    content  = file("${path.module}/EmatFront/dist/index.html")
    filename = "index.html"
  }
}