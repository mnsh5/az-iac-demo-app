

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
  source     = "./modules/az-vnet"
  depends_on = [module.az_resource_group]
}

########################################
#  Main Network Security Group of APP  #
########################################
module "az_virtual_network" {
  source     = "./modules/az-vnet"
  depends_on = [module.az_resource_group]
}
