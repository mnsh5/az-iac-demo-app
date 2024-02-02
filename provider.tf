terraform {
  //Terraform Version
  required_version = "1.5.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.90.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "tfstate"
  #   storage_account_name = "tfstate6671"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {} # required
}

