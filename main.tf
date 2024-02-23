locals {
  # Prefix used to discriminate among the different environments, e.g., _dev, _stg, _prod.
  environment_postfix = "_dev"
  project_name        = "demo"
  project_id          = "${local.project_name}${replace(local.environment_postfix, "_", "-")}" # demo-dev
  m_location          = "East US"
  rg_name             = "rg-demo-app-${local.project_id}"                                      # rg-demo-app-dev
}

######################################
#  Main Resource Group of APP        #
######################################
module "az_rg" {
  source     = "./modules/iac-rg"
  m_location = local.m_location
  rg_name  = local.rg_name
}

####################################
# Main Virtual Network of APP      #
####################################
module "az_virtual_network" {
  source                          = "./modules/iac-vnet"
  m_vnet_resource_group           = var.m_vnet_resource_group
  m_virtual_network_name          = var.m_virtual_network_name
  m_subnet_name                   = var.m_subnet_name
  m_nsg_pub_name                  = var.m_nsg_pub_name
  m_nsg_priv_name                 = var.m_nsg_priv_name
  m_route_table_name              = var.m_route_table_name
  m_vnet_location                 = var.m_vnet_location
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
