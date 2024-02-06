# #########################################################
# # Global & Common Variables for Application
# #########################################################
variable "m_location" {
  type        = string
  description = "Location where resources should be deployed"
  # default     = "East US"
}

variable "rg_name" {
  type        = string
  description = "Resource Group Name"
  # default = "rg-emat-app-dev"
}

variable "az_blob_storage_be" {
  type        = string
  description = "description"
}
