#########################################################
# Global & Common Variables for Application
#########################################################
variable "rg_name" {
  type        = string
  description = "Resource Group Name"
  # default = "rg-emat-app-dev"
}

variable "m_location" {
  type        = string
  description = "Location where resources should be deployed"
}
