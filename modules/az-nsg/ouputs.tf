# Output name of the resource group created which will be used while creating other resources
output "az_nsg" {
  value       = azurerm_network_security_group.az_nsg.name
  description = "Name of the Network Security Group"
}

output "nsg_id" {
  value = azurerm_network_security_group.az_nsg.id
}

