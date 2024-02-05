######################################
#  Main Resource Group of APP        #
######################################
module "az_resource_group" {
  source     = "./modules/az-rg"
  m_location = var.m_location
}

######################################
#  Main Virtual Network of APP       #
######################################
module "az_virtual_network" {
  source   = "./modules/az-vnet"
  location = var.m_location
  # depends_on = [module.az_network_security_group]
}

########################################
#  Main Network Security Group of APP  #
########################################
# module "az_network_security_group" {
#   source   = "./modules/az-nsg"
#   location = var.m_location
#   # depends_on = [module.az_resource_group]
# }
