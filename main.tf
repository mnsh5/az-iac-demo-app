######################################
#  Main Resource Group of APP        #
######################################
module "az_resource_group" {
  source     = "./modules/Resource_Group"
  m_location = var.m_location
}
