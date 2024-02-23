locals {
  # Prefix used to discriminate among the different environments, e.g., _dev, _stg, _prod.
  environment_postfix = "_dev"
  project_name        = "demo"
  project_id          = "${local.project_name}${replace(local.environment_postfix, "_", "-")}" 
  m_location          = "East US"
  rg_name             = "DevOps_AR_${local.project_id}-01"                                     
}

######################################
#  Main Resource Group of APP        #
######################################
module "az_rg" {
  source     = "./modules/iac-rg"
  m_location = local.m_location
  rg_name    = local.rg_name
}

####################################
# Main Virtual Network of APP      #
####################################
module "az_virtual_network" {
  source                          = "./modules/iac-vnet"
  m_location                      = local.m_location
  rg_name                         = local.rg_name
  m_virtual_network_name          = var.m_virtual_network_name
  m_subnet_name                   = var.m_subnet_name
  m_nsg_pub_name                  = var.m_nsg_pub_name
}

###################################
#  Main Function APP              #
###################################
# module "az_func_app" {
#   source    = "./modules/iac-function-app"
#   m_rg_name = local.m_rg_name
# }

###################################
# Main Blob Storage               #
###################################
# module "az_blog_storage" {
#   source     = "./modules/iac-storage"
#   m_location = local.m_location
#   m_rg_name  = local.m_rg_name
# }

###################################
# Main Postgresql Server          #
###################################
# module "az_postgresql_server" {
#   source     = "./modules/iac-postgres"
#   m_location = local.m_location
#   m_rg_name  = local.m_rg_name
#   # m_azurerm_storage_container = var.m_azurerm_storage_container
# }
