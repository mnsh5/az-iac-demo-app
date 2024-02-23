output "absolute_path" {
  value = abspath(path.module)
}

output "storage_account_tier" {
  value = data.azurerm_storage_account.az_storage_account_back.account_tier
}
