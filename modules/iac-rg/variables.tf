#########################################################
# Global & Common Variables for Application
#########################################################
variable "m_rg_name" {
  type        = string
  description = "Resource Group Name"
  default     = "rg-TEPARAZRLD-app-emat-dev"
}

variable "m_location" {
  type        = string
  description = "Location where resources should be deployed"
  default     = "North Europe"
}
