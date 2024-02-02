######################################
#  Main Resource Group of APP        #
######################################
module "az_resource_group" {
  source     = "./modules/az-rg"
  rg_name    = var.rg_name
  m_location = var.m_location
}
