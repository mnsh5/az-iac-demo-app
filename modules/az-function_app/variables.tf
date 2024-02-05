#########################################################
# Global & Common Variables for Application
#########################################################
variable "m_location" {
  type        = string
  description = "Location where resources should be deployed"
  default     = "East US"
}

variable "virtual_network_subnet_id" {
  description = "The ID of the virtual network subnet to use for vNet integration."
  type        = string
  default     = null
}
