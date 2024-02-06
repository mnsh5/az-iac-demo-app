locals {
  # Prefix used to discriminate among the different environments, e.g., _dev, _stg, _prod.
  environment_postfix   = "_desa"
  project_name          = "emat"
  project_id            = "az-${local.project_name}${replace(local.environment_postfix, "_", "-")}"
  m_location            = "East US"
  # terraform_bucket_name = "az-${local.project_name}${replace(local.environment_postfix, "_", "-")}-terraform-state"
}


######################################
#  Main Resource Group of APP        #
######################################
module "az_resource_group" {
  source     = "./modules/az-rg"
  m_location = local.m_location
}

######################################
#  Main Virtual Network of APP       #
######################################
module "az_virtual_network" {
  source     = "./modules/az-vnet"
  m_location = local.m_location
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

######################################
#  Main Function APP       #
######################################
module "az_function_app" {
  source     = "./modules/az-function_app"
  m_location = local.m_location
}
