# Output name of the resource group created which will be used while creating other resources
output "rg_name" {
  value       = azurerm_resource_group.az_rg.name
  description = "Name of the resource group"
}

output "location" {
  value = azurerm_resource_group.az_rg.location
}
