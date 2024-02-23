# #########################################################
# # Global & Common Variables for Application
# #########################################################
variable "m_location" {
  type        = string
  description = "Location where resources should be deployed"
  default     = "North Europe"
}

variable "rg_name" {
  type        = string
  description = "Resource Group Name"
  default     = "rg-TEPARAZRLD-app-emat-dev"
}

variable "m_appinsights_apptype" {
  type        = string
  description = "App insights application type"
  default     = "web"
}

variable "m_appinsights_isrequired" {
  type        = bool
  description = "Creates application insights when set as True"
  default     = true
}

