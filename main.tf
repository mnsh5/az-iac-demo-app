locals {
  # Prefix used to discriminate among the different environments, e.g., _dev, _stg, _prod.
  environment_postfix   = "_desa"
  project_name          = "teparazrld-emat"
  project_id            = "az-${local.project_name}${replace(local.environment_postfix, "_", "-")}"
  m_location            = "East US"
  rg_name               = "rg-emat-app-dev"
  terraform_bucket_name = "az-${local.project_name}${replace(local.environment_postfix, "_", "-")}-terraform-state"
}

######################################
#  Main Resource Group of APP        #
######################################
module "az_resource_group" {
  source     = "./modules/iac-rg"
  m_location = local.m_location
  rg_name    = local.rg_name
}

######################################
#  Main Virtual Network of APP       #
######################################
module "az_virtual_network" {
  source     = "./modules/iac-vnet"
  m_location = local.m_location
  rg_name    = module.az_resource_group.rg_name
}

######################################
#  Main Function APP       #
######################################
module "az_function_app" {
  source     = "./modules/iac-function_app"
  m_location = local.m_location
  rg_name    = module.az_resource_group.rg_name
}
